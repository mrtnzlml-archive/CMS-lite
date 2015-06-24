<?php

require __DIR__ . '/../bootstrap.php';

/**
 * @testCase
 */
class OptionsPresenter extends \PresenterTestCase
{

	public function __construct()
	{
		$this->openPresenter('Admin:Options:');
	}

	public function setUp()
	{
		$this->logIn(1, 'superadmin'); //TODO: lépe (?)
	}

	public function testRenderGeneral()
	{
		$this->checkAction('general');
	}

	public function testRenderGeneralLoggedOut()
	{
		$this->logOut();
		/** @var \Nette\Application\Responses\RedirectResponse $response */
		$response = $this->checkRedirect('general');
		Tester\Assert::same(302, $response->getCode());
		Tester\Assert::match('~https://fake.url/auth\?backlink=[a-z0-9]{5}&_fid=[a-z0-9]{4}~', $response->getUrl());
	}

	public function testRenderSeo()
	{
		$this->checkAction('seo');
	}

	public function testRenderSeoLoggedOut()
	{
		$this->logOut();
		/** @var \Nette\Application\Responses\RedirectResponse $response */
		$response = $this->checkRedirect('seo');
		Tester\Assert::same(302, $response->getCode());
		Tester\Assert::match('~https://fake.url/auth\?backlink=[a-z0-9]{5}&_fid=[a-z0-9]{4}~', $response->getUrl());
	}

}

(new OptionsPresenter())->run();
