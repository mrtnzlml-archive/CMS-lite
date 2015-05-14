<?php

namespace App\Extensions;

use App\Components\ContactForm\IContactFormFactory;
use App\Components\ContactForm\Providers\IContactFormTemplateProvider;
use App\Components\MainMenu\IMainMenuFactory;
use App\Components\MainMenu\Providers\IMainMenuTemplateProvider;
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
	}

}
