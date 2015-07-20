<?php

namespace Eshop\DI;

use App\Extensions\CompilerExtension;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

/**
 * TODO: schéma databáze při instalaci
 * TODO: default data
 */
class EshopExtension extends CompilerExtension implements IEntityProvider
{

	const ESHOP_MENU_PRIORITY = 1000;

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/config.neon');
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();
		$this->setPresenterMapping($builder, ['Eshop' => 'Eshop\\*Module\\Presenters\\*Presenter']);
		$this->registerExtension($builder, self::class);
		$this->addInstallEvent($builder, \Eshop\DI\Install::class, 'install');
		$this->addUninstallEvent($builder, \Eshop\DI\Install::class, 'uninstall');
	}

	/**
	 * Returns associative array of Namespace => mapping definition
	 *
	 * @return array
	 */
	public function getEntityMappings()
	{
		//TODO: schéma by se mělo postavit při instalaci rozšíření
		return [
			'Eshop' => __DIR__ . '/..',
		];
	}

}
