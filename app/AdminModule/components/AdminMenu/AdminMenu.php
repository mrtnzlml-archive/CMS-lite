<?php

namespace App\AdminModule\Components;

use Nette;
use Nette\Application\UI;

class AdminMenu extends UI\Control
{

	public function render()
	{
		$this->template->render(__DIR__ . '/templates/AdminMenu.latte');
	}

}

interface IAdminMenuFactory
{
	/** @return AdminMenu */
	function create();
}
