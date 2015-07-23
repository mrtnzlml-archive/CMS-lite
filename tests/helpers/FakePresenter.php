<?php

namespace App\Presenters;

use App\Traits\PublicComponentsTrait;
use Nette;
use Nette\Application\UI;

class FakePresenter extends UI\Presenter
{

	use PublicComponentsTrait;

	public function actionDefault()
	{
		$this->setView('FakeTemplate');
	}

	public function actionAll()
	{
		$this->setView('AllComponentsTemplate');
	}

	public function formatTemplateFiles()
	{
		return [
			__DIR__ . "/$this->view.latte",
		];
	}

}
