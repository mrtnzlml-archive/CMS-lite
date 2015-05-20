<?php

namespace App\Presenters;

use Nette;
use WebLoader;

abstract class BasePresenter extends Nette\Application\UI\Presenter
{

	use \ComponentsTrait;

	/** @persistent */
	public $locale;

	public function beforeRender()
	{
		$this->template->locale = $this->locale;
	}

}
