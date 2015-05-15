<?php

namespace App\Extensions;

use App\Components\Css\ICssFactory;
use App\Components\Css\Providers\ICssProvider;
use Nette;

class StylesheetExtension extends Nette\DI\CompilerExtension
{

	public function beforeCompile()
	{
		$cb = $this->getContainerBuilder();

		/** @var ICssProvider $extension */
		foreach ($this->compiler->getExtensions(ICssProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(ICssFactory::class));
			$definition->addSetup('setStyles', [$extension->getCssStyles()]);
		}
	}

}
