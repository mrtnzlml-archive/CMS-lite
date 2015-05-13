<?php

namespace Eshop\Presenters;

use App\Components\MainMenu\IMainMenuFactory;
use Nette;

class CategoryPresenter extends Nette\Application\UI\Presenter
{

	//TODO: nějaký společný předek, který to vše pořeší

	/** @var IMainMenuFactory @inject */
	public $mainMenuFactory;

	public function createComponentMainMenu()
	{
		return $this->mainMenuFactory->create();
	}

	public function formatLayoutTemplateFiles()
	{
		$name = $this->getName();
		$presenter = substr($name, strrpos(':' . $name, ':'));
		$layout = $this->layout ? $this->layout : 'layout';
		$dir = dirname(APP_DIR . '/presenters/templates');
		$dir = is_dir("$dir/templates") ? $dir : dirname($dir);
		$list = [
			"$dir/templates/$presenter/@$layout.latte",
			"$dir/templates/$presenter.@$layout.latte",
		];
		do {
			$list[] = "$dir/templates/@$layout.latte";
			$dir = dirname($dir);
		} while ($dir && ($name = substr($name, 0, strrpos($name, ':'))));
		return $list;
	}

}
