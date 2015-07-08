<?php

namespace App\Components\Flashes;

use App\Components\AControl;
use Nette;

class Flashes extends AControl
{

	//http://getbootstrap.com/components/#alerts
	const FLASH_SUCCESS = 'success';
	const FLASH_INFO = 'info';
	const FLASH_WARNING = 'warning';
	const FLASH_DANGER = 'danger';

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
