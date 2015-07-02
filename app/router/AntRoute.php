<?php

namespace App\Router;

use Kdyby\Doctrine\EntityManager;
use Kdyby\Monolog\Logger;
use Nette;
use Nette\Application;

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
	 * Maps HTTP request to a Request object.
	 * @return Nette\Application\Request|NULL
	 */
	public function match(Nette\Http\IRequest $httpRequest)
	{
		$url = $httpRequest->getUrl();
		$basePath = $url->getBasePath();
		if (strncmp($url->getPath(), $basePath, strlen($basePath)) !== 0) {
			return NULL;
		}
		$path = (string)substr($url->getPath(), strlen($basePath));

		$destination = $this->cache->load($path, function (& $dependencies) use ($path) {
			$destination = $this->em->getRepository(Url::class)->findOneBy(['fakePath' => $path]);
			if ($destination === NULL) {
				$this->monolog->addError(sprintf('Cannot find route for path %s', $path));
				return NULL;
			}
			return $destination->destination;
		});

		if ($destination === NULL) {
			return NULL;
		}

		$pos = strrpos($destination, ':');
		$presenter = substr($destination, 0, $pos);
		$action = substr($destination, $pos + 1);

		return new Application\Request(
			$presenter,
			$httpRequest->getMethod(),
			['action' => $action] + $httpRequest->getQuery(),
			$httpRequest->getPost(),
			$httpRequest->getFiles(),
			[Application\Request::SECURED => $httpRequest->isSecured()]
		);
	}

	/**
	 * Constructs absolute URL from Request object.
	 * @return string|NULL
	 */
	public function constructUrl(Application\Request $applicationRequest, Nette\Http\Url $refUrl)
	{
		if ($this->flags & self::ONE_WAY) {
			return NULL;
		}

		$params = $applicationRequest->getParameters();
		$destination = $applicationRequest->getPresenterName() . ':' . $params['action'];

		$path = $this->cache->load($destination, function (& $dependencies) use ($destination) {
			$path = $this->em->getRepository(Url::class)->findOneBy(['destination' => $destination]);
			if ($path === NULL) {
				$this->monolog->addError(sprintf('Cannot find route for destination %s', $destination));
				return NULL;
			}
			return $path = $path->fakePath ?: ''; //nesmí vracet NULL
		});

		if ($path === NULL) {
			return NULL;
		}

		if ($this->lastRefUrl !== $refUrl) {
			$scheme = ($this->flags & self::SECURED ? 'https://' : 'http://');
			$this->lastBaseUrl = $scheme . $refUrl->getAuthority() . $refUrl->getBasePath();
			$this->lastRefUrl = $refUrl;
		}

//		$path = strtr($path, [ //TODO: speciální parametry v URL
//			'%test%' => 'OK',
//		]);

		$url = $this->lastBaseUrl . Nette\Utils\Strings::webalize($path, '/');

		//TODO: cool parametry v adrese

		$params = $applicationRequest->getParameters();
		unset($params['action']);
		$sep = ini_get('arg_separator.input');
		$query = http_build_query($params, '', $sep ? $sep[0] : '&');
		if ($query != '') { // intentionally ==
			$url .= '?' . $query;
		}

		return $url;
	}

}
