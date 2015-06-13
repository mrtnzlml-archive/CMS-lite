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

	use App\Traits\PublicComponentsTrait;

	/** @persistent */
	public $locale;

	private $layout;

	public function __construct($layout)
	{
		$this->layout = $layout;
	}

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

	public function findLayoutTemplateFile()
	{
		return $this->layout;
	}

	public function actionOut()
	{
		$this->getUser()->logout();
		$this->flashMessage('Odhlášení bylo úspěšné.', 'info');
		$this->restoreRequest($this->backlink);
		$this->redirect('in');
	}

}
