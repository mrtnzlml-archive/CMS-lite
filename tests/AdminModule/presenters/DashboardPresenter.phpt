<?php

require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class DashboardPresenter extends Tester\TestCase
{

	use Test\PresenterTester;

	public function setUp()
	{
		$router = $this->getContainer([
			__DIR__ . '/../../../app/config/config.neon',
			__DIR__ . '/../../../app/config/config.local.neon',
		])->getService('router');
		$router[] = new Nette\Application\Routers\Route('<presenter>/<action>[/<id>]', 'Auth:Sign:in');
		$this->logIn(1, 'superadmin'); //TODO: lépe (?)
		$this->openPresenter('Admin:Dashboard:');
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
