<?php

trait ComponentsTrait
{

	/** @var \App\Components\MainMenu\IMainMenuFactory @inject */
	public $mainMenuFactory;

	protected function createComponentMainMenu()
	{
		return $this->mainMenuFactory->create();
	}

	/** @var \App\Components\ContactForm\IContactFormFactory @inject */
	public $contactFormFactory;

	protected function createComponentContactForm()
	{
		return $this->contactFormFactory->create();
	}

	/** @var \App\Components\Css\ICssFactory @inject */
	public $cssFactory;

	protected function createComponentCss()
	{
		return $this->cssFactory->create();
	}

	/** @var \App\Components\Js\IJsFactory @inject */
	public $jsFactory;

	protected function createComponentJs()
	{
		return $this->jsFactory->create();
	}

}
