<?php

namespace App\Extensions;

use App\Components\ContactForm\IContactFormFactory;
use App\Components\ContactForm\Providers\IContactFormTemplateProvider;
use App\Components\Favicon\IFaviconFactory;
use App\Components\Favicon\Providers\IFaviconTemplateProvider;
use App\Components\Footer\IFooterFactory;
use App\Components\Footer\Providers\IFooterTemplateProvider;
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
	}

}
