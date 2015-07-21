<?php

namespace Navigation\Presenters;

use App\AdminModule\Presenters\BasePresenter;
use Navigation\IMenuEditorFactory;

class NavigationPresenter extends BasePresenter
{

	public function createComponentMenuEditor(IMenuEditorFactory $factory)
	{
		return $factory->create();
	}

}
