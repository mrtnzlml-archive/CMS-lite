<?php

namespace Eshop\DI;

use App\Extensions\InstallHelper;
use Kdyby\Doctrine\EntityManager;
use Nette;

class Install extends Nette\Object
{

	private $urls = [
		'administrace/eshop/zbozi' => 'Eshop:AdminProduct:default',
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
		$this->em->transactional(function () {
			// 1) Add URLs
			foreach ($this->urls as $fakePath => $destination) {
				$this->install->url($fakePath, $destination);
			}

			// 2) Add resources
			$this->install->resource('Eshop:AdminProduct');

			// 3) Create menu items - FIXME: Nebo jen zaregistrovat menu item?
//			$item = (new NavigationItem)->setName('Eshop');
//			$this->navigationFacade->createItem($item, $navigation, md5(MainMenu::class));

			$this->em->flush();
		});
	}

	public function uninstall()
	{
		$this->em->transactional(function () {
			// 1) Remove URLs
			foreach ($this->urls as $fakePath => $destination) {
				$this->install->url($fakePath, $destination, TRUE);
			}

			// 2) Remove resources
			$this->install->resource('Eshop:AdminProduct', TRUE);

			// 3) Delete menu items
//			$item = $this->em->getRepository(NavigationItem::class)->findOneBy(['name' => 'Eshop']); //FIXME: to není moc dobré
//			$this->em->remove($item);

			$this->em->flush();
		});
	}

}
