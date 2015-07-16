<?php

namespace CmsDefaultDataExtension\DI;

use Kdyby;
use Nette;

class CmsDefaultDataExtension extends Nette\DI\CompilerExtension
{

	private $commands = [
		'Fixtures\Cli\DefaultData',
	];

	public function loadConfiguration()
	{
		$containerBuilder = $this->getContainerBuilder();

		foreach ($this->commands as $i => $command) {
			$containerBuilder->addDefinition($this->prefix('cli.' . $i))
				->addTag(Kdyby\Console\DI\ConsoleExtension::TAG_COMMAND)
				->setInject(FALSE)// lazy injects
				->setClass($command);
		}
	}

}
