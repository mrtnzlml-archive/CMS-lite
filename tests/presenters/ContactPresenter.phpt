<?php

require __DIR__ . '/../bootstrap.php';

/**
 * @testCase
 */
class ContactPresenter extends Tester\TestCase
{

	use Test\PresenterTester;

	public function setUp()
	{
		$this->openPresenter('Contact:');
	}

	public function testRenderDefault()
	{
		$this->checkAction('default');
	}

}

(new ContactPresenter())->run();
