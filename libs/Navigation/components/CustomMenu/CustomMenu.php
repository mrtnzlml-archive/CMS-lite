<?php

namespace Navigation;

use Doctrine\Common\Collections\ArrayCollection;
use Kdyby\Doctrine\Collections\ReadOnlyCollectionWrapper;
use Kdyby\Doctrine\EntityManager;
use Nette\Application\UI;

class CustomMenu extends UI\Control
{

	/** @var EntityManager */
	private $em;

	/** @var NavigationFacade */
	private $navigationFacade;

	/** @var ReadOnlyCollectionWrapper */
	private $navigationItems;

	public function __construct(EntityManager $em, NavigationFacade $navigationFacade)
	{
		$this->em = $em;
		$this->navigationFacade = $navigationFacade;
		$this->navigationItems = new ReadOnlyCollectionWrapper(new ArrayCollection([]));
	}

	public function render()
	{
		$this->template->items = $this->navigationItems;
		$this->template->render(__DIR__ . '/CustomMenu.latte');
	}

	public function setIdentifier($identifier)
	{
		$navigation = $this->em->getRepository(Navigation::class)->findOneBy(['identifier' => $identifier]);
		$itemRoot = $this->navigationFacade->findRoot($navigation->getId());
		$itemTree = $this->navigationFacade->getItemTreeBelow($itemRoot->getId());
		if ($itemTree) {
			$this->navigationItems = $itemTree;
		}
	}

}

interface ICustomMenuFactory
{
	/** @return CustomMenu */
	function create();
}
