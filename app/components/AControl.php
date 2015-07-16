<?php

namespace App\Components;

use App\Traits\PublicComponentsTrait;
use Kdyby\Translation\Translator;
use Nette;
use Nette\Application\UI\Control;
use Nette\Localization\ITranslator;
use Nextras;

abstract class AControl extends Control implements IComponentTemplateProvider
{

	use PublicComponentsTrait;
	use Nextras\Application\UI\SecuredLinksControlTrait;

	/** @var Translator|ITranslator */
	private $translator;

	protected $templatePath = NULL;

	public function __construct(ITranslator $translator = NULL)
	{
		$this->translator = $translator;
	}

	abstract public function render(array $parameters = NULL);

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

	/**
	 * @param @param string $templatePath realPath of template file
	 *
	 * @return string
	 */
	public function changeTemplate($templatePath)
	{
		$this->templatePath = $templatePath;
	}

	protected function getTranslator()
	{
		return $this->translator;
	}

}
