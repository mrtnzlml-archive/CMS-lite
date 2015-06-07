<?php

require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class EshopPresenter extends Tester\TestCase
{

	use Test\PresenterTester;

	public function setUp()
	{
		$this->openPresenter('Auth:Eshop:');
		$this->logIn(1, 'superadmin'); //TODO: lépe (?)
	}

	public function testRenderDefault()
	{
		$this->checkAction('default');
	}

	public function testRenderDefaultLoggedOut()
	{
		$this->logOut();
		$this->checkRedirect('default');
	}

}

(new EshopPresenter())->run();
