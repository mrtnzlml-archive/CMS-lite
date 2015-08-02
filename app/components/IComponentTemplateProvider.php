<?php

namespace App\Components;

interface IComponentTemplateProvider
{

	/**
	 * @param @param string $templatePath realPath of template file
	 *
	 * @return string
	 */
	public function changeTemplate($templatePath);

}
