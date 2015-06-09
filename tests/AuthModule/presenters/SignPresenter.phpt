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

//	public function testSignInForm()
//	{
//		$this->checkForm('in', 'signInForm-form', [
//			'username' => 'Username',
//			'password' => 'Password',
//		]);
//	}

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
