<?php

namespace App\Presenters;

use Latte;
use Nette;

class HomepagePresenter extends BasePresenter
{

	/** @var Nette\Bridges\ApplicationLatte\ILatteFactory @inject */
	public $latteFactory;

	public function beforeRender()
	{
		parent::beforeRender();

		//What about XSS?
		$textFormDb = '<b>Toto je komponenta vložená z databáze:</b> {control contactForm, param => 42}';

		$latte = $this->latteFactory->create();
		$latte->setLoader(new Latte\Loaders\StringLoader);
		Nette\Bridges\ApplicationLatte\UIMacros::install($latte->getCompiler());
		$rendered = $latte->renderToString($textFormDb, ['_control' => $this]);

		$this->template->text = Nette\Utils\Html::el()->setHtml($rendered);
	}

}
