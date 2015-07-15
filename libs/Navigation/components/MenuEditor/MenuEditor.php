<?php

namespace Navigation;

use Kdyby\Doctrine\EntityManager;
use Nette\Application\UI\Control;

class MenuEditor extends Control
{

	/** @var EntityManager */
	private $em;

	/** @var NavigationFacade */
	private $navigationFacade;

	public function __construct(EntityManager $em, NavigationFacade $navigationFacade)
	{
		$this->em = $em;
		$this->navigationFacade = $navigationFacade;
	}

	public function render()
	{
		$adminRoot = $this->em->getRepository(NavigationItem::class)->findOneBy(['name' => NavigationFacade::ROOT_ADMIN]);
		$this->template->adminMenu = $this->navigationFacade->getItemTreeBelow($adminRoot->getId());
		$this->template->navigations = $this->em->getRepository(Navigation::class)->findAll();
		$this->template->render(__DIR__ . '/templates/MenuEditor.latte');
	}

	/**
	 * FIXME: @secured
	 */
	public function handleUpdateNavigation($json)
	{
		if (!$this->presenter->isAjax()) {
			$this->redirect('this');
		}

		$adminRoot = $this->em->getRepository(NavigationItem::class)->findOneBy(['name' => NavigationFacade::ROOT_ADMIN]);
		$this->navigationFacade->recalculatePathsForNode($adminRoot->getId(), Nestable::resolveJson($json));

		$this->redrawControl('adminMenu'); //FIXME: neinvaliduje se, jak na ten snippet lépe ukázat?
	}

}

interface IMenuEditorFactory
{
	/** @return MenuEditor */
	function create();
}
