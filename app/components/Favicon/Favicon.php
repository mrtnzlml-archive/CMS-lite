<?php

namespace App\Components\Favicon;

use App\Components\IComponentTemplateProvider;
use Nette;

class Favicon extends Nette\Application\UI\Control implements IComponentTemplateProvider
{

	private $templatePath = NULL;

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Favicon.latte');
	}

	public function changeTemplate($templatePath)
	{
		$this->templatePath = $templatePath;
	}

}

interface IFaviconFactory
{
	/** @return Favicon */
	public function create();
}
