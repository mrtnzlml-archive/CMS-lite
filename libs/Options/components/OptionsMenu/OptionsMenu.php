<?php

namespace Options\Components\OptionsMenu;

use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Nette;

class OptionsMenu extends AControl
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
		$this->template->render($this->templatePath ?: __DIR__ . '/OptionsMenu.latte');
	}

}

interface IOptionsMenuFactory
{
	/** @return OptionsMenu */
	function create();
}
