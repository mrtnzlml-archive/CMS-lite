<?php

namespace Eshop\Components;

use App\Components\AControl;

class LastOrders extends AControl
{

	public function render(array $parameters = NULL)
	{

		$this->template->render(__DIR__ . '/templates/LastOrders.latte');
	}

}

interface ILastOrdersFactory
{
	/** @return LastOrders */
	function create();
}
