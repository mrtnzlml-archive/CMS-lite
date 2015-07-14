<?php

namespace App\AdminModule\Components;

use Kdyby\Doctrine\EntityManager;
use Navigation\NavigationFacade;
use Navigation\NavigationItem;
use Nette;
use Nette\Application\UI;

class AdminMenu extends UI\Control
{

	/** @var NavigationFacade */
	private $navigation;

	/** @var EntityManager */
	private $em;

	public function __construct(NavigationFacade $navigation, EntityManager $em)
	{
		parent::__construct();
		$this->navigation = $navigation;
		$this->em = $em;
	}

	public function render()
	{
		/** @var NavigationItem $adminRoot */
		$adminRoot = $this->em->getRepository(NavigationItem::class)->findOneBy(['name' => NavigationFacade::ROOT_ADMIN]);
		$this->template->menuItems = $this->navigation->getItemTreeBelow($adminRoot->getId());
		$this->template->render(__DIR__ . '/templates/AdminMenu.latte');
	}

}

interface IAdminMenuFactory
{
	/** @return AdminMenu */
	function create();
}
