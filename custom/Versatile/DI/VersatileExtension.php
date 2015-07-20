<?php

namespace Versatile\DI;

use App\Components\Breadcrumb\Providers\IBreadcrumbTemplateProvider;
use App\Components\Favicon\Providers\IFaviconProvider;
use App\Extensions\IImageProvider;
use App\ITemplateProvider;
use Nette;
use WebFontLoader\Providers\IFontProvider;

class VersatileExtension extends Nette\DI\CompilerExtension implements ITemplateProvider,
	IImageProvider, IFaviconProvider, IBreadcrumbTemplateProvider, IFontProvider
{

	public function beforeCompile()
	{
		$cb = $this->getContainerBuilder();
//		$cb->getDefinition($cb->getByType(IContactFormFactory::class))
//			->addSetup(
//				'$service->onComponentCreation[] = function ($control, $form) {' . "\n" .
//				"\t" . '$form->addText(?, ?)->setType(?);' . "\n" .
//				'}', ['phone', 'Telefonní číslo', 'tel']
//			);
	}

	public function getBreadcrumbTemplate()
	{
		return realpath(__DIR__ . '/../breadcrumb.latte');
	}

	public function getError404Template()
	{
		return realpath(__DIR__ . '/../404.latte');
	}

	public function getFaviconPath()
	{
		return realpath(__DIR__ . '/../images/favicon.ico');
	}

	public function getMainMenuTemplate()
	{
		return realpath(__DIR__ . '/../mainMenu.latte');
	}

	public function getContactFormTemplate()
	{
		return realpath(__DIR__ . '/../contactForm.latte');
	}

	public function getCssStyles()
	{
		foreach (Nette\Utils\Finder::findFiles('*.css', '*.less')->from(__DIR__ . '/../css') as $key => $file) {
			yield $key;
		}
	}

	public function getFonts()
	{
		return [
			'Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic',
			'Montserrat+Alternates:400,700',
		];
	}

	public function getJsScripts()
	{
		//Keep order!
		$scripts = [
			IE_ONLY => 'http://html5shiv.googlecode.com/svn/trunk/html5.js',
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
		foreach ($scripts as $key => $script) {
			yield $key => $script;
		}
	}

	public function getImagesFolder()
	{
		return realpath(__DIR__ . '/../images');
	}

	public function getFooterTemplate()
	{
		return realpath(__DIR__ . '/../footer.latte');
	}

}
