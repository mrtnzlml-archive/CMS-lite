<?php

namespace App\Components\Header;

use App\Components;
use Nette;
use Nette\Application\UI;

class Header extends Components\AControl
{

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Header.latte');
	}

}

interface IHeaderFactory
{
	/** @return Header */
	function create();
}
