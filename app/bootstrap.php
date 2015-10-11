<?php

require __DIR__ . '/../vendor/autoload.php';

//Tracy\OutputDebugger::enable();

$configurator = new Nette\Configurator;
$configurator->enableDebugger(__DIR__ . '/../log');
$configurator->setTempDirectory(__DIR__ . '/../temp');

$loader = $configurator->createRobotLoader()
	->addDirectory(__DIR__)
	->addDirectory(__DIR__ . '/../custom')
	->addDirectory(__DIR__ . '/../src')
	->register();

$configurator->onCompile[] = function ($_, \Nette\DI\Compiler $compiler) use ($loader) {
	$compiler->addExtension('core', new \App\Extensions\CoreExtension($loader));
};

$configurator->addConfig(__DIR__ . '/config/config.neon');
$configurator->addConfig(__DIR__ . '/config/config.local.neon');

define('IE_ONLY', 'ie');

return $configurator->createContainer();
