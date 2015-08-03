<?php

namespace Tests\Pages\FrontModule;

use Kdyby;
use Nette;
use Tester;

require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class CategoryPresenter extends \PresenterTestCase
{

	public function setUp()
	{
		$this->openPresenter('Pages:Front:Category:');
	}

	/**
	 * @dataProvider getLocales
	 */
	public function testRenderDefault($param, $value)
	{
		$this->checkRedirect('default', '/', [$param => $value]);
	}

}

(new CategoryPresenter())->run();
