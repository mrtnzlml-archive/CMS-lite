<?php

namespace App\Router;

use Nette;
use Nette\Application\IRouter;
use Nette\Application\Routers\Route;
use Nette\Application\Routers\RouteList;

class RouterFactory
{

	/**
	 * @return Nette\Application\IRouter
	 */
	public static function createRouter()
	{
		$router = new RouteList();
		$router[] = new Route('[<locale=cs cs|en>/]auth[/<presenter>[/<action>[/<id>]]]', [
			'module' => 'Auth',
			'presenter' => 'Sign',
			'action' => 'in',
		]);
		$router[] = new Route('[<locale=cs cs|en>/]administrace[/<presenter>[/<action>[/<id>]]]', [
			'module' => 'Admin',
			'presenter' => 'Dashboard',
			'action' => 'default',
		]);
		$router[] = new Route('[<locale=cs cs|en>/]<presenter>[/<action>[/<id>]]', 'Homepage:default');
		return $router;
	}

	/**
	 * @param IRouter $router
	 * @param IRouter $newRouter
	 *
	 * @throws Nette\Utils\AssertionException
	 */
	public static function prependTo(IRouter &$router, IRouter $newRouter)
	{
		if (!$router instanceof RouteList) {
			throw new Nette\Utils\AssertionException(
				'If you want to prepend route then your main router ' .
				'must be an instance of Nette\Application\Routers\RouteList'
			);
		}
		$router[] = $newRouter; // need to increase the array size
		$lastKey = count($router) - 1;
		foreach ($router as $i => $route) {
			if ($i === $lastKey) {
				break;
			}
			$router[$i + 1] = $route;
		}
		$router[0] = $newRouter;
	}

}
