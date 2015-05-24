<?php

namespace App\Components\Favicon;

use App\Components\AControl;
use Nette;

class Favicon extends AControl
{

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Favicon.latte');
	}

}

interface IFaviconFactory
{
	/** @return Favicon */
	public function create();
}
