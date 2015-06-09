<?php

require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class HomepagePresenter extends \PresenterTestCase
{

	public function __construct()
	{
		$this->openPresenter('Front:Homepage:');
	}

	public function testRenderDefault()
	{
		$this->checkAction('default');
	}

}

(new HomepagePresenter())->run();
