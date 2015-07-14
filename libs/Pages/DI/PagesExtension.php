<?php

namespace Pages\DI;

use App\Components\Js\Providers\IJsProvider;
use App\Extensions\CompilerExtension;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

class PagesExtension extends CompilerExtension implements IEntityProvider, IJsProvider
{

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/services.neon');
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();
		$this->registerExtension($builder, self::class);
		$this->setPresenterMapping($builder, ['Pages' => 'Pages\\*Module\\Presenters\\*Presenter']);
	}

	/**
	 * Returns associative array of Namespace => mapping definition
	 *
	 * @return array
	 */
	public function getEntityMappings()
	{
		return [
			'Pages' => __DIR__ . '/..',
		];
	}

	public function getJsScripts()
	{
		//TODO: bude potřeba celé toto přidávání vyřešit lépe (záleží na pořadí)
		yield __DIR__ . '/../assets/grid.js';
	}

}
