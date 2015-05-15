<?php

trait ComponentsTrait
{

	/** @var \App\Components\MainMenu\IMainMenuFactory @inject */
	public $mainMenuFactory;

	/** @var \App\Components\ContactForm\IContactFormFactory @inject */
	public $contactFormFactory;

	protected function createComponentMainMenu()
	{
		return $this->mainMenuFactory->create();
	}

	protected function createComponentContactForm()
	{
		return $this->contactFormFactory->create();
	}

}
