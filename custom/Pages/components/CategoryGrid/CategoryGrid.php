<?php

namespace Pages\Components\CategoryGrid;

use Nette\Application\UI;

class CategoryGrid extends UI\Control
{

	public function render()
	{
		$this->template->render(__DIR__ . '/CategoryGrid.latte');
	}

}

interface ICategoryGridFactory
{
	/** @return CategoryGrid */
	function create();
}
