<?php

namespace App\Components\Title;

use App\Components;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Options\Option;
use Pages\Query\OptionsQuery;

class Title extends Components\AControl
{

	/** @var EntityManager */
	private $em;

	private $title = NULL;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->title = $this->getTitle();
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Title.latte');
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
		$query = (new OptionsQuery)->withOptions([
			'site_title',
			'site_title_separator',
		]);
		$options = Nette\Utils\ArrayHash::from($this->em->getRepository(Option::class)->fetch($query));
		$separator = isset($options->site_title_separator)
			? ($this->title ? $options->site_title_separator->value : NULL)
			: ($this->title ? '|' : NULL);
		return "$this->title $separator {$options->site_title->getValue()->value}"; //FIXME: to je ale pěkná hovadina
	}

}

interface ITitleFactory
{
	/** @return Title */
	function create();
}
