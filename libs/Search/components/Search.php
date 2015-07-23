<?php

namespace Search\Components;

use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;

class Search extends AControl
{

	private $em;

	public function __construct(EntityManager $entityManager)
	{
		$this->em = $entityManager;
	}

	public function render(array $parameters = NULL)
	{
		$this->template->render(__DIR__ . '/Search.latte');
	}

	/**
	 * @return UI\Form
	 */
	protected function createComponentSearch()
	{
		$form = new UI\Form();
		$form->addText('text', NULL)->setValue($this->presenter->getParameter('search'));
		$form->addSubmit('send', NULL);
		$form->onSuccess[] = function ($_, ArrayHash $values) {
			$this->presenter->redirect(':Search:Search:default', $values->text);
		};
		return $form;
	}

}

interface ISearchFactory
{
	/** @return Search */
	function create();
}
