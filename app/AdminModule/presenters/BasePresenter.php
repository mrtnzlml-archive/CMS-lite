<?php

namespace App\AdminModule\Presenters;

use App;
use Nette;
use Nextras;
use Users;
use WebLoader;

abstract class BasePresenter extends Nette\Application\UI\Presenter
{

	use App\Traits\PublicComponentsTrait;
	use Nextras\Application\UI\SecuredLinksPresenterTrait;

	/** @persistent */
	public $locale;

	public function checkRequirements($element)
	{
		parent::checkRequirements($element);
		if (!$this->user->isLoggedIn()) {
			if ($this->user->logoutReason === Nette\Security\IUserStorage::INACTIVITY) {
				$this->flashMessage('Byli jste odhlášeni z důvodu nečinnosti. Přihlaste se prosím znovu.', 'danger');
			} else {
				$this->flashMessage('Pro vstup do této sekce se musíte přihlásit.', 'danger');
			}
			$this->redirect(':Auth:Sign:in', ['backlink' => $this->storeRequest()]);
		} elseif (!$this->user->isAllowed($this->name, Users\Authorizator::READ)) {
			$this->flashMessage('Přístup byl odepřen. Nemáte oprávnění k zobrazení této stránky.', 'danger');
			$this->redirect(':Auth:Sign:in', ['backlink' => $this->storeRequest()]);
		}
	}

	public function beforeRender()
	{
		$this->template->locale = $this->locale;
	}

	protected function createComponentAdminMenu(App\AdminModule\Components\IAdminMenuFactory $factory)
	{
		return $factory->create();
	}

}
