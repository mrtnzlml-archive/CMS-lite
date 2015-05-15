<?php

namespace App\Components\Js;

use Nette;
use WebLoader;

/**
 * @method setScripts(array);
 */
class Js extends Nette\Application\UI\Control
{

	private $scripts = [];

	public function render()
	{
		$this->template->render(__DIR__ . '/templates/Js.latte');
	}

	protected function createComponentJs()
	{
		$files = new WebLoader\FileCollection(WWW_DIR . '/js');
		$files->addFiles($this->scripts);
		$files->addRemoteFile('//nette.github.io/resources/js/netteForms.min.js');
		$files->addFile('main.js');
		$compiler = WebLoader\Compiler::createJsCompiler($files, WWW_DIR . '/temp');
		//TODO: minify
		$control = new WebLoader\Nette\JavaScriptLoader($compiler, '/temp');
		return $control;
	}

}

interface IJsFactory
{
	/** @return Js */
	public function create();
}
