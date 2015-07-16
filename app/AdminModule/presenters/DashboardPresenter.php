<?php

namespace App\AdminModule\Presenters;

use Eshop\Components\ILastOrdersFactory;
use Notes\Components\INotesFactory;

class DashboardPresenter extends BasePresenter
{

	public function createComponentNotes(INotesFactory $factory)
	{
		return $factory->create($this->user->getId());
	}

	public function createComponentLastOrders(ILastOrdersFactory $factory)
	{
		return $factory->create();
	}

}
