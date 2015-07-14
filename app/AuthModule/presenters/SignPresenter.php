<?php

namespace App\AuthModule\Presenters;

use App;
use App\Components\Flashes\Flashes;
use Nette;
use Nette\Application\UI;

/**
 * Sign in/out presenter.
 */
class SignPresenter extends App\FrontModule\Presenters\BasePresenter
{

	/** @persistent */
	public $backlink = '';

	use App\Traits\PublicComponentsTrait;

	/** @persistent */
	public $locale;

	public function startup()
	{
		parent::startup();
		if ($this->action != 'out' && $this->user->isLoggedIn()) {
			$this->redirect(':Admin:Dashboard:');
		}
	}

	public function beforeRender()
	{
		$this->template->locale = $this->locale;
	}

	public function actionOut()
	{
		//TODO: CSRF protection?
		$this->getUser()->logout();
		$this->flashMessage('Odhlášení bylo úspěšné.', Flashes::FLASH_INFO);
		$this->restoreRequest($this->backlink);
		$this->redirect('in');
	}

}
