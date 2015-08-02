<?php

namespace WebFontLoader\DI;

use App\Extensions\CompilerExtension;

class WebFontLoaderExtension extends CompilerExtension
{

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$this->parseConfig($builder, __DIR__ . '/config.neon');
	}

}
