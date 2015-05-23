<?php

namespace App\Components\Footer;

use App\Components\IComponentTemplateProvider;
use App\Traits\PublicComponentsTrait;
use Nette;

class Footer extends Nette\Application\UI\Control implements IComponentTemplateProvider
{

	use PublicComponentsTrait; //FIXME: je toto dobrý nápad?

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
