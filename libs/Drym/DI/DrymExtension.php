<?php

namespace Drym\DI;

use App\Components\ContactForm\Providers\IContactFormTemplateProvider;
use App\Components\MainMenu\Providers\IMainMenuTemplateProvider;
use Nette;

class DrymExtension extends Nette\DI\CompilerExtension implements IMainMenuTemplateProvider, IContactFormTemplateProvider
{

	public function getMainMenuTemplate()
	{
		return realpath(__DIR__ . '/../DrymMainMenu.latte');
	}

	public function getContactFormTemplate()
	{
		return realpath(__DIR__ . '/../DrymContactForm.latte');
	}

}
