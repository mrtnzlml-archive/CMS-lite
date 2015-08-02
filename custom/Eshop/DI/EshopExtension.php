<?php

namespace Eshop\DI;

use App\Extensions\CompilerExtension;
use App\Extensions\Extension;
use App\Extensions\ICustomExtension;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

class EshopExtension extends CompilerExtension implements IEntityProvider, ICustomExtension
{

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/config.neon');
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();
		$this->setPresenterMapping($builder, ['Eshop' => 'Eshop\\*Module\\Presenters\\*Presenter']);
	}

	public function getEntityMappings()
	{
		return ['Eshop' => __DIR__ . '/..'];
	}

	public function getExtensionInfo()
	{
		/** @var Extension $extension */
		$extension = (new Extension)->setName('ANT Eshop');
		$extension->setDescription(<<<DESC
Peckový ANT Eshop, který zvládne všechno...
DESC
		);
		return [
			$extension,
			Install::class,
		];
	}

}
