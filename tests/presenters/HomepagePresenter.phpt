<?php

use Test\PresenterTester;

$container = require __DIR__ . '/../bootstrap.php';

/**
 * @testCase
 */
class HomepagePresenter extends Tester\TestCase
{

	private $tester;

	public function __construct(Nette\DI\Container $container)
	{
		$this->tester = new PresenterTester($container, 'Homepage');
	}

	public function testRenderDefault()
	{
		$this->tester->testAction('default');
	}

}

(new HomepagePresenter($container))->run();
