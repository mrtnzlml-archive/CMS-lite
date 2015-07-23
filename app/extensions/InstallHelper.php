<?php

namespace App\Extensions;

use Kdyby\Doctrine\EntityManager;
use Kdyby\Monolog\Logger;
use Nette;
use Url\AntRoute;
use Url\Url;
use Users\Resource;

class InstallHelper extends Nette\Object
{

	/** @var EntityManager */
	protected $em;

	/** @var Logger TODO */
	private $logger;

	/** @var Nette\Caching\Cache */
	private $routeCache;

	/** @var Nette\Caching\Cache */
	private $resourceCache;

	public function __construct(EntityManager $entityManager, Logger $logger, Nette\Caching\IStorage $cacheStorage)
	{
		$this->em = $entityManager;
		$this->logger = $logger;
		$this->routeCache = new Nette\Caching\Cache($cacheStorage, AntRoute::CACHE_NAMESPACE);
		$this->resourceCache = new Nette\Caching\Cache($cacheStorage, AntRoute::CACHE_NAMESPACE);
	}

	public function url($fakePath, $destination, $reverse = FALSE)
	{
		if (!$reverse) {
			$url = new Url;
			$url->setFakePath($fakePath);
			$url->setDestination($destination);
			$this->em->persist($url);
			$this->routeCache->clean([Nette\Caching\Cache::TAGS => ['route/' . $url->getId()]]);
			return;
		}
		$url = $this->em->getRepository(Url::class)->findOneBy(['fakePath' => $fakePath]);
		$this->em->remove($url);
		$this->routeCache->clean([Nette\Caching\Cache::TAGS => ['route/' . $url->getId()]]);
	}

	public function resource($resource_name, $reverse = FALSE)
	{
		if (!$reverse) {
			$resource = new Resource();
			$resource->setName($resource_name);
			$this->em->persist($resource);
			$this->resourceCache->clean([Nette\Caching\Cache::TAGS => [\Users\Authorizator::CACHE_NAMESPACE . '/resources']]);
			return;
		}
		$resource = $this->em->getRepository(Resource::class)->findOneBy(['name' => $resource_name]);
		$this->em->remove($resource);
		$this->resourceCache->clean([Nette\Caching\Cache::TAGS => [\Users\Authorizator::CACHE_NAMESPACE . '/resources']]);
	}

}
