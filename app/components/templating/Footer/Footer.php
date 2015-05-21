<?php

namespace App\Components\Footer;

use App\Components\ITemplateProvider;
use Nette;

class Footer extends Nette\Application\UI\Control implements ITemplateProvider
{

	private $templatePath = NULL;

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Footer.latte');
	}

	public function changeTemplate($templatePath)
	{
		$this->templatePath = $templatePath;
	}

}

interface IFooterFactory
{
	/** @return Footer */
	public function create();
}
