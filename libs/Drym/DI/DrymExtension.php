<?php

namespace Drym\DI;

use Nette;

class DrymExtension extends Nette\DI\CompilerExtension implements \ITemplateProvider
{

	public function getTemplate()
	{
		return realpath(__DIR__ . '/../DrymMainMenu.latte');
	}

}
