<?php

namespace Pages\Components\MultiEdit;

use Nette;
use Nette\Application\UI;

class MultiEdit extends UI\Control
{

	private $ids;

	public function __construct($ids)
	{
		$this->ids = $ids;
	}

	public function render()
	{
		$this->template->render(__DIR__ . '/templates/MultiEdit.latte');
	}

	protected function createComponentMultiEdit()
	{
		$form = new UI\Form;
		$form->addSelect('visibility');
		$form->addSubmit('submit');
		$form->onSuccess[] = function () {
			$this->getPresenter()->flashMessage('Updating: ' . json_encode($this->ids));
			$this->getParent()->multiEdit = NULL;
			$this->redirect('this');
		};
		return $form;
	}

}

interface IMultiEditFactory
{
	/** @return MultiEdit */
	function create($ids);
}
