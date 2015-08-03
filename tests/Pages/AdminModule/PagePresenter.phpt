<?php

namespace Tests\Pages\AdminModule;

use Kdyby;

require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class PagePresenter extends \PresenterTestCase
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
		$this->openPresenter('Pages:Admin:Page:');
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
		$this->checkRedirect('edit', '/administrace/nova-stranka');
	}

	/**
	 * @dataProvider getLocales
	 */
	public function testRenderEdit($param, $value)
	{
		/** @var \Pages\Page $page */
		$page = $this->em->getRepository(\Pages\Page::class)->findOneBy([]);
		$this->checkAction('edit', [
				'id' => $page->getId(),
			] + [$param => $value]);
	}

	public function testRenderEditMissingId()
	{
		$this->checkRedirect('edit', '/administrace/nova-stranka', [
			'id' => 'missing'
		]);
	}

}

(new PagePresenter())->run();
