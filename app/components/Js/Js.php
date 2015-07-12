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

	public function renderAdmin()
	{
		$this->template->render(__DIR__ . '/templates/JsAdmin.latte');
	}

	public function renderCustom()
	{
		//TODO: nějakou vlastní komponentu, která umožní podobně přidávat custom styly (ale ne do webloaderu)
	}

	protected function createComponentJs()
	{
		$files = new WebLoader\FileCollection($this->dir . '/js');
		$files->addRemoteFiles($this->externalScripts);
		$files->addRemoteFile('//nette.github.io/resources/js/netteForms.min.js'); //FIXME (z vendoru)
		$files->addFiles($this->scripts);
		$files->addFile('main.js');
		$compiler = WebLoader\Compiler::createJsCompiler($files, $this->dir . '/temp');
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
