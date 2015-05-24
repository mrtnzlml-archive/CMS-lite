<?php

use Test\PresenterTester;

$container = require __DIR__ . '/../bootstrap.php';

require __DIR__ . '/../helpers/FakePresenter.php';

/**
 * @testCase
 */
class Components extends Tester\TestCase
{

	private $tester;
	/** @var \App\Components\Css\ICssFactory */
	private $cssFactory;

	public function __construct(Nette\DI\Container $container)
	{
		$this->tester = new PresenterTester($container, 'Fake');
		$this->cssFactory = $container->getByType(App\Components\Css\ICssFactory::class);
	}

	public function testCss()
	{
		$control = $this->cssFactory->create();
		$control->setMedia([
			'screen', 'projection', 'tv'
		]);
		$this->tester->getPresenter()['css'] = $control;
		$this->checkReponse();
	}

	public function testDoctype()
	{
		$control = new \App\Components\Doctype\Doctype;
		$control->setDoctype(\App\Components\Doctype\Doctype::HTML4_STRICT);
		$this->tester->getPresenter()['doctype'] = $control;
		$this->checkReponse();
		Tester\Assert::exception(function () use ($control) {
			$control->setDoctype('unknown');
		}, Nette\InvalidArgumentException::class, 'Invalid doctype.');
	}

	public function testMeta()
	{
		$control = new \App\Components\Meta\Meta;
		$control->setMeta('xxx', 'yyy');
		$control->setMetas(['aaa' => 'bbb']);
		$control->setHttpEquiv('equiv', 'content');
		$this->tester->getPresenter()['meta'] = $control;
		Tester\Assert::exception(function () use ($control) {
			$control->setHttpEquiv('Content-Type', 'type');
		}, Nette\InvalidArgumentException::class);
		Tester\Assert::exception(function () use ($control) {
			$control->setHttpEquiv('Content-language', 'language');
		}, Nette\InvalidArgumentException::class);
		//TODO: testovat i nějaký výsledek tohoto snažení...
		$this->checkReponse();
	}

	public function testAllOtherComponents()
	{
		$this->checkReponse();
	}

	private function checkReponse()
	{
		$response = $this->tester->test('all');
		Tester\Assert::same(200, $this->tester->getReturnCode());
		Tester\Assert::type('Nette\Application\Responses\TextResponse', $response);
		Tester\Assert::type('Nette\Application\UI\ITemplate', $response->getSource());
		Tester\Assert::type('Tester\DomQuery', @Tester\DomQuery::fromHtml($response->getSource()));
	}

}

(new Components($container))->run();
