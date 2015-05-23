<?php

namespace App\Components\SignInForm;

use App\Components\IComponentTemplateProvider;
use Nette;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;

class SignInForm extends Nette\Application\UI\Control implements IComponentTemplateProvider
{

	/** @persistent */
	public $backlink = '';

	private $templatePath = NULL;

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/SignInForm.latte');
	}

	protected function createComponentSignInForm()
	{
		$form = new UI\Form;
		$form->addText('username', 'Uživatelské jméno:')
			->setRequired('Vyplňte prosím uživatelské jméno.');
		$form->addPassword('password', 'Heslo:')
			->setAttribute('autocomplete', 'off')
			->setRequired('Vyplňte prosím heslo.');
		$form->addCheckbox('remember', 'Zůstat přihlášen');
		$form->addSubmit('send', 'Přihlásit');

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

	public function changeTemplate($templatePath)
	{
		$this->templatePath = $templatePath;
	}

}

interface ISignInFormFactory
{
	/** @return SignInForm */
	public function create();
}
