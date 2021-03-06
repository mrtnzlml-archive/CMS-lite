<?php

namespace App\Components;

use App\Traits\PublicComponentsTrait;
use Kdyby\Translation\Translator;
use Nette;
use Nette\Application\UI\Control;
use Nette\Localization\ITranslator;
use Nextras;

/**
 * @property Nette\Bridges\ApplicationLatte\Template|\stdClass $template
 */
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
