<?php

namespace Files\DI;

use App\Components\Js\Providers\IJsAdminProvider;
use App\Extensions\CompilerExtension;
use App\Extensions\Extension;
use App\Extensions\ICustomExtension;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

class FilesExtension extends CompilerExtension implements IEntityProvider, ICustomExtension, IJsAdminProvider
{

	public function getExtensionInfo()
	{
		return [(new Extension)->setName(self::class)];
	}

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/services.neon');
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();
		$this->setPresenterMapping($builder, ['Files' => 'Files\\*Module\\Presenters\\*Presenter']);
	}

	public function getEntityMappings()
	{
		return ['Files' => __DIR__ . '/..'];
	}

	public function getJsAdminScripts()
	{
		yield __DIR__ . '/../assets/uploader.js';
	}

}
