<?php

namespace App\AuthModule\Presenters;

use App;
use Nette;
use Nette\Application\UI;

/**
 * Sign in/out presenter.
 */
class SignPresenter extends Nette\Application\UI\Presenter
{

	/** @persistent */
	public $backlink = '';

	/**
	 * Sign-in form factory.
	 * @return Nette\Application\UI\Form
	 */
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

	/**
	 * @param $form
	 */
	public function signInFormSucceeded(UI\Form $form, Nette\Utils\ArrayHash $values)
	{
		if ($values->remember) {
			$this->getUser()->setExpiration('+ 14 days', FALSE);
		} else {
			$this->getUser()->setExpiration('+ 20 minutes', TRUE);
		}

		try {
			$this->getUser()->login($values->username, $values->password);
		} catch (Nette\Security\AuthenticationException $e) {
			$form->addError($e->getMessage());
			return;
		}

		$this->restoreRequest($this->backlink);
		$this->redirect('???'); //FIXME
	}

	public function actionOut()
	{
		$this->getUser()->logout();
		$this->flashMessage('Odhlášení bylo úspěšné.', 'info');
		$this->restoreRequest($this->backlink);
		$this->redirect('in');
	}

}
