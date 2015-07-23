<?php

namespace App\Extensions;

use Kdyby;
use Nette;
use Nette\DI\ContainerBuilder;

class CompilerExtension extends Nette\DI\CompilerExtension
{

	public function parseConfig(ContainerBuilder $builder, $fileName)
	{
		$config = $this->loadFromFile($fileName);
		//services
		$this->compiler->parseServices($builder, $config);
		//commands
		if (isset($config['commands'])) {
			foreach ($config['commands'] as $i => $command) {
				$builder->addDefinition($this->prefix('cli.' . $i))
					->addTag(Kdyby\Console\DI\ConsoleExtension::TAG_COMMAND)
					->setInject(FALSE)// lazy injects
					->setClass($command);
			}
		}
	}

	public function setPresenterMapping(ContainerBuilder $builder, array $mapping)
	{
		$builder
			->getDefinition($builder->getByType(Nette\Application\IPresenterFactory::class) ?: 'nette.presenterFactory')
			->addSetup('setMapping', [$mapping]);
	}

}
