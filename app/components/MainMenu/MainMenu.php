<?php

class MainMenu extends Nette\Application\UI\Control
{

	private $items = [];
	private $templatePath = NULL;

	public function render()
	{
		$this->template->items = $this->items;
		$this->template->render($this->templatePath ?: __DIR__ . '/MainMenu.latte');
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
