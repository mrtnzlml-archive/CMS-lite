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

}
