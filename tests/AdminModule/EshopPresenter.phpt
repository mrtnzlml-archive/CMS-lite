<?php

require __DIR__ . '/../bootstrap.php';

/**
 * @testCase
 */
class EshopPresenter extends \PresenterTestCase
{

	public function __construct()
	{
		$this->openPresenter('Admin:Eshop:');
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
		/** @var \Nette\Application\Responses\RedirectResponse $response */
		$response = $this->checkRedirect('default');
		Tester\Assert::same(302, $response->getCode());
		Tester\Assert::match('~https://fake.url/auth\?backlink=[a-z0-9]{5}&_fid=[a-z0-9]{4}~', $response->getUrl());
	}

}

(new EshopPresenter())->run();
