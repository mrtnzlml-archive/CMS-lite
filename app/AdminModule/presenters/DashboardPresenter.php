<?php

namespace App\AdminModule\Presenters;

use Notes\Components\INotesFactory;

class DashboardPresenter extends BasePresenter
{

	public function createComponentNotes(INotesFactory $factory)
	{
		return $factory->create($this->user->getId());
	}

}
