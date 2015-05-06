<?php

class CoreExtension extends Nette\DI\CompilerExtension {

	public function beforeCompile() {
		$cb = $this->getContainerBuilder();

		/** @var IMainMenuProvider $extension */
		foreach ($this->compiler->getExtensions(IMainMenuProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IMainMenuFactory::class));
			foreach ($extension->getMenuItems() as $menuItem) {
				$definition->addSetup('addMainMenuItem', [$menuItem]);
			}
		}
	}

}
