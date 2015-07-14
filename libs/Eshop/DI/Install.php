<?php

namespace Eshop\DI;

use Kdyby\Doctrine\EntityManager;
use Kdyby\Monolog\Logger;
use Nette;
use Url\AntRoute;
use Url\Url;

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

	public function __construct(EntityManager $em, Logger $logger, Nette\Caching\IStorage $cacheStorage)
	{
		$this->em = $em;
		$this->logger = $logger;
		$this->cache = new Nette\Caching\Cache($cacheStorage, AntRoute::CACHE_NAMESPACE);
	}

	public function install()
	{
		$this->logger->addInfo('Calling method ' . __METHOD__);
		$this->em->transactional(function () {
			// 1) Add URLs
			foreach ($this->urls as $path => $destination) {
				$url = new \Url\Url;
				$url->setFakePath($path);
				$url->setDestination($destination);
				$this->em->persist($url);
				$this->em->flush($url);
				$this->cache->clean([Nette\Caching\Cache::TAGS => ['route/' . $url->getId()]]);
			}
		});
	}

	public function uninstall()
	{
		$this->logger->addInfo('Calling method ' . __METHOD__);
		$this->em->transactional(function () {
			// 1) Remove URLs
			foreach ($this->urls as $path => $_) {
				$url = $this->em->getRepository(Url::class)->findOneBy(['fakePath' => $path]);
				$this->em->remove($url);
				$this->cache->clean([Nette\Caching\Cache::TAGS => ['route/' . $url->getId()]]);
			}
			$this->em->flush();
		});
	}

}
