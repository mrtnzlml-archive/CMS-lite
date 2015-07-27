<?php

namespace App\Extensions;

use Kdyby\Doctrine\EntityManager;
use Kdyby\Monolog\Logger;
use Navigation\Navigation;
use Navigation\NavigationFacade;
use Navigation\NavigationItem;
use Nette;
use Nette\Caching\IStorage;
use Url\AntRoute;
use Url\Url;
use Users\Resource;

class InstallHelper extends Nette\Object
{

	/** @var EntityManager */
	protected $em;

	/** @var Logger */
	private $logger;

	/** @var Nette\Caching\Cache */
	private $routeCache;

	/** @var Nette\Caching\Cache */
	private $resourceCache;

	/** @var NavigationFacade */
	private $navigationFacade;

	public function __construct(EntityManager $entityManager, Logger $logger, IStorage $cacheStorage, NavigationFacade $navigationFacade)
	{
		$this->em = $entityManager;
		$this->logger = $logger;
		$this->routeCache = new Nette\Caching\Cache($cacheStorage, AntRoute::CACHE_NAMESPACE);
		$this->resourceCache = new Nette\Caching\Cache($cacheStorage, AntRoute::CACHE_NAMESPACE);
		$this->navigationFacade = $navigationFacade;
	}

	public function navigationItem(NavigationItem $item, $menuIdentifier, $reverse = FALSE)
	{
		if (!$reverse) {
			$this->logger->addInfo('Installing navigationItem ' . $item->getName());
			$this->navigationFacade->createItem($item, $this->em->getRepository(Navigation::class)->findOneBy(['identifier' => $menuIdentifier]));
			return;
		}
		// Uninstall:
		$this->logger->addInfo('Uninstalling navigationItem ' . $item->getName());
		$this->em->remove($item); //TODO: menuIdentifier
	}

	public function url($fakePath, $destination, $reverse = FALSE)
	{
		if (!$reverse) {
			$url = new Url;
			$url->setFakePath($fakePath);
			$url->setDestination($destination);
			$this->logger->addInfo('Installing URL ' . $fakePath);
			$this->em->safePersist($url);
			$this->routeCache->clean([Nette\Caching\Cache::TAGS => ['route/' . $url->getId()]]);
			return;
		}
		// Uninstall:
		$url = $this->em->getRepository(Url::class)->findOneBy(['fakePath' => $fakePath]);
		if ($url) {
			$this->logger->addInfo('Uninstalling URL ' . $fakePath);
			$this->em->remove($url);
			$this->routeCache->clean([Nette\Caching\Cache::TAGS => ['route/' . $url->getId()]]);
		}
	}

	public function resource($resource_name, $reverse = FALSE)
	{
		if (!$reverse) {
			$resource = new Resource();
			$resource->setName($resource_name);
			$this->logger->addInfo('Installing resource ' . $resource_name);
			$this->em->safePersist($resource);
			$this->resourceCache->clean([Nette\Caching\Cache::TAGS => [\Users\Authorizator::CACHE_NAMESPACE . '/resources']]);
			return;
		}
		// Uninstall:
		$resource = $this->em->getRepository(Resource::class)->findOneBy(['name' => $resource_name]);
		if ($resource) {
			$this->logger->addInfo('Uninstalling resource ' . $resource_name);
			$this->em->remove($resource);
			$this->resourceCache->clean([Nette\Caching\Cache::TAGS => [\Users\Authorizator::CACHE_NAMESPACE . '/resources']]);
		}
	}

}
