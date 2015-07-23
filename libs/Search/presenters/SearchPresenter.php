<?php

namespace Search\Presenters;

use App\AdminModule\Presenters\BasePresenter;
use Search\SearchFacade;

class SearchPresenter extends BasePresenter
{

	/** @var SearchFacade */
	private $sf;

	public function __construct(SearchFacade $sf)
	{
		$this->sf = $sf;
	}

	public function renderDefault($search = NULL)
	{
		if ($search === NULL) {
			$this->redirect(':Admin:Dashboard:default');
		}
		$this->template->result = $this->sf->fulltext($search);
	}

}
