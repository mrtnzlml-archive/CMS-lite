<?php

namespace App\Components\ContactForm;

use App\Components\AControl;
use Nette;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;

/**
 * @method onComponentCreation(ContactForm $control, UI\Form $form)
 */
class ContactForm extends AControl
{

	public $onComponentCreation = [];

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
		$form->setTranslator($this->getTranslator()->domain('component.contactForm'));
		$form->addText('name', 'name.label');
		$form
			->addText('email', 'email.label')
			->setType('email')
			->addRule(UI\Form::EMAIL, 'email.invalid');
		$form
			->addTextArea('message', 'message.label')
			->setRequired('message.required');
		$form->addSubmit('submit', 'submit.caption');
		$form->onSuccess[] = function (UI\Form $form, ArrayHash $values) {
			$this->presenter->flashMessage(json_encode($values));
			$this->redirect('this');
		};
		$this->onComponentCreation($this, $form);
		return $form;
	}

}

interface IContactFormFactory
{
	/** @return ContactForm */
	public function create();
}
