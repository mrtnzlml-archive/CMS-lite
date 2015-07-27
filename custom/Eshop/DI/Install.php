<?php

namespace Eshop\DI;

use App\Extensions\IInstallExtension;
use App\Extensions\InstallHelper;
use Kdyby\Doctrine\EntityManager;
use Navigation\NavigationItem;
use Nette;
use Url\Url;

class Install extends Nette\Object implements IInstallExtension
{

	private $urls = [
//		'administrace/eshop/zbozi' => 'Eshop:AdminProduct:default',
		'eshop' => 'Eshop:Product:default',
		'produkt' => 'Eshop:Product:detail',
	];

	/** @var EntityManager */
	private $em;

	/** @var InstallHelper */
	private $install;

	public function __construct(EntityManager $em, InstallHelper $install)
	{
		$this->em = $em;
		$this->install = $install;
	}

	public function install()
	{
		// 1) Add URLs
		foreach ($this->urls as $fakePath => $destination) {
			$this->install->url($fakePath, $destination);
		}

		// 2) Add resources
		$this->install->resource('Eshop:AdminProduct');

		// 3) Create menu items
		$item = new NavigationItem;
		$item->setName('Eshop');
		$item->setUrl((new Url)->setDestination('Eshop:AdminProduct:default')->setFakePath('administrace/eshop/zbozi'));
		$this->install->navigationItem($item, 'admin');

		//TODO: instalace schéma databáze

		//TODO: defaultní data
	}

	public function uninstall()
	{
		// 1) Remove URLs
		foreach ($this->urls as $fakePath => $destination) {
			$this->install->url($fakePath, $destination, TRUE);
		}

		// 2) Remove resources
		$this->install->resource('Eshop:AdminProduct', TRUE);

		// 3) Delete menu items
		$item = $this->em->getRepository(NavigationItem::class)->findOneBy(['name' => 'Eshop']); //FIXME: to není moc dobré
		$this->install->navigationItem($item, 'admin', TRUE);
	}

}
