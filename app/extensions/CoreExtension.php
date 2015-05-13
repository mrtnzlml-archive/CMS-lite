<?php

namespace App\Extensions;

use App\Components\MainMenu\IMainMenuFactory;
use App\Components\MainMenu\Providers\IMainMenuProvider;
use App\Components\MainMenu\Providers\IMainMenuTemplateProvider;
use App\Router\IRouterProvider;
use Nette;

class CoreExtension extends Nette\DI\CompilerExtension
{

	private $defaultConfiguration = [
		'https' => TRUE,
	];

	public function beforeCompile()
	{
		$cb = $this->getContainerBuilder();
		$config = $this->getConfig($this->defaultConfiguration);

		/** @var IMainMenuProvider $extension */
		foreach ($this->compiler->getExtensions(IMainMenuProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IMainMenuFactory::class));
			foreach ($extension->getMenuItems() as $menuItem) {
				$definition->addSetup('addMainMenuItem', [$menuItem]);
			}
		}

		/** @var IRouterProvider $extension */
		foreach ($this->compiler->getExtensions(IRouterProvider::class) as $extension) {
			if ($config['https']) {
				Nette\Application\Routers\Route::$defaultFlags = Nette\Application\Routers\Route::SECURED;
			}
			$router = $cb->getDefinition($cb->getByType(Nette\Application\IRouter::class) ?: 'router');
			foreach ($extension->getRouter() as $routerDefinition) {
				$router->addSetup('App\Router\RouterFactory::prependTo($service, ?)', [$routerDefinition]);
			}
		}

		/** @var IMainMenuTemplateProvider $extension */
		foreach ($this->compiler->getExtensions(IMainMenuTemplateProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IMainMenuFactory::class));
			$definition->addSetup('changeTemplate', [$extension->getMainMenuTemplate()]);
		}
	}

	public function afterCompile(Nette\PhpGenerator\ClassType $generatedContainer)
	{
		$config = $this->getConfig($this->defaultConfiguration);
		if ($config['https']) {
			$generatedContainer
				->getMethod('initialize')
				->addBody('Nette\Application\Routers\Route::$defaultFlags = Nette\Application\Routers\Route::SECURED;');
		}
	}

}
