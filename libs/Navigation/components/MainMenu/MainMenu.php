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

		$navigation = $this->em->getRepository(Navigation::class)->findOneBy(['identifier' => 'front']);
		$root_item = $this->navigationFacade->findRoot($navigation->getId());
		$this->template->items = $this->navigationFacade->getItemTreeBelow($root_item->getId());
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/MainMenu.latte');
	}

}

interface IMainMenuFactory
{
	/** @return MainMenu */
	public function create();
}
