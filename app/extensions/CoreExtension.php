<?php

namespace App\Extensions;

use App\Components\Meta\IMetaFactory;
use App\Components\Meta\Providers\IMetasProvider;
use Nette;

class CoreExtension extends Nette\DI\Extensions\ExtensionsExtension
{

	private $defaultConfiguration = [
		'https' => TRUE,
	];

	/** @var Nette\Loaders\RobotLoader */
	private $robotLoader;

	public function __construct(Nette\Loaders\RobotLoader $robotLoader)
	{
		$this->robotLoader = $robotLoader;
	}

	public function loadConfiguration()
	{
		$iterator = 0;
		foreach ($this->robotLoader->getIndexedClasses() as $class => $file) {
			$reflection = Nette\Reflection\ClassType::from($class);
			//TODO: bylo by fajn, kdyby šlo mít extension a vůbec ji do DIC neregistrovat, pokud není nainstalované
			//TODO: zatím nevím jak, ale je to nutné kvůli tomu, že jsou tam třídy, které tam nemají být, pokud není nainstalováno
			//@see: https://github.com/Kdyby/Doctrine/blob/master/src/Kdyby/Doctrine/DI/OrmExtension.php#L828-L839
			if ($reflection->implementsInterface(ICustomExtension::class) && $reflection->isInstantiable()) {
				$this->compiler->addExtension('dynamic.' . $iterator++, new $class);
			}
		}
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();

		/** @var IMetasProvider $extension */
		foreach ($this->compiler->getExtensions(IMetasProvider::class) as $extension) {
			$definition = $builder->getDefinition($builder->getByType(IMetaFactory::class));
			$definition->addSetup('setMetas', [$extension->getMetas()]);
		}

		$extensionNames = [];
		foreach ($this->robotLoader->getIndexedClasses() as $class => $file) {
			$reflection = Nette\Reflection\ClassType::from($class);
			if ($reflection->implementsInterface(ICustomExtension::class) && $reflection->isInstantiable()) {
				$extensionNames[] = $class;
			}
		}
		$builder
			->getDefinition($builder->getByType(Registrar::class))
			->addSetup(
				'?->onExtensionRegistration[] = function ($registrar) {' . "\n" .
				"\t" . '$registrar->registerExtensionNames(?);' . "\n" .
				'}', ['@self', $extensionNames]
			);
	}

	public function afterCompile(Nette\PhpGenerator\ClassType $generatedContainer)
	{
		$initialize = $generatedContainer->getMethod('initialize');
		$config = $this->getConfig($this->defaultConfiguration);
		if ($config['https']) {
			$initialize->addBody('Nette\Application\Routers\Route::$defaultFlags = Nette\Application\Routers\Route::SECURED;');
		}
	}

}
