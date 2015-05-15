<?php

use App\Components;

trait ComponentsTrait
{

	use Kdyby\Autowired\AutowireComponentFactories;

	/**
	 * @param Components\MainMenu\IMainMenuFactory $factory
	 *
	 * @return Components\MainMenu\MainMenu
	 */
	protected function createComponentMainMenu(Components\MainMenu\IMainMenuFactory $factory)
	{
		return $factory->create();
	}

	/**
	 * @param Components\ContactForm\IContactFormFactory $factory
	 *
	 * @return Components\ContactForm\ContactForm
	 */
	protected function createComponentContactForm(Components\ContactForm\IContactFormFactory $factory)
	{
		return $factory->create();
	}

	/**
	 * @param Components\Css\ICssFactory $factory
	 *
	 * @return Components\Css\Css
	 */
	protected function createComponentCss(Components\Css\ICssFactory $factory)
	{
		return $factory->create();
	}

	/**
	 * @param Components\Js\IJsFactory $factory
	 *
	 * @return Components\Js\Js
	 */
	protected function createComponentJs(Components\Js\IJsFactory $factory)
	{
		return $factory->create();
	}

}
