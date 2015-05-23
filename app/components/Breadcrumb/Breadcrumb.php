<?php

namespace App\Components\Breadcrumb;

use App\Components\IComponentTemplateProvider;
use Nette;

class Breadcrumb extends Nette\Application\UI\Control implements IComponentTemplateProvider
{

	private $templatePath = NULL;

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Breadcrumb.latte');
	}

	public function changeTemplate($templatePath)
	{
		$this->templatePath = $templatePath;
	}

}

interface IBreadcrumbFactory
{
	/** @return Breadcrumb */
	function create();
}
