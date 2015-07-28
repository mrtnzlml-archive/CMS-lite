<?php

namespace Error\DI;

use App\Extensions\CompilerExtension;
use Kdyby\Doctrine\DI\IEntityProvider;

class ErrorExtension extends CompilerExtension implements IEntityProvider
{

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/config.neon');
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();
		$this->setPresenterMapping($builder, ['Error' => 'Error\\*Module\\Presenters\\*Presenter']);
	}

	function getEntityMappings()
	{
		return ['Error' => __DIR__ . '/..'];
	}

}
