<?php

namespace Options\DI;

use App\Extensions\CompilerExtension;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

/**
 * FIXME: Toto je jedno z rozšíření, které není možné odinstalovat, proto by se mělo vše dělat nativně, ale
 * podobně jako u jiných (instalovatelných) rozšíření
 */
class OptionsExtension extends CompilerExtension implements IEntityProvider
{

	public function loadConfiguration()
	{
		$builder = $this->getContainerBuilder();
		$config = $this->loadFromFile(__DIR__ . '/services.neon');
		$this->compiler->parseServices($builder, $config);
	}

	public function beforeCompile()
	{
		$builder = $this->getContainerBuilder();
		$this->setPresenterMapping($builder, ['Options' => 'Options\\*Module\\Presenters\\*Presenter']);
	}

	/**
	 * Returns associative array of Namespace => mapping definition
	 *
	 * @return array
	 */
	public function getEntityMappings()
	{
		return [
			'Options' => __DIR__ . '/..',
		];
	}

}
