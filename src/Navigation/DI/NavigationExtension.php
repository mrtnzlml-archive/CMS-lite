<?php

namespace Navigation\DI;

use App\Extensions\CompilerExtension;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

class NavigationExtension extends CompilerExtension implements IEntityProvider
{

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/config.neon');
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();
		$this->setPresenterMapping($builder, ['Navigation' => 'Navigation\\*Module\\Presenters\\*Presenter']);

		$definition = $builder->getDefinition('latte.latteFactory');
		$definition->addSetup('?->onCompile[] = function($engine) { Navigation\Latte\Menu::install($engine->getCompiler()); }', ['@self']);
	}

	/**
	 * Returns associative array of Namespace => mapping definition
	 *
	 * @return array
	 */
	function getEntityMappings()
	{
		return [
			'Navigation' => __DIR__ . '/..',
		];
	}

}
