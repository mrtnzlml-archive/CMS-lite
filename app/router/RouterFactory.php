<?php

namespace App\Router;

use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\IRouter;
use Nette\Application\Routers\RouteList;

class RouterFactory
{

	/** @var EntityManager */
	private $em;

	/** @var AntRoute */
	private $antRoute;

	public function __construct(EntityManager $em, AntRoute $antRoute)
	{
		$this->em = $em;
		$this->antRoute = $antRoute;
	}

	/**
	 * @return Nette\Application\IRouter
	 */
	public function createRouter()
	{
		$router = new RouteList;
		$router[] = $this->antRoute;
		return $router;
	}

	/**
	 * @deprecated Nahrazeno AntRoute, tato metoda bude úplně odstraněna
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
