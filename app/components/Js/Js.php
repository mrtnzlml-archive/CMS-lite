<?php

namespace App\Components\Js;

use MatthiasMullie\Minify;
use Nette;
use WebLoader;

/**
 * @method addScript(string)
 * @method addExternalScript(string)
 * @method addIeOnlyScript(string)
 */
class Js extends Nette\Application\UI\Control
{

	private $scripts = [];
	private $externalScripts = [];
	private $ieOnlyScripts = []; //TODO

	private $public;

	public function __construct($public)
	{
		parent::__construct();
		$this->public = $public;
	}

	public function render()
	{
		$this->template->render(__DIR__ . '/templates/Js.latte');
	}

	protected function createComponentJs()
	{
		$files = new WebLoader\FileCollection;
		$files->addRemoteFiles($this->externalScripts);
		$files->addFiles($this->scripts);
		$compiler = WebLoader\Compiler::createJsCompiler($files, $this->public . '/temp');
		$compiler->addFilter(function ($code) {
			$minifier = new Minify\JS;
			$minifier->add($code);
			return $minifier->minify();
		});
		$control = new WebLoader\Nette\JavaScriptLoader($compiler, $this->template->basePath . '/temp');
		return $control;
	}

}

interface IJsFactory
{
	/** @return Js */
	public function create();
}
