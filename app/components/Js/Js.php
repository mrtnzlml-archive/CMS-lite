<?php

namespace App\Components\Js;

use MatthiasMullie\Minify;
use Nette;
use WebLoader;

/**
 * @method setScripts(array);
 */
class Js extends Nette\Application\UI\Control
{

	private $scripts = [];

	private $dir;

	public function __construct($dir)
	{
		parent::__construct();
		$this->dir = $dir;
	}

	public function render()
	{
		$this->template->render(__DIR__ . '/templates/Js.latte');
	}

	protected function createComponentJs()
	{
		$files = new WebLoader\FileCollection($this->dir . '/js');
		$files->addFiles($this->scripts);
		$files->addRemoteFile('//nette.github.io/resources/js/netteForms.min.js');
		$files->addFile('main.js');
		$compiler = WebLoader\Compiler::createJsCompiler($files, $this->dir . '/temp');
		$compiler->addFilter(function ($code) {
			$minifier = new Minify\JS;
			$minifier->add($code);
			return $minifier->minify();
		});
		$control = new WebLoader\Nette\JavaScriptLoader($compiler, 'temp');
		return $control;
	}

}

interface IJsFactory
{
	/** @return Js */
	public function create();
}
