<?php

namespace App\Components\Error404;

use App\Components\IComponentTemplateProvider;
use Nette;

class Error404 extends Nette\Application\UI\Control implements IComponentTemplateProvider
{

	private $templatePath = NULL;

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Error404.latte');
	}

	public function changeTemplate($templatePath)
	{
		$this->templatePath = $templatePath;
	}

}

interface IError404Factory
{
	/** @return Error404 */
	function create();
}
