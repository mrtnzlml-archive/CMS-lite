<?php

namespace Navigation;

use Kdyby\Doctrine\EntityManager;
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
		$adminNavigation = $this->em->getRepository(Navigation::class)->findOneBy(['identifier' => 'admin']);
		$adminItemRoot = $this->navigation->findRoot($adminNavigation->getId());
		$this->template->menuItems = $this->navigation->getItemTreeBelow($adminItemRoot->getId());
		$this->template->render(__DIR__ . '/AdminMenu.latte');
	}

}

interface IAdminMenuFactory
{
	/** @return AdminMenu */
	function create();
}
