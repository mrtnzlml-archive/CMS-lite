<?php

namespace App\Components\Title;

use App\Components;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Options\Option;
use Pages\Query\OptionsQuery;

/**
 * FIXME: nelze ovlivňovat bloky šablon z jiných komponent, nebo nadřazených šablon => nepoužitelné... :-(
 */
class Title extends Components\AControl
{

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}

		$query = (new OptionsQuery)->withOptions([
			'site_title',
			'site_title_separator',
		]);
		$options = $this->em->getRepository(Option::class)->fetch($query);
		$this->template->options = Nette\Utils\ArrayHash::from($options);

		$this->template->render($this->templatePath ?: __DIR__ . '/templates/Title.latte');
	}

}

interface ITitleFactory
{
	/** @return Title */
	function create();
}
