<?php

use Test\PresenterTester;

$container = require __DIR__ . '/../bootstrap.php';

/**
 * @testCase
 */
class ContactPresenter extends Tester\TestCase
{

	private $tester;

	public function __construct(Nette\DI\Container $container)
	{
		$this->tester = new PresenterTester($container, 'Contact');
	}

	public function testRenderDefault()
	{
		$this->tester->testAction('default');
	}

}

(new ContactPresenter($container))->run();
