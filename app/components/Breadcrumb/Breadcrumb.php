<?php

namespace App\Components\Breadcrumb;

use App\Components\AControl;
use Nette;

class Breadcrumb extends AControl
{

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Breadcrumb.latte');
	}

}

interface IBreadcrumbFactory
{
	/** @return Breadcrumb */
	function create();
}
