<?php

namespace Eshop\DI;

use App\Components\MainMenu\MainMenuItem;
use App\Components\MainMenu\Providers\IMainMenuProvider;
use App\Extensions\CompilerExtension;
use App\Extensions\Registrar;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;
use Nette\Application\Routers\RouteList;
use Url\IRouterProvider;

class EshopExtension extends CompilerExtension implements IEntityProvider, IMainMenuProvider, IRouterProvider
{

	const ESHOP_MENU_PRIORITY = 1000;

	public function loadConfiguration()
	{
		$config = $this->loadFromFile(__DIR__ . '/config.neon');
		$containerBuilder = $this->getContainerBuilder();
		$this->compiler->parseServices($containerBuilder, $config);

		if ($config['console']) {
			foreach ($config['console']['commands'] as $i => $command) {
				$containerBuilder->addDefinition($this->prefix('cli.' . $i))
					->addTag(Kdyby\Console\DI\ConsoleExtension::TAG_COMMAND)
					->setInject(FALSE)// lazy injects
					->setClass($command);
			}
		}
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();
		$this->setPresenterMapping($builder, ['Eshop' => 'Eshop\\*Module\\Presenters\\*Presenter']);
		$this->registerExtension($builder, self::class);

		$builder
			->getDefinition($builder->getByType(Registrar::class))
			->addSetup(
				'$service->onInstall[] = function ($em) {' . "\n" .
				"\t" . '$em->find(\App\Extensions\Extension::class, ?);' . "\n" .
				'}', [1]
			);
	}

	public function getRouter()
	{
		//TODO: odstranit a registrovat si vlastní routy do databáze (AntRoute)
		$router = new RouteList();
		$router[] = $eshop = new RouteList('Eshop');
		$eshop[] = new Nette\Application\Routers\Route('[<locale=cs cs|en>/]eshop[/<slug>]', 'Product:default');
		$eshop[] = new Nette\Application\Routers\Route('[<locale=cs cs|en>/]eshop[/<presenter>[/<action>[/<id>]]]', 'Product:default');
		return $router;
	}

	/**
	 * Returns associative array of Namespace => mapping definition
	 *
	 * @return array
	 */
	public function getEntityMappings()
	{
		return [
			'Eshop' => __DIR__ . '/..',
		];
	}

	public function getMenuItems()
	{
		$menuItem = new MainMenuItem(self::ESHOP_MENU_PRIORITY);
		$menuItem->setTitle('Eshop');
		$menuItem->setLink(':Eshop:Product:default');
		return [
			$menuItem,
		];
	}

}
