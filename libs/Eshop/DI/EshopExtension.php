<?php

namespace Eshop\DI;

use App\Components\MainMenu\MainMenuItem;
use App\Components\MainMenu\Providers\IMainMenuProvider;
use App\Extensions\CompilerExtension;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

/**
 * TODO: oprávnění k přidaným stránkám (ACL)
 * TODO: schéma databáze při instalaci
 * TODO: default data
 * TODO: nainstalovat viditelné věci jako jsou položky menu atd...
 */
class EshopExtension extends CompilerExtension implements IEntityProvider, IMainMenuProvider
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

	public function getMenuItems()
	{
		//TODO: nově extensions nesmí přidávat funkcionalitu, která by se mohla prijevovat, když není rozšíření nainstalované
		$menuItem = new MainMenuItem(self::ESHOP_MENU_PRIORITY);
		$menuItem->setTitle('Eshop');
		$menuItem->setLink(':Eshop:Product:default');
		return [
			$menuItem,
		];
	}

}
