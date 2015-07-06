<?php

namespace Url;

use Kdyby\Doctrine\EntityManager;
use Kdyby\Monolog\Logger;
use Nette;
use Nette\Application;

class AntRoute extends Application\Routers\RouteList
{

	/** @var EntityManager */
	private $em;

	/** @var Nette\Caching\Cache */
	private $cache;

	/** @var Logger */
	private $monolog;

	private $flags;

	/** @var Nette\Http\Url|NULL */
	private $lastRefUrl;

	/** @var string */
	private $lastBaseUrl;

	public function __construct(EntityManager $em, Nette\Caching\IStorage $cacheStorage, Logger $monolog)
	{
		$this->em = $em;
		$this->cache = new Nette\Caching\Cache($cacheStorage, 'ANT.Router');
		$this->monolog = $monolog;
		$this->flags = Nette\Application\Routers\Route::$defaultFlags;
	}

	/**
	 * Maps HTTP request to a Application Request object.
	 *
	 * @param Nette\Http\IRequest $httpRequest
	 *
	 * @return Application\Request|NULL
	 */
	public function match(Nette\Http\IRequest $httpRequest)
	{
		/** @var Application\IRouter $route */
		foreach ($this as $route) { //because of \Kdyby\Console\CliRouter::prependTo
			/** @var Application\Request $applicationRequest */
			$applicationRequest = $route->match($httpRequest);
			if ($applicationRequest !== NULL) {
				return $applicationRequest;
			}
		}

		$url = $httpRequest->getUrl();
		$host = $url->getHost(); //TODO: jazykové mutace na základě domény + na stejné doméně!
		$basePath = $url->getBasePath();
		if (strncmp($url->getPath(), $basePath, strlen($basePath)) !== 0) {
			return NULL;
		}
		$path = (string)substr($url->getPath(), strlen($basePath));
		if ($path !== '') {
			$path = rtrim(rawurldecode($path), '/'); //TODO: další koncovky podle nastavení
		}

		// 1) Load route definition (internal destination) from cache
		$destination = $this->cache->load($path, function (& $dependencies) use ($path) {
			$destination = $this->em->getRepository(Url::class)->findOneBy(['fakePath' => $path]);
			if ($destination === NULL) {
				$this->monolog->addError(sprintf('Cannot find route for path %s', $path));
				return NULL;
			}
			return [$destination->destination => $destination->internalId];
		});
		if ($destination === NULL) {
			return NULL;
		}

		// 2) Extract parts of the destination
		$internalDestination = key($destination);
		$pos = strrpos($internalDestination, ':');
		$presenter = substr($internalDestination, 0, $pos);
		$action = substr($internalDestination, $pos + 1);

		// 3) Create Application Request
		$params = $httpRequest->getQuery();
		$params['action'] = $action;
		if ($destination[$internalDestination]) {
			$params['id'] = $destination[$internalDestination];
		}
		return new Application\Request(
			$presenter,
			$httpRequest->getMethod(),
			$params,
			$httpRequest->getPost(),
			$httpRequest->getFiles(),
			[Application\Request::SECURED => $httpRequest->isSecured()]
		);
	}

	/**
	 * Constructs absolute URL from Application Request object.
	 *
	 * @param Application\Request $applicationRequest
	 * @param Nette\Http\Url $refUrl
	 *
	 * @return NULL|string
	 */
	public function constructUrl(Application\Request $applicationRequest, Nette\Http\Url $refUrl)
	{
		if ($this->flags & self::ONE_WAY) {
			return NULL;
		}

		// 1) Load path (public) from cache
		$path = $this->cache->load($applicationRequest, function (& $dependencies) use ($applicationRequest) {
			$fallback = FALSE;
			$params = $applicationRequest->getParameters();
			$destination = $applicationRequest->getPresenterName() . ':' . $params['action'];
			$internalId = isset($params['id']) ? $params['id'] : NULL;

			// 1) pokud není předáno ID, pokusit se najít pouze path na základě destination (ID je volitelné)
			// 2) pokud je předáno i ID, tak najít path na základe destination i internalId
			// 3) může se stát, že je předáno ID (bod 2), ale nebylo nic nalezeno, pak předat destination, jak by ID nebylo předáno a pověsit parametry za otazník
			if (!isset($params['id'])) {
				$path = $this->em->getRepository(Url::class)->findOneBy([
					'destination' => $destination,
				]);
			} else {
				$path = $this->em->getRepository(Url::class)->findOneBy([
					'destination' => $destination,
					'internalId' => $internalId,
				]);
				if ($path === NULL) {
					//FIXME: v tomto případě by se to nemělo ukládat do cache
					$this->monolog->addWarning(sprintf('Cannot find cool route for destination %s. Fallback will be used.', $destination), [
						'internalId' => $internalId,
					]); //FIXME: logovat / nelogovat?
					$fallback = TRUE;
					$path = $this->em->getRepository(Url::class)->findOneBy([
						'destination' => $destination,
					]);
				}
			}

			if ($path === NULL) {
				$this->monolog->addError(sprintf('Cannot find route for destination %s', $destination), [
					'internalId' => $internalId,
				]);
				return NULL;
			}
			return [$path->getFakePath() => $fallback];
		});
		//if $path === NULL return?

		// 2) Construct URL
		if ($this->lastRefUrl !== $refUrl) {
			$scheme = ($this->flags & self::SECURED ? 'https://' : 'http://');
			$this->lastBaseUrl = $scheme . $refUrl->getAuthority() . $refUrl->getBasePath();
			$this->lastRefUrl = $refUrl;
		}
		$url = $this->lastBaseUrl . Nette\Utils\Strings::webalize(key($path), '/');

		// 3) Add parameters to the URL
		$params = $applicationRequest->getParameters();
		if (!$path[key($path)]) { //fallback in case it's not possible to find any route
			unset($params['action']);
			unset($params['id']);
		}
		$sep = ini_get('arg_separator.input');
		$query = http_build_query($params, '', $sep ? $sep[0] : '&');
		if ($query != '') { // intentionally ==
			$url .= '?' . $query;
		}

		return $url; //TODO: další koncovky podle nastavení
	}

}
