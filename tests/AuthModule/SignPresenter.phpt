<?php

require __DIR__ . '/../bootstrap.php';

/**
 * @testCase
 * TODO
 * @skip $layout parameter in __construct is needed
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
		$this->checkRedirect('in', '/administrace');
	}

	public function testLogOut()
	{
		$this->logIn();
		$this->checkRedirect('out', '/auth');
	}

}

(new SignPresenter())->run();
