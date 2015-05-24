<?php

namespace App\Components;

use App\Traits\PublicComponentsTrait;
use Nette\Application\UI\Control;

abstract class AControl extends Control implements IComponentTemplateProvider
{

	use PublicComponentsTrait;

	protected $templatePath = NULL;

	abstract public function render(array $parameters = NULL);

	/**
	 * @param @param string $templatePath realPath of template file
	 *
	 * @return string
	 */
	public function changeTemplate($templatePath)
	{
		$this->templatePath = $templatePath;
	}

}
