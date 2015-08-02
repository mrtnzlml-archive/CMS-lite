<?php

namespace Fixtures\DI;

use Kdyby;
use Nette;

class FixturesExtension extends Nette\DI\CompilerExtension
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
