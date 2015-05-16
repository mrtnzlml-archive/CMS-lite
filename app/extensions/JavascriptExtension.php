<?php

namespace App\Extensions;

use App\Components\Js\IJsFactory;
use App\Components\Js\Providers\IJsProvider;
use Nette;

class JavascriptExtension extends Nette\DI\CompilerExtension
{

	public function beforeCompile()
	{
		$cb = $this->getContainerBuilder();

		/** @var IJsProvider $extension */
		foreach ($this->compiler->getExtensions(IJsProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IJsFactory::class));
			$scripts = $extension->getJsScripts();
			if ($scripts instanceof \Generator) {
				foreach ($extension->getJsScripts() as $style) {
					$definition->addSetup('addScript', [$style]);
				}
			} else {
				$definition->addSetup('setScripts', [$scripts]);
			}
		}
	}

}
