<?php

namespace App\Components\AdminBar;

use App\Components\AControl;
use Nette;

class AdminBar extends AControl
{

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/AdminBar.latte');
	}

}

interface IAdminBarFactory
{
	/** @return AdminBar */
	function create();
}
