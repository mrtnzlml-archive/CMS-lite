<?php

use Test\PresenterTester;

$container = require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class PagePresenter extends Tester\TestCase
{

	private $tester;

	/** @var Kdyby\Doctrine\EntityManager */
	private $em;

	public function __construct(Nette\DI\Container $container)
	{
		$this->tester = new PresenterTester($container, 'Admin:Page');
		$this->em = $container->getByType('Kdyby\Doctrine\EntityManager');
	}

	public function setUp()
	{
		$this->tester->logIn(1, 'superadmin'); //TODO: lépe (?)
	}

	public function testRenderDefault()
	{
		$this->tester->testAction('default');
	}

	public function testRenderDefaultLoggedOut()
	{
		$this->tester->logOut();
		$this->tester->testRedirect('default');
	}

	public function testRenderNew()
	{
		$this->tester->testAction('new');
	}

	public function testRenderNewLoggedOut()
	{
		$this->tester->logOut();
		$this->tester->testRedirect('new');
	}

	public function testRenderEmptyEditRedirect()
	{
		//TODO: u redirectů testovat kam přesměrovávají
		$this->tester->testRedirect('edit');
	}

	public function testRenderEdit()
	{
		/** @var \Pages\Page $page */
		$page = $this->em->getRepository(\Pages\Page::class)->findOneBy([]);
		$this->tester->testAction('edit', \Test\PresenterTester::GET, [
			'id' => $page->getId()
		]);
	}

}

(new PagePresenter($container))->run();
