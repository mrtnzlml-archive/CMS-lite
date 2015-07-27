<?php

namespace Dashboard\DI;

use App\Extensions\CompilerExtension;
use Kdyby\Doctrine\DI\IEntityProvider;

class DashboardExtension extends CompilerExtension implements IEntityProvider
{

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/config.neon');
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();
		$this->setPresenterMapping($builder, ['Dashboard' => 'Dashboard\\*Module\\Presenters\\*Presenter']);
	}

	function getEntityMappings()
	{
		return ['Dashboard' => __DIR__ . '/..'];
	}

}
