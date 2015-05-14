<?php

namespace App\Components;

interface ITemplateProvider
{

	/**
	 * @param array $parameters
	 */
	public function render(array $parameters = NULL);

	/**
	 * @param string $templatePath realPath of template file
	 */
	public function changeTemplate($templatePath);

}
