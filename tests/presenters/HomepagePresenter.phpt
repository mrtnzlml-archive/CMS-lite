<?php

require __DIR__ . '/../bootstrap.php';

/**
 * @testCase
 */
class HomepagePresenter extends Tester\TestCase
{

	use Test\PresenterTester;

	public function __construct()
	{
		$this->openPresenter('Homepage:');
	}

	public function testRenderDefault()
	{
		$this->checkAction('default');
	}

}

(new HomepagePresenter())->run();
