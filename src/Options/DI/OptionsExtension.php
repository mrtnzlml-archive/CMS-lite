<?php

namespace Options\DI;

use App\Extensions\CompilerExtension;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

class OptionsExtension extends CompilerExtension implements IEntityProvider
{

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/services.neon');
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();
		$this->setPresenterMapping($builder, ['Options' => 'Options\\*Module\\Presenters\\*Presenter']);
	}

	public function getEntityMappings()
	{
		return ['Options' => __DIR__ . '/..'];
	}

}
