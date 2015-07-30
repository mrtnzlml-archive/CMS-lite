<?php

namespace App\FrontModule\Presenters;

use App\Traits\PublicComponentsTrait;
use Nette;
use Options\OptionFacade;
use WebLoader;

abstract class BasePresenter extends Nette\Application\UI\Presenter
{

	use PublicComponentsTrait;

	/** @persistent */
	public $locale;

	/** @var OptionFacade @inject */
	public $optionFacade;

	protected function beforeRender()
	{
		$this->template->locale = $this->locale;
		$this->setMeta('og:url', $this->link('//this'));
		$this->setMeta('og:site_name', $this->optionFacade->getOption('site_title'));
	}

	protected function setTitle($title)
	{
		$this['title']->setTitle($title);
	}

	protected function setMeta($name, $content)
	{
		$this['meta']->setMeta($name, $content);
	}

	public function findLayoutTemplateFile()
	{
		if ($this->layout === FALSE) {
			return;
		}
		return __DIR__ . DIRECTORY_SEPARATOR . 'templates' . DIRECTORY_SEPARATOR . '@layout.latte';
	}

}
