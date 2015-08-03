<?php

namespace App\Components\Js;

use MatthiasMullie\Minify;
use Nette;
use WebLoader;

/**
 * TODO: přidávat do pole s MD5 klíčem aby se zamezilo vícenásobnému přidání
 *
 * @method addScript(string $script)
 * @method addExternalScript(string $external_script)
 * @method addIeOnlyScript(string $ie_only)
 *
 * @method addAdminScript(string $adminScript)
 * @method addExternalAdminScript(string $external_admin_script)
 */
class Js extends Nette\Application\UI\Control
{

	private $scripts = [];
	private $externalScripts = [];
	private $ieOnlyScripts = []; //TODO

	private $adminScripts = [];
	private $externalAdminScripts = [];

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

	public function renderAdmin()
	{
		$this->template->render(__DIR__ . '/templates/JsAdmin.latte');
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

	protected function createComponentJsAdmin()
	{
		$files = new WebLoader\FileCollection;
		$files->addRemoteFiles($this->externalAdminScripts);
		$files->addFiles($this->adminScripts);
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
