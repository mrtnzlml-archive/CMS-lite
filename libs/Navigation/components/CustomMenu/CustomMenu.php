<?php

namespace Navigation;

use Doctrine\Common\Collections\ArrayCollection;
use Kdyby\Doctrine\Collections\ReadOnlyCollectionWrapper;
use Kdyby\Doctrine\EntityManager;
use Nette\Application\UI;

class CustomMenu extends UI\Control
{

	/** @var ReadOnlyCollectionWrapper */
	private $navigation_items;

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
		$this->navigation_items = new ReadOnlyCollectionWrapper(new ArrayCollection([]));
	}

	public function render()
	{
		$this->template->items = $this->navigation_items;
		$this->template->render(__DIR__ . '/CustomMenu.latte');
	}

	public function setIdentifier($identifier)
	{
		$navigation = $this->em->getRepository(Navigation::class)->findOneBy(['identifier' => $identifier]);
		if ($navigation) {
			$this->navigation_items = $navigation->items; //FIXME: bez kořene
		}
	}

}

interface ICustomMenuFactory
{
	/** @return CustomMenu */
	function create();
}
