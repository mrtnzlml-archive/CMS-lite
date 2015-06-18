<?php

namespace Eshop\DI;

use App\Components\MainMenu\MainMenuItem;
use App\Components\MainMenu\Providers\IMainMenuProvider;
use App\Router\IRouterProvider;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;
use Nette\Application\IPresenterFactory;
use Nette\Application\Routers\RouteList;

class EshopExtension extends Nette\DI\CompilerExtension implements IEntityProvider, IMainMenuProvider, IRouterProvider
{

	public function loadConfiguration()
	{
		$config = $this->loadFromFile(__DIR__ . '/config.neon');
		$containerBuilder = $this->getContainerBuilder();
		$this->compiler->parseServices($containerBuilder, $config);

		if ($config['console']) {
			foreach ($config['console']['commands'] as $i => $command) {
				$containerBuilder->addDefinition($this->prefix('cli.' . $i))
					->addTag(Kdyby\Console\DI\ConsoleExtension::COMMAND_TAG)
					->setInject(FALSE)// lazy injects
					->setClass($command);
			}
		}
	}

	public function beforeCompile()
	{
		$container = $this->getContainerBuilder();
		// presenter mapping configuration
		$container
			->getDefinition($container->getByType(IPresenterFactory::class) ?: 'nette.presenterFactory')
			->addSetup('setMapping', [['Eshop' => 'Eshop\\*Module\\Presenters\\*Presenter']]);
	}

	public function getRouter()
	{
		//TODO: dynamic language routing
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
		$menuItem = new MainMenuItem();
		$menuItem->setTitle('Eshop');
		$menuItem->setLink(':Eshop:Product:default');
		return [
			$menuItem,
		];
	}

}
