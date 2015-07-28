<?php

namespace App\Components\Title;

use App\Components;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Options\OptionFacade;

class Title extends Components\AControl
{

	/** @var EntityManager */
	private $em;

	/** @var OptionFacade */
	private $optionFacade;

	private $title = NULL;

	public function __construct(EntityManager $em, OptionFacade $optionFacade)
	{
		$this->em = $em;
		$this->optionFacade = $optionFacade;
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->title = $this->getTitle();
		$this->template->render($this->templatePath ?: __DIR__ . '/Title.latte');
	}

	public function setTitle($title)
	{
		if ($this->title !== NULL) {
			throw new Nette\InvalidStateException(sprintf('You are trying to override current title (%s).', $this->getTitle()));
		}
		$this->title = $title;
	}

	private function getTitle()
	{
		$separator = $this->optionFacade->getOption('site_title_separator');
		if ($separator === NULL) {
			$separator = $this->title ? '|' : NULL;
		} else {
			$separator = $this->title ? $separator : NULL;
		}
		$site_title = $this->optionFacade->getOption('site_title');
		return "$this->title $separator $site_title";
	}

}

interface ITitleFactory
{
	/** @return Title */
	function create();
}
