<?php

namespace Versatile\DI;

use App\Components\ContactForm\Providers\IContactFormTemplateProvider;
use App\Components\Css\Providers\ICssProvider;
use App\Components\Footer\Providers\IFooterTemplateProvider;
use App\Components\Js\Providers\IJsProvider;
use App\Components\MainMenu\Providers\IMainMenuTemplateProvider;
use App\Extensions\IImageProvider;
use Nette;

//TODO: IFaviconProvider, IFontProvider
//TODO: externí styly, scripty a fonty
class VersatileExtension extends Nette\DI\CompilerExtension implements IMainMenuTemplateProvider, IContactFormTemplateProvider,
	ICssProvider, IJsProvider, IImageProvider, IFooterTemplateProvider
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
		foreach (Nette\Utils\Finder::findFiles('*.css')->from(__DIR__ . '/../css') as $key => $file) {
			yield $key;
		}
	}

	public function getJsScripts()
	{
		foreach (Nette\Utils\Finder::findFiles('*.js')->from(__DIR__ . '/../js') as $key => $file) {
			yield $key;
		}
	}

	public function getImagesFolder()
	{
		return realpath(__DIR__ . '/../images');
	}

	public function getFooterTemplate()
	{
		return realpath(__DIR__ . '/../VersatileFooter.latte');
	}

}
