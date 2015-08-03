<?php

namespace App\Components\Css;

use MatthiasMullie\Minify;
use Nette;
use WebLoader;

/**
 * @method getMedia
 *
 * @method addStyle(string $style)
 * @method addExternalStyle(string $external_style)
 *
 * @method addAdminStyle(string $admin_style)
 * @method addExternalAdminStyle(string $external_admin_style)
 */
class Css extends Nette\Application\UI\Control
{

	private $media = 'screen'; //'screen,projection,tv,print'

	private $styles = [];
	private $externalStyles = [];

	private $adminStyles = [];
	private $externalAdminStyles = [];

	/** @var string */
	private $public;

	public function __construct($public)
	{
		parent::__construct();
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
		$files = new WebLoader\FileCollection;
		$files->addRemoteFiles($this->externalStyles);
		$files->addFiles($this->styles);
		$compiler = WebLoader\Compiler::createCssCompiler($files, $this->public . '/temp');
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

	protected function createComponentCssAdmin()
	{
		$files = new WebLoader\FileCollection;
		$files->addRemoteFiles($this->externalAdminStyles);
		$files->addFiles($this->adminStyles);
		$compiler = WebLoader\Compiler::createCssCompiler($files, $this->public . '/temp');
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
