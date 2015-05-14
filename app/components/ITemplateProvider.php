<?php

namespace App\Components;

interface ITemplateProvider
{

	/**
	 * @param @param string $templatePath realPath of template file
	 *
	 * @return string
	 */
	public function changeTemplate($templatePath);

}
