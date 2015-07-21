<?php

require __DIR__ . '/../vendor/autoload.php';

//Tracy\OutputDebugger::enable();

$configurator = new Nette\Configurator;
$configurator->enableDebugger(__DIR__ . '/../log');
$configurator->setTempDirectory(__DIR__ . '/../temp');

$configurator->createRobotLoader()
	->addDirectory(__DIR__)
	->addDirectory(__DIR__ . '/../custom')
	->addDirectory(__DIR__ . '/../libs')
	->register();

$configurator->addConfig(__DIR__ . '/config/config.neon');
$configurator->addConfig(__DIR__ . '/config/config.local.neon');

define('IE_ONLY', 'ie');

return $configurator->createContainer();
