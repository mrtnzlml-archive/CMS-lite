<?php

namespace App\Router;

use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\IRouter;
use Nette\Application\Routers\Route;
use Nette\Application\Routers\RouteList;
use Pages\Page;
use Pages\Query\PagesQuery;

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

		//FrontModule
		$router[] = $front = new RouteList('Front');
		$front[] = new Route('[<locale=cs cs|en>/]<slug>', [ //TODO: nechat na AntRoute, stránky si ale musí vygenerovat URL
			'presenter' => 'Page',
			'action' => 'default',
			NULL => [
				Route::FILTER_IN => function ($params) {
					$pageQuery = (new PagesQuery)->bySlug($params['slug']);
					$page = $this->em->getRepository(Page::class)->fetchOne($pageQuery);
					if ($page === NULL) {
						return NULL;
					} else {
						return $params;
					}
				}
			]
		]);

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
