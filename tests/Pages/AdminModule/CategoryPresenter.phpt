<?php

namespace Tests\Pages\AdminModule;

use Kdyby;
use Pages\PageCategory;

require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class CategoryPresenter extends \PresenterTestCase
{

	/** @var Kdyby\Doctrine\EntityManager */
	private $em;

	public function __construct()
	{
		$container = $this->getContainer();
		$this->em = $container->getByType(Kdyby\Doctrine\EntityManager::class);
	}

	public function setUp()
	{
		$this->openPresenter('Pages:Admin:Category:');
		$this->logIn(1, 'superadmin'); //TODO: lépe (?)
	}

	/**
	 * @dataProvider getLocales
	 */
	public function testRenderDefault($param, $value)
	{
		$this->checkAction('default', [$param => $value]);
	}

	public function testRenderDefaultLoggedOut()
	{
		$this->logOut();
		$this->checkRedirect('default', '/auth');
	}

	/**
	 * @dataProvider getLocales
	 */
	public function testRenderNew($param, $value)
	{
		$this->checkAction('new', [$param => $value]);
	}

	public function testRenderNewLoggedOut()
	{
		$this->logOut();
		$this->checkRedirect('new', '/auth');
	}

	public function testRenderEmptyEditRedirect()
	{
		$this->checkRedirect('edit', '/administrace/nova-kategorie');
	}

	/**
	 * @dataProvider getLocales
	 */
	public function testRenderEdit($param, $value)
	{
		/** @var PageCategory $category */
		$category = $this->em->getRepository(PageCategory::class)->findOneBy([]);
		$this->checkAction('edit', [
				'id' => $category->getId(),
			] + [$param => $value]);
	}

	public function testRenderEditMissingId()
	{
		$this->checkRedirect('edit', '/administrace/nova-kategorie', [
			'id' => 'missing'
		]);
	}

}

(new CategoryPresenter())->run();
