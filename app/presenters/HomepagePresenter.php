<?php

namespace App\Presenters;

use App\Components\MainMenu\IMainMenuFactory;
use Nette;


class HomepagePresenter extends Nette\Application\UI\Presenter
{

	/** @var IMainMenuFactory @inject */
	public $mainMenuFactory;

	public function createComponentMainMenu()
	{
		return $this->mainMenuFactory->create();
	}

}
