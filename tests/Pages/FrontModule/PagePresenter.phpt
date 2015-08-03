<?php

namespace Tests\Pages\FrontModule;

use Kdyby;
use Nette;
use Tester;

require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class PagePresenter extends \PresenterTestCase
{

	public function setUp()
	{
		$this->openPresenter('Pages:Front:Page:');
	}

	/**
	 * @dataProvider getLocales
	 */
	public function testRenderDefault($param, $value)
	{
		Tester\Assert::exception(function () use ($param, $value) {
			$this->checkAction('default', [$param => $value]);
		}, Nette\Application\BadRequestException::class);
	}

}

(new PagePresenter())->run();
