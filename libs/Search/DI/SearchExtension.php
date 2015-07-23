<?php

namespace Search\DI;

use App\Extensions\CompilerExtension;

class SearchExtension extends CompilerExtension
{

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/config.neon');
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();
		$this->setPresenterMapping($builder, ['Search' => 'Search\\*Module\\Presenters\\*Presenter']);
	}

}
