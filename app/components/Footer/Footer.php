<?php

namespace App\Components\Footer;

use App\Components\AControl;
use Nette;

class Footer extends AControl
{

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Footer.latte');
	}

}

interface IFooterFactory
{
	/** @return Footer */
	public function create();
}
