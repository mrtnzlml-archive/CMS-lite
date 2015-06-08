<?php

require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class DashboardPresenter extends \PresenterTestCase
{

	public function __construct()
	{
		$this->openPresenter('Admin:Dashboard:');
	}

	public function setUp()
	{
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

(new DashboardPresenter())->run();
