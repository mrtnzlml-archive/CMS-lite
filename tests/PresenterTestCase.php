<?php

use Doctrine\DBAL\Connection;

class PresenterTestCase extends Tester\TestCase
{

	use Test\PresenterTester {
		Test\PresenterTester::createContainer as parentCreateContainer;
		Test\PresenterTester::doCreateConfiguration as parentDoCreateConfiguration;
	}

	protected function getLocales()
	{
		return [
			['locale', 'cz'],
			['locale', 'en'],
		];
	}

	protected function createContainer()
	{
		$container = $this->parentCreateContainer([
			__DIR__ . '/../app/config/config.neon',
			__DIR__ . '/../app/config/config.local.neon',
			__DIR__ . '/test.neon',
		]);

		/** @var Connection $db */
//		$db = $container->getByType(Doctrine\DBAL\Connection::class);
//		$this->doSetupDatabase($db, $container);

		return $container;
	}

	protected function doCreateConfiguration()
	{
		$configurator = $this->parentDoCreateConfiguration();
		$loader = $configurator->createRobotLoader()
			->addDirectory(__DIR__ . '/helpers')
			->addDirectory(__DIR__ . '/../custom')
			->register();
		$configurator->onCompile[] = function ($_, \Nette\DI\Compiler $compiler) use ($loader) {
			$compiler->addExtension('core', new \App\Extensions\CoreExtension($loader));
		};
		return $configurator;
	}

	protected function doSetupDatabase(Connection $db, \Nette\DI\Container $container)
	{
		\Tracy\Debugger::log('Creating DB');

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
