<?php

namespace App\Extensions;

use App\Components\Css\ICssFactory;
use App\Components\Css\Providers\ICssAdminProvider;
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
			$styles = $extension->getCssStyles();
			if ($styles instanceof \Traversable || is_array($styles)) {
				foreach ($extension->getCssStyles() as $style) {
					if (Nette\Utils\Validators::isUrl($style)) {
						$definition->addSetup('addExternalStyle', [$style]);
					} else {
						$definition->addSetup('addStyle', [$style]);
					}
				}
			} else {
				throw new Nette\InvalidArgumentException(
					sprintf('Styles must be in array or traversable object, %s given.', gettype($styles))
				);
			}
		}

		/** @var ICssAdminProvider $extension */
		foreach ($this->compiler->getExtensions(ICssAdminProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(ICssFactory::class));
			$styles = $extension->getCssAdminStyles();
			if ($styles instanceof \Traversable || is_array($styles)) {
				foreach ($extension->getCssAdminStyles() as $style) {
					if (Nette\Utils\Validators::isUrl($style)) {
						$definition->addSetup('addExternalAdminStyle', [$style]);
					} else {
						$definition->addSetup('addAdminStyle', [$style]);
					}
				}
			} else {
				throw new Nette\InvalidArgumentException(
					sprintf('Styles must be in array or traversable object, %s given.', gettype($styles))
				);
			}
		}
	}

}
