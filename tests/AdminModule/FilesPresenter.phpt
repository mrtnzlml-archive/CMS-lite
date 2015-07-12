<?php

require __DIR__ . '/../bootstrap.php';

/**
 * @testCase
 */
class FilesPresenter extends \PresenterTestCase
{

	public function __construct()
	{
		$this->openPresenter('Admin:Files:');
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
		$this->checkRedirect('default', '/auth');
	}

	public function testRenderEditEmpty()
	{
		$this->checkRedirect('edit', '/administrace/soubory');
	}

}

(new FilesPresenter())->run();
