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

		$router[] = $auth = new RouteList('Auth');
		$auth[] = new Route('[<locale=cs cs|en>/]auth[/<presenter>[/<action>[/<id>]]]', 'Sign:in');

		$router[] = $admin = new RouteList('Admin');
		$admin[] = new Route('[<locale=cs cs|en>/]administrace[/<presenter>[/<action>[/<id>]]]', 'Dashboard:default');

		$router[] = $front = new RouteList('Front');
		$front[] = new Route('[<locale=cs cs|en>/]<presenter>[/<action>[/<id>]]', 'Homepage:default');

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
