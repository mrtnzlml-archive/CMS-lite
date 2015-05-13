<?php

namespace App\Components\MainMenu;

use Nette;

class MainMenu extends Nette\Application\UI\Control
{

	private $items = [];
	private $templatePath = NULL;

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->items = $this->items;
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/MainMenu.latte');
	}

	public function addMainMenuItem(MainMenuItem $item)
	{
		$this->items[] = $item;
	}

	public function changeTemplate($templatePath)
	{
		$this->templatePath = $templatePath;
	}

}

interface IMainMenuFactory
{

	/** @return MainMenu */
	public function create();

}
