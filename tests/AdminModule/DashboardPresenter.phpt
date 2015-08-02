<?php

require __DIR__ . '/../bootstrap.php';

/**
 * @testCase
 */
class DashboardPresenter extends \PresenterTestCase
{

	public function setUp()
	{
		$this->openPresenter('Dashboard:Dashboard:');
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

}

(new DashboardPresenter())->run();
