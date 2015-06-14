<?php

namespace Pages\Listeners;

use Kdyby;
use Nette;

class FooListener extends Nette\Object implements Kdyby\Events\Subscriber
{
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
		// todo
	}

}
