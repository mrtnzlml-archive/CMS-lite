<?php

namespace Navigation;

use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Nette;

class MainMenu extends AControl
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

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}

		$root = $this->em->getRepository(NavigationItem::class)->findOneBy(['name' => md5(__CLASS__)]);
		$this->template->items = $this->navigationFacade->getItemTreeBelow($root->getId());
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/MainMenu.latte');
	}

}

interface IMainMenuFactory
{
	/** @return MainMenu */
	public function create();
}
