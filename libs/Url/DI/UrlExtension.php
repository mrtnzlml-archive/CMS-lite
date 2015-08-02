<?php

namespace Url\DI;

use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

class UrlExtension extends Nette\DI\CompilerExtension implements IEntityProvider
{

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$config = $this->loadFromFile(__DIR__ . '/services.neon');
		$this->compiler->parseServices($builder, $config);

		$builder->removeDefinition('routing.router'); //remove default Nette Router
	}

	/**
	 * Returns associative array of Namespace => mapping definition
	 *
	 * @return array
	 */
	public function getEntityMappings()
	{
		return [
			'Url' => __DIR__ . '/..',
		];
	}

}
