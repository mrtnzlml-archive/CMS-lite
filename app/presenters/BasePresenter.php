<?php

namespace App\Presenters;

use App\Traits\PublicComponentsTrait;
use Nette;
use WebLoader;

abstract class BasePresenter extends Nette\Application\UI\Presenter
{

	use PublicComponentsTrait;

	/** @persistent */
	public $locale;

	public function beforeRender()
	{
		$this->template->locale = $this->locale;
	}

}
