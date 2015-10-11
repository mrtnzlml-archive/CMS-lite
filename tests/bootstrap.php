<?php

require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/PresenterTestCase.php';

define('IE_ONLY', 'ie');

$loader = new \Nette\Loaders\RobotLoader();
$loader->setCacheStorage(new \Nette\Caching\Storages\MemoryStorage());
$loader->addDirectory(__DIR__ . '/../app');
$loader->addDirectory(__DIR__ . '/../custom');
$loader->addDirectory(__DIR__ . '/../src');
$loader->register();

Test\Bootstrap::setup(__DIR__);
