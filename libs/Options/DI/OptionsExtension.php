<?php

namespace Options\DI;

use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

class OptionsExtension extends Nette\DI\CompilerExtension implements IEntityProvider
{

	/**
	 * Returns associative array of Namespace => mapping definition
	 *
	 * @return array
	 */
	public function getEntityMappings()
	{
		return [
			'Options' => __DIR__ . '/..',
		];
	}

}
