<?php

namespace App\Components\SignInForm;

use App\Components\AControl;
use Nette;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;

class SignInForm extends AControl
{

	/** @persistent */
	public $backlink = '';

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/SignInForm.latte');
	}

	protected function createComponentForm()
	{
		$form = new UI\Form;
		$form->setTranslator($this->getTranslator()->domain('component.signInForm'));
		$form->addText('username', 'username.label')
			->setAttribute('placeholder', 'username.label')
			->setRequired('username.required');
		$form->addPassword('password', 'password.label')
			->setAttribute('placeholder', 'password.label')
			->setAttribute('autocomplete', 'off')
			->setRequired('password.required');
		$form->addCheckbox('remember', 'remember.caption');
		$form->addSubmit('send', 'send.caption');

		$form->onSuccess[] = $this->signInFormSucceeded;
		return $form;
	}

	public function signInFormSucceeded(UI\Form $form, Nette\Utils\ArrayHash $values)
	{
		if ($values->remember) {
			$this->presenter->getUser()->setExpiration('+ 14 days', FALSE);
		} else {
			$this->presenter->getUser()->setExpiration('+ 20 minutes', TRUE);
		}

		try {
			$this->presenter->getUser()->login($values->username, $values->password);
		} catch (Nette\Security\AuthenticationException $e) {
			$form->addError($e->getMessage());
			return;
		}

		$this->presenter->restoreRequest($this->backlink);
		$this->presenter->redirect(':Admin:Dashboard:');
	}

}

interface ISignInFormFactory
{
	/** @return SignInForm */
	public function create();
}
