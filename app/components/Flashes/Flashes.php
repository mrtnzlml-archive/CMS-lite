<?php

namespace App\Components\Flashes;

use App\Components\AControl;
use Nette;

class Flashes extends AControl
{

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}

		$flashes = $this->getPresenter()->getTemplate()->flashes;
		$this->template->flashes = $flashes;

		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Flashes.latte');
	}

}

interface IFlashesFactory
{
	/** @return Flashes */
	public function create();
}
