<?php

class PresenterTestCase extends Tester\TestCase
{

	use Test\PresenterTester {
		Test\PresenterTester::createContainer as parentCreateContainer;
	}

	protected function createContainer()
	{
		//FIXME: Je to takto správně? Skutečně by toto vše měl test potřebovat?
		return $this->parentCreateContainer([
			__DIR__ . '/../app/config/config.neon',
			__DIR__ . '/../app/config/config.local.neon',
		]);
	}

}
