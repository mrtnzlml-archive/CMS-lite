<?php

use App\Components;

trait ComponentsTrait
{

	use Kdyby\Autowired\AutowireComponentFactories;

	protected function createComponentMainMenu(Components\MainMenu\IMainMenuFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentContactForm(Components\ContactForm\IContactFormFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentCss(Components\Css\ICssFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentJs(Components\Js\IJsFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentDoctype(Components\Doctype\IDoctypeFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentSignInForm(Components\SignInForm\ISignInFormFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentFooter(Components\Footer\IFooterFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentFavicon(Components\Favicon\IFaviconFactory $factory)
	{
		return $factory->create();
	}

}
