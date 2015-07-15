<?php

require __DIR__ . '/../bootstrap.php';

/**
 * @testCase
 */
class OptionsPresenter extends \PresenterTestCase
{

	public function __construct()
	{
		$this->openPresenter('Options:Options:');
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
		$this->checkRedirect('general', '/auth');
	}

	public function testRenderSeo()
	{
		$this->checkAction('seo');
	}

	public function testRenderSeoLoggedOut()
	{
		$this->logOut();
		$this->checkRedirect('seo', '/auth');
	}

}

(new OptionsPresenter())->run();
