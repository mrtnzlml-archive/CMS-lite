<?php

namespace App\Extensions;

use App\Components\Breadcrumb\IBreadcrumbFactory;
use App\Components\Breadcrumb\Providers\IBreadcrumbTemplateProvider;
use App\Components\ContactForm\IContactFormFactory;
use App\Components\ContactForm\Providers\IContactFormTemplateProvider;
use App\Components\Error404\IError404Factory;
use App\Components\Error404\Providers\IError404TemplateProvider;
use App\Components\Favicon\IFaviconFactory;
use App\Components\Favicon\Providers\IFaviconTemplateProvider;
use App\Components\Flashes\IFlashesFactory;
use App\Components\Flashes\Providers\IFlashesTemplateProvider;
use App\Components\Footer\IFooterFactory;
use App\Components\Footer\Providers\IFooterTemplateProvider;
use App\Components\Header\IHeaderFactory;
use App\Components\Header\Providers\IHeaderTemplateProvider;
use App\Components\MainMenu\IMainMenuFactory;
use App\Components\MainMenu\Providers\IMainMenuTemplateProvider;
use App\Components\SignInForm\ISignInFormFactory;
use App\Components\SignInForm\Providers\ISignInFormTemplateProvider;
use Nette;

class CoreTemplateExtension extends Nette\DI\CompilerExtension
{

	public function beforeCompile()
	{
		$cb = $this->getContainerBuilder();

		/** @var IFlashesTemplateProvider $extension */
		foreach ($this->compiler->getExtensions(IFlashesTemplateProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IFlashesFactory::class));
			$definition->addSetup('changeTemplate', [$extension->getFlashesTemplate()]);
		}

		/** @var IHeaderTemplateProvider $extension */
		foreach ($this->compiler->getExtensions(IHeaderTemplateProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IHeaderFactory::class));
			$definition->addSetup('changeTemplate', [$extension->getHeaderTemplate()]);
		}

		/** @var IMainMenuTemplateProvider $extension */
		foreach ($this->compiler->getExtensions(IMainMenuTemplateProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IMainMenuFactory::class));
			$definition->addSetup('changeTemplate', [$extension->getMainMenuTemplate()]);
		}

		/** @var IContactFormTemplateProvider $extension */
		foreach ($this->compiler->getExtensions(IContactFormTemplateProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IContactFormFactory::class));
			$definition->addSetup('changeTemplate', [$extension->getContactFormTemplate()]);
		}

		/** @var ISignInFormTemplateProvider $extension */
		foreach ($this->compiler->getExtensions(ISignInFormTemplateProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(ISignInFormFactory::class));
			$definition->addSetup('changeTemplate', [$extension->getSignInFormTemplate()]);
		}

		/** @var IFooterTemplateProvider $extension */
		foreach ($this->compiler->getExtensions(IFooterTemplateProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IFooterFactory::class));
			$definition->addSetup('changeTemplate', [$extension->getFooterTemplate()]);
		}

		/** @var IFaviconTemplateProvider $extension */
		foreach ($this->compiler->getExtensions(IFaviconTemplateProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IFaviconFactory::class));
			$definition->addSetup('changeTemplate', [$extension->getFaviconTemplate()]);
		}

		/** @var IError404TemplateProvider $extension */
		foreach ($this->compiler->getExtensions(IError404TemplateProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IError404Factory::class));
			$definition->addSetup('changeTemplate', [$extension->getError404Template()]);
		}

		/** @var IBreadcrumbTemplateProvider $extension */
		foreach ($this->compiler->getExtensions(IBreadcrumbTemplateProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IBreadcrumbFactory::class));
			$definition->addSetup('changeTemplate', [$extension->getBreadcrumbTemplate()]);
		}
	}

}
