<?php

namespace App\Components\ContactForm;

use App\Components\IComponentTemplateProvider;
use Nette;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;

class ContactForm extends Nette\Application\UI\Control implements IComponentTemplateProvider
{

	private $templatePath = NULL;

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/ContactForm.latte');
	}

	public function createComponentForm()
	{
		$form = new UI\Form;
		$form->addText('name');
		$form
			->addText('email')
			->setType('email')
			->addRule(UI\Form::EMAIL);
		$form
			->addTextArea('message')
			->setRequired();
		$form->addSubmit('submit');
		$form->onSuccess[] = function (UI\Form $form, ArrayHash $values) {
			$this->presenter->flashMessage(json_encode($values));
			$this->redirect('this');
		};
		return $form;
	}

	public function changeTemplate($templatePath)
	{
		$this->templatePath = $templatePath;
	}

}

interface IContactFormFactory
{
	/** @return ContactForm */
	public function create();
}
