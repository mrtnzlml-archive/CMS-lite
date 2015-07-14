<?php

namespace App\FrontModule\Presenters;

use App\Traits\PublicComponentsTrait;
use Nette;
use WebLoader;

abstract class BasePresenter extends Nette\Application\UI\Presenter
{

	use PublicComponentsTrait;

	/** @persistent */
	public $locale;

	protected function beforeRender()
	{
		$this->template->locale = $this->locale;
	}

	protected function createTemplate($class = NULL)
	{
		/** @var \Latte\Engine $template */
		$template = parent::createTemplate($class);
		$texy = new \Texy();
		$template->addFilter('texy', function ($input) use ($texy) {
			return Nette\Utils\Html::el()->setHtml($texy->process($input));
		});

		return $template;
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
