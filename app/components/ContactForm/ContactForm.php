<?php

namespace App\Components\ContactForm;

use App\Components\AControl;
use Kdyby\Translation\ITranslator;
use Kdyby\Translation\Phrase;
use Kdyby\Translation\Translator;
use Nette;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;

class ContactForm extends AControl
{

	/** @var Translator */
	private $translator;

	public function __construct(ITranslator $translator = NULL)
	{
		$this->translator = $translator;
	}

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
		$form->setTranslator($this->translator->domain('contactForm'));
		$form->addText('name');
		$form
			->addText('email')
			->setType('email')
			->addRule(UI\Form::EMAIL, new Phrase('useValidEmail'));
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

}

interface IContactFormFactory
{
	/** @return ContactForm */
	public function create();
}
