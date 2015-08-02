<?php

namespace App\Components\MainMenu;

use App\Components\AControl;
use Nette;

class Wrapper extends AControl
{

	protected $templateBelowPath = NULL;

	public function render(array $parameters = NULL)
	{
		$this->renderAbove($parameters);
	}

	public function renderAbove(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/WrapperAbove.latte');
	}

	public function renderBelow(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templateBelowPath ?: __DIR__ . '/templates/WrapperBelow.latte');
	}

	public function changeBelowTemplate($templateBelowPath)
	{
		$this->templateBelowPath = $templateBelowPath;
	}

}

interface IWrapperFactory
{
	/** @return Wrapper */
	public function create();
}
