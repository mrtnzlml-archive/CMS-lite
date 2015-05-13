<?php

namespace App\Presenters;

use App\Components\MainMenu\IMainMenuFactory;
use Nette;

class HomepagePresenter extends Nette\Application\UI\Presenter
{

	/** @var IMainMenuFactory @inject */
	public $mainMenuFactory;

	public function beforeRender()
	{
		$texy = new \Texy();

		//What about XSS?
		$textFormDb = '<b>Toto je komponenta vložená z databáze:</b> {control mainMenu, param => 42}';

		$latte = new \Latte\Engine;
		$latte->setLoader(new \Latte\Loaders\StringLoader);
		$latte->onCompile[] = function ($latte) {
			\Nette\Bridges\ApplicationLatte\UIMacros::install($latte->getCompiler());
		};
		$rendered = $latte->renderToString($textFormDb, ['_control' => $this]);

		$this->template->text = Nette\Utils\Html::el()->setHtml($texy->process($rendered));
	}

	public function createComponentMainMenu()
	{
		return $this->mainMenuFactory->create();
	}

}
