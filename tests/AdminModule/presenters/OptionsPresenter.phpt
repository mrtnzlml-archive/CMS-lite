<?php

use Test\PresenterTester;

$container = require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class OptionsPresenter extends Tester\TestCase
{

	private $tester;

	public function __construct(Nette\DI\Container $container)
	{
		$this->tester = new PresenterTester($container, 'Admin:Options');
	}

	public function setUp()
	{
		$this->tester->logIn(1, 'superadmin'); //TODO: lépe (?)
	}

	public function testRenderGeneral()
	{
		$this->tester->testAction('general');
	}

	public function testRenderGeneralLoggedOut()
	{
		$this->tester->logOut();
		$this->tester->testRedirect('general');
	}

	public function testRenderSeo()
	{
		$this->tester->testAction('seo');
	}

	public function testRenderSeoLoggedOut()
	{
		$this->tester->logOut();
		$this->tester->testRedirect('seo');
	}

}

(new OptionsPresenter($container))->run();
