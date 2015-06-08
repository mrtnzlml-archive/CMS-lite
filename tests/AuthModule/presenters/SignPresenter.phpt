<?php

require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class SignPresenter extends \PresenterTestCase
{

	public function __construct()
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
