<?php

namespace Pages\AdminModule\Presenters;

use App;
use Nette\NotImplementedException;
use Pages\Components\CategoryGrid\ICategoryGridFactory;

class CategoryPresenter extends App\AdminModule\Presenters\BasePresenter
{

	public function actionEdit($id = NULL)
	{
		throw new NotImplementedException;
	}

	protected function createComponentCategoryGrid(ICategoryGridFactory $factory)
	{
		$control = $factory->create();
		return $control;
	}

}
