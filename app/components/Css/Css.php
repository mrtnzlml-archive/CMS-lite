<?php

namespace App\Components\Css;

use Nette;
use WebLoader;

class Css extends Nette\Application\UI\Control
{

	public function render()
	{
		$this->template->render(__DIR__ . '/templates/Css.latte');
	}

	protected function createComponentCss()
	{
		$files = new WebLoader\FileCollection(WWW_DIR . '/css');
		$files->addRemoteFile('//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css');
		$files->addFile('front.css');
		$compiler = WebLoader\Compiler::createCssCompiler($files, WWW_DIR . '/temp');
		//TODO: minify
		$control = new WebLoader\Nette\CssLoader($compiler, 'temp');
		$control->setMedia('screen');
		return $control;
	}

}

interface ICssFactory
{
	/** @return Css */
	public function create();
}
