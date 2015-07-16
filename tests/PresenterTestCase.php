<?php

use Doctrine\DBAL\Connection;

class PresenterTestCase extends Tester\TestCase
{

	use Test\PresenterTester {
		Test\PresenterTester::createContainer as parentCreateContainer;
	}

	private $running = NULL;

	protected function createContainer()
	{
		$container = $this->parentCreateContainer([
			__DIR__ . '/../app/config/config.neon',
			__DIR__ . '/../app/config/config.local.neon',
//			__DIR__ . '/config.local.neon',
		]);

//		/** @var Connection $db */
//		$db = $container->getByType(Doctrine\DBAL\Connection::class);
//		$this->doSetupDatabase($db, $container);

		return $container;
	}

	protected function doSetupDatabase(Connection $db, \Nette\DI\Container $container)
	{
		\Tracy\Debugger::log('Trying to creating DB');
		if ($this->running !== NULL) {
			return;
		}
		\Tracy\Debugger::log('Creating DB');
		$this->running = TRUE;

		/** @var \Kdyby\Doctrine\EntityManager $em */
		$em = $container->getByType(\Kdyby\Doctrine\EntityManager::class);

		$schemaTool = new Doctrine\ORM\Tools\SchemaTool($em);
		try {
			$schemaTool->createSchema($em->getMetadataFactory()->getAllMetadata());
		} catch (\Doctrine\ORM\Tools\ToolsException $exc) {
			$schemaTool->updateSchema($em->getMetadataFactory()->getAllMetadata());
		}

		$application = $container->getByType(Kdyby\Console\Application::class);
		$application->run(new \Symfony\Component\Console\Input\ArrayInput([
			'command' => 'cms:fixtures:load',
			'--no-interaction' => TRUE,
			'--demo' => TRUE,
		]), new \Kdyby\Console\StringOutput());
	}

}
