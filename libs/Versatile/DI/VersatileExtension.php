<?php

namespace Versatile\DI;

use App\Components\ContactForm\Providers\IContactFormTemplateProvider;
use App\Components\Css\Providers\ICssProvider;
use App\Components\Js\Providers\IJsProvider;
use App\Components\MainMenu\Providers\IMainMenuTemplateProvider;
use Nette;

class VersatileExtension extends Nette\DI\CompilerExtension implements IMainMenuTemplateProvider, IContactFormTemplateProvider,
	ICssProvider, IJsProvider
{

	public function getMainMenuTemplate()
	{
		return realpath(__DIR__ . '/../VersatileMainMenu.latte');
	}

	public function getContactFormTemplate()
	{
		return realpath(__DIR__ . '/../VersatileContactForm.latte');
	}

	public function getCssStyles()
	{
		$styles = [];
		foreach (Nette\Utils\Finder::findFiles('*.css')->from(__DIR__ . '/../css') as $key => $file) {
			$styles[] = $key;
		}
		return $styles;
	}

	public function getJsScripts()
	{
		$scritps = [];
		foreach (Nette\Utils\Finder::findFiles('*.js')->from(__DIR__ . '/../js') as $key => $file) {
			$scritps[] = $key;
		}
		return $scritps;
	}

}
