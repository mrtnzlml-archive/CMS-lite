<?php

use Test\PresenterTester;

$container = require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class EshopPresenter extends Tester\TestCase
{

	private $tester;

	public function __construct(Nette\DI\Container $container)
	{
		$this->tester = new PresenterTester($container, 'Admin:Eshop');
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

}

(new EshopPresenter($container))->run();
