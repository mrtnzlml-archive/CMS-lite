<?php

namespace App\Components\MainMenu;

use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Pages\Page;
use Pages\Query\PagesQuery;

class MainMenu extends AControl
{

	/** @var EntityManager */
	private $em;

	private $items = [];

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->items = $this->items;

		$query = (new PagesQuery())->withAllAuthors();
		$pages = $this->em->getRepository(Page::class)->fetch($query);
		$pages->setFetchJoinCollection(FALSE);
		$this->template->pages = $pages;

		$this->template->render($this->templatePath ?: __DIR__ . '/templates/MainMenu.latte');
	}

	public function addMainMenuItem(MainMenuItem $item)
	{
		$this->items[] = $item;
	}

}

interface IMainMenuFactory
{
	/** @return MainMenu */
	public function create();
}
