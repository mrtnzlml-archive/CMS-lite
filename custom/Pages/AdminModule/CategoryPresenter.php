<?php

namespace Pages\AdminModule\Presenters;

use App;
use Pages\Components\CategoryGrid\ICategoryGridFactory;

class CategoryPresenter extends App\AdminModule\Presenters\BasePresenter
{

	protected function createComponentCategoryGrid(ICategoryGridFactory $factory)
	{
		$control = $factory->create();
		return $control;
	}

}
