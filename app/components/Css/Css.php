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
	private $vendor;
	/** @var string */
	private $public;

	public function __construct($vendor, $public)
	{
		parent::__construct();
		$this->vendor = $vendor;
		$this->public = $public;
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
		$files = new WebLoader\FileCollection($this->vendor . '/css');
		$files->addRemoteFiles($this->externalStyles);
		$files->addFiles($this->styles);
		$compiler = WebLoader\Compiler::createCssCompiler($files, $this->dir . '/temp');
		$compiler->addFileFilter(new WebLoader\Filter\LessFilter());
		$compiler->addFilter(function ($code) {
			$minifier = new Minify\CSS;
			$minifier->add($code);
			return $minifier->minify();
		});
		$control = new WebLoader\Nette\CssLoader($compiler, $this->template->basePath . '/temp');
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
