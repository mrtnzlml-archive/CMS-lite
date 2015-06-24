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
		/** @var \Nette\Application\Responses\RedirectResponse $response */
		$response = $this->checkRedirect('in');
		Tester\Assert::same(302, $response->getCode());
		Tester\Assert::same('https://fake.url/administrace', $response->getUrl());
	}

	public function testLogOut()
	{
		$this->logIn();
		/** @var \Nette\Application\Responses\RedirectResponse $response */
		$response = $this->checkRedirect('out');
		Tester\Assert::same(302, $response->getCode());
		Tester\Assert::match('~https://fake.url/auth\?backlink=[a-z0-9]{5}&_fid=[a-z0-9]{4}~', $response->getUrl());
	}

}

(new SignPresenter())->run();
