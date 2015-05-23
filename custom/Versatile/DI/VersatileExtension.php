<?php

namespace Versatile\DI;

use App\Components\ContactForm\Providers\IContactFormTemplateProvider;
use App\Components\Css\Providers\ICssProvider;
use App\Components\Favicon\Providers\IFaviconProvider;
use App\Components\Footer\Providers\IFooterTemplateProvider;
use App\Components\Js\Providers\IJsProvider;
use App\Components\MainMenu\Providers\IMainMenuTemplateProvider;
use App\Components\Meta\Providers\IMetasProvider;
use App\Extensions\IImageProvider;
use Nette;

class VersatileExtension extends Nette\DI\CompilerExtension implements IMainMenuTemplateProvider, IContactFormTemplateProvider,
	ICssProvider, IJsProvider, IImageProvider, IFooterTemplateProvider, IFaviconProvider, IMetasProvider
{

	public function getMetas()
	{
		return [
			'description' => '', //TODO
		];
	}

	public function getFaviconPath()
	{
		return realpath(__DIR__ . '/../images/favicon.ico');
	}

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
		yield 'https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic';
		yield 'https://fonts.googleapis.com/css?family=Montserrat+Alternates:400,700';
	}

	public function getJsScripts()
	{
		//Keep order!
		$scripts = [
			'https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js',
			__DIR__ . '/../js/bootstrap.min.js',
			__DIR__ . '/../js/jquery.prettyPhoto.js',
			__DIR__ . '/../js/jquery-ui.min.js',
			__DIR__ . '/../js/jquery.twitter.js',
			__DIR__ . '/../js/superfish.min.js',
			__DIR__ . '/../js/jquery.flexslider-min.js',
			__DIR__ . '/../js/animate.js',
			__DIR__ . '/../js/myscript.js',
		];
		foreach ($scripts as $script) {
			yield $script;
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
