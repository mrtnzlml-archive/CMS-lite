<?php

namespace App\Extensions;

use App\Components\MainMenu\IMainMenuFactory;
use App\Components\MainMenu\Providers\IMainMenuProvider;
use App\Components\Meta\IMetaFactory;
use App\Components\Meta\Providers\IMetasProvider;
use App\Router\IRouterProvider;
use Nette;

class CoreExtension extends Nette\DI\CompilerExtension
{

	private $defaultConfiguration = [
		'https' => TRUE,
//		'debugger' => TRUE,
	];

	/** @var bool */
	private $debugMode;

	public function __construct($debugMode = FALSE)
	{
		$this->debugMode = $debugMode;
	}

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

		/** @var IMetasProvider $extension */
		foreach ($this->compiler->getExtensions(IMetasProvider::class) as $extension) {
			$definition = $cb->getDefinition($cb->getByType(IMetaFactory::class));
			$definition->addSetup('setMetas', [$extension->getMetas()]);
		}
	}

	public function afterCompile(Nette\PhpGenerator\ClassType $generatedContainer)
	{
		$cb = $this->getContainerBuilder();
		$initialize = $generatedContainer->getMethod('initialize');
		$config = $this->getConfig($this->defaultConfiguration);

		if ($config['https']) {
			$initialize->addBody('Nette\Application\Routers\Route::$defaultFlags = Nette\Application\Routers\Route::SECURED;');
		}
	}

}
