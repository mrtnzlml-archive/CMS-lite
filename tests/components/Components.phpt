<?php

require __DIR__ . '/../bootstrap.php';
require __DIR__ . '/../helpers/FakePresenter.php';

/**
 * @testCase
 */
class Components extends \PresenterTestCase
{

	/** @var \App\Components\Css\ICssFactory */
	private $cssFactory;

	public function __construct()
	{
		$this->openPresenter('Fake:');
		$this->cssFactory = $this->getService(App\Components\Css\ICssFactory::class);
	}

	public function testCss()
	{
		$control = $this->cssFactory->create();
		$control->setMedia([
			'screen', 'projection', 'tv'
		]);
		$this->getPresenter()->addComponent($control, 'css');
		$this->checkReponse();
	}

	public function testDoctype()
	{
		$control = new \App\Components\Doctype\Doctype;
		$control->setDoctype(\App\Components\Doctype\Doctype::HTML4_STRICT);
		$this->getPresenter()['doctype'] = $control;
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
		$this->getPresenter()['meta'] = $control;
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
		$response = $this->check('all');
		Tester\Assert::same(200, $this->getReturnCode());
		Tester\Assert::type('Nette\Application\Responses\TextResponse', $response);
	}

}

(new Components())->run();
