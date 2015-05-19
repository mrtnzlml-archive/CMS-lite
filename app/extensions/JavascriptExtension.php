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
			if ($scripts instanceof \Traversable || is_array($scripts)) {
				foreach ($extension->getJsScripts() as $script) {
					$definition->addSetup('addScript', [$script]);
				}
			} else {
				throw new Nette\InvalidArgumentException(sprintf('Scripts must be in array or traversable object, %s given.', gettype($scripts)));
			}
		}
	}

}
