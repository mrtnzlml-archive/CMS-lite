<?php

namespace Eshop\DI;

use App\Extensions\CompilerExtension;
use App\Extensions\Extension;
use App\Extensions\ICustomExtension;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

/**
 * TODO: schéma databáze při instalaci
 * TODO: default data
 */
class EshopExtension extends CompilerExtension implements IEntityProvider, ICustomExtension
{

	public function getExtensionInfo()
	{
		/** @var Extension $extension */
		$extension = (new Extension)->setName('ANT Eshop');
		$extension->setDescription(<<<DESC
Peckový ANT Eshop, který zvládne všechno...
DESC
		);
		return $extension;
	}

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/config.neon');
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();
		$this->setPresenterMapping($builder, ['Eshop' => 'Eshop\\*Module\\Presenters\\*Presenter']);
		$this->registerExtension($builder, $this->getExtensionInfo());
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
