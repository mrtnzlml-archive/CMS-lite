<?php

namespace Migrations\DI;

use Doctrine\DBAL\Migrations\Configuration\Configuration;
use Kdyby;
use Nette;

class MigrationsExtension extends Nette\DI\CompilerExtension
{

	private $defaults = [
		'table' => 'doctrine_migrations',
		'directory' => '%appDir%/../migrations',
		'namespace' => 'Migrations',
	];

	public function loadConfiguration()
	{
		$containerBuilder = $this->getContainerBuilder();
		$config = $this->getConfig($this->defaults);

		$configuration = $containerBuilder
			->addDefinition($this->prefix('configuration'))
			->setClass(Configuration::class)
			->addSetup('setMigrationsTableName', [$config['table']])
			->addSetup('setMigrationsDirectory', [$config['directory']])
			->addSetup('setMigrationsNamespace', [$config['namespace']])
			->addSetup('registerMigrationsFromDirectory', [$config['directory']]);

		foreach ($this->loadFromFile(__DIR__ . '/commands.neon') as $i => $command) {
			$containerBuilder->addDefinition($this->prefix('cli.' . $i))
				->addTag(Kdyby\Console\DI\ConsoleExtension::COMMAND_TAG)
				->setInject(FALSE)// lazy injects
				->setClass($command)
				->addSetup('setMigrationConfiguration', [$configuration]);
		}
	}

}
