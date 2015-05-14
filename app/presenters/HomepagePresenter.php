<?php

namespace App\Presenters;

use App\Components\ContactForm\IContactFormFactory;
use App\Components\MainMenu\IMainMenuFactory;
use Latte;
use Nette;

class HomepagePresenter extends Nette\Application\UI\Presenter
{

	//TODO: persistence napříč celou aplikací?
	/** @persistent */
	public $locale;

	/** @var IMainMenuFactory @inject */
	public $mainMenuFactory;

	/** @var IContactFormFactory @inject */
	public $contactFormFactory;

	/** @var Nette\Bridges\ApplicationLatte\ILatteFactory @inject */
	public $latteFactory;

	public function beforeRender()
	{
		//What about XSS?
		$textFormDb = '<b>Toto je komponenta vložená z databáze:</b> {control contactForm, param => 42}';

		$latte = $this->latteFactory->create();
		$latte->setLoader(new Latte\Loaders\StringLoader);
		Nette\Bridges\ApplicationLatte\UIMacros::install($latte->getCompiler());
		$rendered = $latte->renderToString($textFormDb, ['_control' => $this]);

		$this->template->text = Nette\Utils\Html::el()->setHtml($rendered);
	}

	public function createComponentMainMenu()
	{
		return $this->mainMenuFactory->create();
	}

	public function createComponentContactForm()
	{
		return $this->contactFormFactory->create();
	}

}
