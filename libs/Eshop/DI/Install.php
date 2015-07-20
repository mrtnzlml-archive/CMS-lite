<?php

namespace Eshop\DI;

use Kdyby\Doctrine\EntityManager;
use Kdyby\Monolog\Logger;
use Navigation\NavigationFacade;
use Navigation\NavigationItem;
use Nette;
use Nette\Caching\IStorage;
use Url\AntRoute;
use Url\Url;
use Users\Resource;

class Install extends Nette\Object
{

	private $urls = [
		'administrace/eshop/zbozi' => 'Eshop:AdminProduct:default',
		'eshop' => 'Eshop:Product:default',
		'produkt' => 'Eshop:Product:detail',
	];

	/** @var EntityManager */
	private $em;

	/** @var Logger */
	private $logger;

	/** @var Nette\Caching\Cache */
	private $cache;

	/** @var NavigationFacade */
	private $navigationFacade;

	public function __construct(EntityManager $em, Logger $logger, IStorage $cacheStorage, NavigationFacade $navigationFacade)
	{
		$this->em = $em;
		$this->logger = $logger;
		$this->cache = new Nette\Caching\Cache($cacheStorage, AntRoute::CACHE_NAMESPACE);
		$this->navigationFacade = $navigationFacade;
	}

	public function install()
	{
		$this->logger->addInfo('Calling method ' . __METHOD__);
		$this->em->transactional(function () {
			// 1) Add URLs and delete cache
			foreach ($this->urls as $path => $destination) {
				$url = new Url;
				$url->setFakePath($path);
				$url->setDestination($destination);
				$this->em->persist($url);
				$this->cache->clean([Nette\Caching\Cache::TAGS => ['route/' . $url->getId()]]);
			}

			// 2) Add resources and delete cache
			$this->em->persist((new Resource())->setName('Eshop:AdminProduct'));
			$this->cache->clean([Nette\Caching\Cache::TAGS => [\Users\Authorizator::CACHE_NAMESPACE . '/resources']]);

			// TODO 3) Create menu items
//			$item = (new NavigationItem)->setName('Eshop');
//			$this->navigationFacade->createItem($item, $navigation, md5(MainMenu::class));

			$this->em->flush();
		});
	}

	public function uninstall()
	{
		$this->logger->addInfo('Calling method ' . __METHOD__);
		$this->em->transactional(function () {
			// 1) Remove URLs and delete cache
			foreach ($this->urls as $path => $_) {
				$url = $this->em->getRepository(Url::class)->findOneBy(['fakePath' => $path]);
				$this->em->remove($url);
				$this->cache->clean([Nette\Caching\Cache::TAGS => ['route/' . $url->getId()]]);
			}

			// 2) Remove resources and delete cache
			$resource = $this->em->getRepository(Resource::class)->findOneBy(['name' => 'Eshop:AdminProduct']);
			$this->em->remove($resource);
			$this->cache->clean([Nette\Caching\Cache::TAGS => [\Users\Authorizator::CACHE_NAMESPACE . '/resources']]);

			// 3) Delete menu items
			$item = $this->em->getRepository(NavigationItem::class)->findOneBy(['name' => 'Eshop']); //FIXME: to není moc dobré
			$this->em->remove($item);

			$this->em->flush();
		});
	}

}
