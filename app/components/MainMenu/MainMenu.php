<?php

class MainMenu extends Nette\Application\UI\Control {

	private $items = [];

	public function render() {
		$this->template->items = $this->items;
		$this->template->render(__DIR__ . '/MainMenu.latte');
	}

	public function addMainMenuItem(MainMenuItem $item) {
		$this->items[] = $item;
	}

}

interface IMainMenuFactory {

	/** @return MainMenu */
	public function create();

}
