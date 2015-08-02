<?php

namespace Notes\DI;

use App\Extensions\CompilerExtension;
use App\Extensions\Extension;
use App\Extensions\ICustomExtension;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

class NotesExtension extends CompilerExtension implements IEntityProvider, ICustomExtension
{

	public function getExtensionInfo()
	{
		return [(new Extension)->setName(self::class)];
	}

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/config.neon');
	}

	/**
	 * Returns associative array of Namespace => mapping definition
	 *
	 * @return array
	 */
	function getEntityMappings()
	{
		return [
			'Notes' => __DIR__ . '/..',
		];
	}

}
