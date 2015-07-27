<?php

namespace Dashboard\Components;

use Nette\Application\UI;

class Advertisement extends UI\Control
{

	public function render()
	{
		$this->template->render(__DIR__ . '/Advertisement.latte');
	}

}

interface IAdvertisementFactory
{
	/** @return Advertisement */
	function create();
}
