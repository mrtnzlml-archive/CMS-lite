<?php

namespace App\Extensions;

use Nette;
use WebFontLoader\Components\IWebFontLoaderFactory;
use WebFontLoader\Providers\IFontProvider;

class FontsExtension extends Nette\DI\CompilerExtension
{

	public function beforeCompile()
	{
		$cb = $this->getContainerBuilder();

		/** @var IFontProvider $extension */
		foreach ($this->compiler->getExtensions(IFontProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IWebFontLoaderFactory::class));
			$fonts = $extension->getFonts();
			if ($fonts instanceof \Traversable || is_array($fonts)) {
				foreach ($extension->getFonts() as $key => $script) {
					$definition->addSetup('addFont', [$script]);
				}
			} else {
				throw new Nette\InvalidArgumentException(sprintf('Fonts must be in array or traversable object, %s given.', gettype($fonts)));
			}
		}
	}

}
