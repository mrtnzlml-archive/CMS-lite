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

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	/**
	 * @return Nette\Application\IRouter
	 */
	public function createRouter()
	{
		$router = new RouteList();

		//AuthModule
		$router[] = $auth = new RouteList('Auth');
		$auth[] = new Route('[<locale=cs cs|en>/]auth[/<presenter>[/<action>[/<id>]]]', 'Sign:in');

		//AdminModule
		$router[] = $admin = new RouteList('Admin');
		$admin[] = new Route('[<locale=cs cs|en>/]administrace[/<presenter>[/<action>[/<id>]]]', 'Dashboard:default');

		//FrontModule
		$router[] = $front = new RouteList('Front');
		$front[] = new Route('[<locale=cs cs|en>/]preview/<id>', 'Front:Page:preview');
		$front[] = new Route('[<locale=cs cs|en>/]<slug>', [
			'presenter' => 'Page',
			'action' => 'default',
			NULL => [
				Route::FILTER_IN => function ($params) {
					//FIXME: cache maybe?
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
		$front[] = new Route('[<locale=cs cs|en>/]<presenter>[/<action>[/<id>]]', [
			'presenter' => [
				Route::VALUE => 'Homepage',
				Route::FILTER_TABLE => [
					'kontakt' => 'Contact',
				],
			],
			'action' => 'default',
		]);

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
