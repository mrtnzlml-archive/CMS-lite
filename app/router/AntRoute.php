<?php

namespace App\Router;

use Kdyby\Doctrine\EntityManager;
use Kdyby\Monolog\Logger;
use Nette;
use Nette\Application;
use Url\Url;
use Url\UrlParameter;

//TODO: Automatická koncová lomítka a redirect 301?
class AntRoute extends Nette\Object implements Application\IRouter
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
		$url = $httpRequest->getUrl();
		$basePath = $url->getBasePath();
		if (strncmp($url->getPath(), $basePath, strlen($basePath)) !== 0) {
			return NULL;
		}
		$path = (string)substr($url->getPath(), strlen($basePath));

		// 1) Load route definition (internal destination) from cache
		$destination = $this->cache->load($path, function (& $dependencies) use ($path) {
			$destination = $this->em->getRepository(Url::class)->findOneBy(['fakePath' => $path]);
			if ($destination === NULL) {
				$this->monolog->addError(sprintf('Cannot find route for path %s', $path));
				return NULL;
			}

			$params = [];
			foreach ($destination->parameters as $parameter) {
				$params[$parameter->name] = $parameter->value;
			}
			return [$destination->destination => $params];
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
		return new Application\Request(
			$presenter,
			$httpRequest->getMethod(),
			$httpRequest->getQuery() + ['action' => $action] + $destination[$internalDestination], //params
			$httpRequest->getPost(),
			$httpRequest->getFiles(),
			[Application\Request::SECURED => $httpRequest->isSecured()]
		);
	}

	/**
	 * Constructs absolute URL from Request object.
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
			$params = $applicationRequest->getParameters();
			$destination = $applicationRequest->getPresenterName() . ':' . $params['action'];
//			unset($params['locale']); //FIXME
//			unset($params['action']); //FIXME
//			unset($params['backlink']); //FIXME

			if ($params) {
				$qb = $this->em->getRepository(UrlParameter::class)->createQueryBuilder('up');
				$qb->select('COUNT(up.id) AS total_count');
				$iterator = 0;
				foreach ($params as $key => $value) {
					$qb->orWhere("up.name = :name$iterator AND up.value = :value$iterator");
					$qb->setParameter("name$iterator", $key);
					$qb->setParameter("value$iterator", $value);
					$iterator++;
				}
//				if (count($params) !== (int)$qb->getQuery()->getSingleScalarResult()) {
//					$this->monolog->addError(sprintf('Cannot find route for destination %s', $destination));
//					return NULL;
//				}
			}

			//FIXME: toto fakt bude muset hledat nejen podle destination, ale i podle parametrů
			$path = $this->em->getRepository(Url::class)->findOneBy(['destination' => $destination]);
			return $path;
		});
		if ($path === NULL) {
			return NULL;
		}

		// 2) Construct URL
		if ($this->lastRefUrl !== $refUrl) {
			$scheme = ($this->flags & self::SECURED ? 'https://' : 'http://');
			$this->lastBaseUrl = $scheme . $refUrl->getAuthority() . $refUrl->getBasePath();
			$this->lastRefUrl = $refUrl;
		}
		$url = $this->lastBaseUrl . Nette\Utils\Strings::webalize($path->fakePath, '/');

		// 3) Add parameters to the URL
		$params = $applicationRequest->getParameters();
		unset($params['action']);

//		unset($params['locale']); //FIXME
//		unset($params['slug']); //FIXME
//		unset($params['test']); //FIXME
		$sep = ini_get('arg_separator.input');
		$query = http_build_query($params, '', $sep ? $sep[0] : '&');
		if ($query != '') { // intentionally ==
			$url .= '?' . $query;
		}

		return $url;
	}

}
