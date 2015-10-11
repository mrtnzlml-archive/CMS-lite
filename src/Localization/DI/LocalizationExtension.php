<?php

namespace Localization\DI;

use App\Extensions\CompilerExtension;
use Kdyby\Doctrine\DI\IEntityProvider;

class LocalizationExtension extends CompilerExtension implements IEntityProvider
{

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/config.neon');
	}

	function getEntityMappings()
	{
		return ['Localization' => __DIR__ . '/..'];
	}

}
