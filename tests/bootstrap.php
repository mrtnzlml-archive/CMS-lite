<?php

require __DIR__ . '/../vendor/autoload.php';

define('IE_ONLY', 'ie');

$loader = new \Nette\Loaders\RobotLoader();
$loader->setCacheStorage(new \Nette\Caching\Storages\MemoryStorage());
$loader->addDirectory(__DIR__ . '/../app');
$loader->addDirectory(__DIR__ . '/../custom');
$loader->addDirectory(__DIR__ . '/../libs');
$loader->register();

Test\Bootstrap::setup(__DIR__);
