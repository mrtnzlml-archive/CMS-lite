<?php

namespace App\Presenters;

use App\Traits\PublicComponentsTrait;
use Nette;

class FakePresenter extends Nette\Application\UI\Presenter
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
