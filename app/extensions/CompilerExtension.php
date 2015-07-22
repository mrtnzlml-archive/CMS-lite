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

	public function addInstallEvent(ContainerBuilder $builder, $className, $method)
	{
		$builder
			->getDefinition($builder->getByType(Registrar::class))
			->addSetup(
				'?->onInstall[] = function () {' . "\n" .
				"\t" . '$this->getService(?)->?();' . "\n" .
				'}', ['@self', $builder->getServiceName('@' . $className), $method]
			);
	}

	public function addUninstallEvent(ContainerBuilder $builder, $className, $method)
	{
		$builder
			->getDefinition($builder->getByType(Registrar::class))
			->addSetup(
				'?->onUninstall[] = function () {' . "\n" .
				"\t" . '$this->getService(?)->?();' . "\n" .
				'}', ['@self', $builder->getServiceName('@' . $className), $method]
			);
	}

	public function registerExtension(ContainerBuilder $builder, Extension $extension)
	{
		$builder
			->getDefinition($builder->getByType(Registrar::class))
			->addSetup(
				'?->onExtensionRegistration[] = function ($registrar) {' . "\n" .
				"\t" . '$registrar->registerExtension(?);' . "\n" .
				'}', ['@self', $extension]
			);
	}

	public function setPresenterMapping(ContainerBuilder $builder, array $mapping)
	{
		$builder
			->getDefinition($builder->getByType(Nette\Application\IPresenterFactory::class) ?: 'nette.presenterFactory')
			->addSetup('setMapping', [$mapping]);
	}

}
