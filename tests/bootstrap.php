<?php

require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/PresenterTestCase.php';

define('IE_ONLY', 'ie');

$loader = new \Nette\Loaders\RobotLoader();
$loader->setCacheStorage(new \Nette\Caching\Storages\MemoryStorage());
$loader->addDirectory(__DIR__ . '/../app');
$loader->addDirectory(__DIR__ . '/../custom');
$loader->addDirectory(__DIR__ . '/../libs');
$loader->register();

//Test\Bootstrap::setup(__DIR__);

umask(0);
Tester\Environment::setup();
date_default_timezone_set('Europe/Prague');

if (!is_dir(__DIR__ . '/temp/')) {
	mkdir(__DIR__ . '/temp/');
}
define('TEMP_DIR', __DIR__ . '/temp/' . getmypid());
//Tester\Helpers::purge(TEMP_DIR);
//@chmod(TEMP_DIR, 0777);
Tracy\Debugger::$logDirectory = TEMP_DIR;

$_ENV = $_GET = $_POST = $_FILES = [];
