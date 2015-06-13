<?php

namespace App\AdminModule\Presenters;

use Options\Components\OptionsForm\IOptionsFormFactory;
use Options\Components\OptionsMenu\IOptionsMenuFactory;

class OptionsPresenter extends BasePresenter
{

	protected function createComponentOptionsMenu(IOptionsMenuFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentGeneralSettings(IOptionsFormFactory $factory)
	{
		return $factory->create('general');
	}

	protected function createComponentSeoSettings(IOptionsFormFactory $factory)
	{
		return $factory->create('seo');
	}

}
