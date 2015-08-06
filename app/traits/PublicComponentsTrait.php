<?php

namespace App\Traits;

use App\Components;
use Kdyby;
use Navigation\ICustomMenuFactory;
use Navigation\IMainMenuFactory;
use WebFontLoader\Components\IWebFontLoaderFactory;

/**
 * !!! POZOR !!!
 *
 * Tuto traitu je možné použivat jen pro komponenty, které jsou veřejně přístupné pro kohokoliv!
 *
 * !!! POZOR !!!
 */
trait PublicComponentsTrait
{

	use Kdyby\Autowired\AutowireComponentFactories;

	protected function createComponentCustomMenu(ICustomMenuFactory $factory)
	{
		return $factory->create();
	}


	protected function createComponentWebFontLoader(IWebFontLoaderFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentAdminBar(Components\AdminBar\IAdminBarFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentBreadcrumb(Components\Breadcrumb\IBreadcrumbFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentTitle(Components\Title\ITitleFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentWrapper(Components\MainMenu\IWrapperFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentFlashes(Components\Flashes\IFlashesFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentHeader(Components\Header\IHeaderFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentError404(Components\Error404\IError404Factory $factory)
	{
		return $factory->create();
	}

	protected function createComponentMainMenu(IMainMenuFactory $factory)
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

	protected function createComponentMeta(Components\Meta\IMetaFactory $factory)
	{
		return $factory->create();
	}

}
