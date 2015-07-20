<?php

namespace Search\Components;

use App\Components\AControl;

class Search extends AControl
{

	public function render(array $parameters = NULL)
	{
		$this->template->render(__DIR__ . '/Search.latte');
	}

}

interface ISearchFactory
{
	/** @return Search */
	function create();
}
