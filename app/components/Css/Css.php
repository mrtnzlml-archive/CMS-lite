<?php

namespace App\Components\Css;

use MatthiasMullie\Minify;
use Nette;
use WebLoader;

/**
 * @method getMedia
 * @method addStyle(string)
 * @method addExternalStyle(string)
 */
class Css extends Nette\Application\UI\Control
{

	private $media = 'screen'; //'screen,projection,tv,print'

	private $styles = [];
	private $externalStyles = [];

	/** @var string */
	private $dir;

	public function __construct($dir)
	{
		parent::__construct();
		$this->dir = $dir;
	}

	public function render()
	{
		$this->template->render(__DIR__ . '/templates/Css.latte');
	}

	public function renderAdmin()
	{
		$this->template->render(__DIR__ . '/templates/CssAdmin.latte');
	}

	protected function createComponentCss()
	{
		$files = new WebLoader\FileCollection($this->dir . '/css');
		$files->addRemoteFiles($this->externalStyles);
		$files->addFiles($this->styles);
		$files->addFile('front.css');
		$compiler = WebLoader\Compiler::createCssCompiler($files, $this->dir . '/temp');
		$compiler->addFilter(function ($code) {
			$minifier = new Minify\CSS;
			$minifier->add($code);
			return $minifier->minify();
		});
		$control = new WebLoader\Nette\CssLoader($compiler, 'temp');
		$control->setMedia($this->media);
		return $control;
	}

	protected function createComponentCssAdmin()
	{
		$files = new WebLoader\FileCollection($this->dir . '/css');
		$files->addRemoteFile('https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css');
		$files->addFile('admin.css');
		$compiler = WebLoader\Compiler::createCssCompiler($files, $this->dir . '/temp');
		$compiler->addFilter(function ($code) {
			$minifier = new Minify\CSS;
			$minifier->add($code);
			return $minifier->minify();
		});
		$control = new WebLoader\Nette\CssLoader($compiler, 'temp');
		$control->setMedia($this->media);
		return $control;
	}

	public function setMedia(array $media)
	{
		$this->media = implode(',', array_unique($media));
	}

}

interface ICssFactory
{
	/** @return Css */
	public function create();
}
