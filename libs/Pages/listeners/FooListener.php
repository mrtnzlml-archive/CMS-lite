<?php

namespace Pages\Listeners;

use Kdyby;
use Nette;

class FooListener extends Nette\Object implements Kdyby\Events\Subscriber
{

	/** @var Kdyby\Monolog\Logger */
	private $logger;

	public function __construct(Kdyby\Monolog\Logger $logger)
	{
		$this->logger = $logger->channel('foo');
	}

	public function getSubscribedEvents()
	{
		return [
			'Nette\Application\Application::onStartup' => [
				['appStartup', 123],
			],
		];
	}

	public function appStartup(Nette\Application\Application $app)
	{
//		$this->logger->addCritical(sprintf(__METHOD__ . ' %s', rand()));
	}

}
