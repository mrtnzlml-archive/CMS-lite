<?php

namespace App\Components\Error404;

use App\Components\AControl;
use Nette;

class Error404 extends AControl
{

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Error404.latte');
	}

}

interface IError404Factory
{
	/** @return Error404 */
	function create();
}
