<?php

class CoreExtension extends Nette\DI\CompilerExtension
{

	private $defaultConfiguration = [
		'https' => TRUE,
	];

	public function beforeCompile()
	{
		$cb = $this->getContainerBuilder();

		/** @var IMainMenuProvider $extension */
		foreach ($this->compiler->getExtensions(IMainMenuProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IMainMenuFactory::class));
			foreach ($extension->getMenuItems() as $menuItem) {
				$definition->addSetup('addMainMenuItem', [$menuItem]);
			}
		}
	}

	public function afterCompile(Nette\PhpGenerator\ClassType $generatedContainer)
	{
		$config = $this->getConfig($this->defaultConfiguration);
		if ($config['https']) {
			//FIXME: takto to funguje jen pro systémové routy (je to problém?)
			$generatedContainer
				->getMethod('initialize')
				->addBody('Nette\Application\Routers\Route::$defaultFlags = ?;', [Nette\Application\Routers\Route::SECURED]);
		}
	}

}
