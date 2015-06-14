<?php

namespace Pages\DI;

use App\Components\Js\Providers\IJsProvider;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

class PagesExtension extends Nette\DI\CompilerExtension implements IEntityProvider, IJsProvider
{

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$config = $this->loadFromFile(__DIR__ . '/services.neon');
		$this->compiler->parseServices($builder, $config);
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
