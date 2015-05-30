<?php

namespace Pages\DI;

use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

class PagesExtension extends Nette\DI\CompilerExtension implements IEntityProvider
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

}
