<?php

namespace Users\Presenters;

use App\AdminModule\Presenters\BasePresenter;
use Users\Components\UsersGrid\IUsersGridFactory;

class UsersPresenter extends BasePresenter
{

	public function createComponentUsersGrid(IUsersGridFactory $factory)
	{
		return $factory->create();
	}

}
