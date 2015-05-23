<?php

require __DIR__ . '/../vendor/autoload.php';

$configurator = Test\Bootstrap::setup(__DIR__);

$configurator->createRobotLoader()
	->addDirectory(__DIR__ . '/../app')
	->addDirectory(__DIR__ . '/../custom')
	->addDirectory(__DIR__ . '/../libs')
	->register();

$configurator->addConfig(__DIR__ . '/../app/config/config.neon');
$configurator->addConfig(__DIR__ . '/../app/config/config.local.neon');

define('IE_ONLY', 'ie');

$configurator->addParameters([
	'appDir' => __DIR__ . '/../app',
	'wwwDir' => __DIR__ . '/../www',
])->addServices([
	//In tests (CLI), there is nothing like HTTP request, so we need to fake it...
	'http.request' => new Nette\Http\Request(new Nette\Http\UrlScript('https://fake.url/')),
]);

return $configurator->createContainer();
