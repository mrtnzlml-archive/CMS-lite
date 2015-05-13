<?php

namespace Drym\DI;

use App\Components\MainMenu\Providers\IMainMenuTemplateProvider;
use Nette;

class DrymExtension extends Nette\DI\CompilerExtension implements IMainMenuTemplateProvider
{

	public function getMainMenuTemplate()
	{
		return realpath(__DIR__ . '/../DrymMainMenu.latte');
	}

}
