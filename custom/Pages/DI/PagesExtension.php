<?php

namespace Pages\DI;

use App\Components\Js\Providers\IJsAdminProvider;
use App\Extensions\CompilerExtension;
use App\Extensions\Extension;
use App\Extensions\ICustomExtension;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

class PagesExtension extends CompilerExtension implements IEntityProvider, IJsAdminProvider, ICustomExtension
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
		$this->setPresenterMapping($builder, ['Pages' => 'Pages\\*Module\\Presenters\\*Presenter']);
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

	public function getJsAdminScripts()
	{
		yield __DIR__ . '/../assets/pages.js';
	}

}
