<?php

require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class SignPresenter extends Tester\TestCase
{

	use Test\PresenterTester;

	public function setUp()
	{
		$this->openPresenter('Auth:Sign:');
	}

	public function testRenderIn()
	{
		$this->checkAction('in');
	}

	public function testRenderInLogged()
	{
		$this->logIn();
		$this->checkRedirect('in');
	}

	public function testLogOut()
	{
		$this->logIn();
		$this->checkRedirect('out');
	}

}

(new SignPresenter())->run();
