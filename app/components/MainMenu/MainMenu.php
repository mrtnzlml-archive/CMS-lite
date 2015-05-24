<?php

namespace App\Components\MainMenu;

use App\Components\AControl;
use Nette;

class MainMenu extends AControl
{

	private $items = [];

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

}

interface IMainMenuFactory
{
	/** @return MainMenu */
	public function create();
}
