<?php

namespace App\Extensions;

use Nette;
use Nette\DI\ContainerBuilder;

class CompilerExtension extends Nette\DI\CompilerExtension
{

	public function registerExtension(ContainerBuilder $builder, $extension)
	{
		$builder
			->getDefinition($builder->getByType(Registrar::class))
			->addSetup(
				'$service->onExtensionRegistration[] = function ($registrar) {' . "\n" .
				"\t" . '$registrar->registerExtension(?);' . "\n" .
				'}', [$extension]
			);
	}

	public function setPresenterMapping(ContainerBuilder $builder, array $mapping)
	{
		$builder
			->getDefinition($builder->getByType(Nette\Application\IPresenterFactory::class) ?: 'nette.presenterFactory')
			->addSetup('setMapping', [$mapping]);
	}

}
