<?php

namespace App\Components\Css;

use MatthiasMullie\Minify;
use Nette;
use WebLoader;

/**
 * @method getMedia
 * @method setStyles(array);
 */
class Css extends Nette\Application\UI\Control
{

	private $media = 'screen'; //'screen,projection,tv,print'

	private $styles = [];

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

	protected function createComponentCss()
	{
		$files = new WebLoader\FileCollection($this->dir . '/css');
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
