<?php

namespace App\Components\Title;

use App\Components;
use Nette;
use Nette\Application\UI;

class Title extends Components\AControl
{

	private $separator = '|';

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->separator = $this->separator;
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Title.latte');
	}

}

interface ITitleFactory
{
	/** @return Title */
	function create();
}
