<?php

namespace App\AdminModule\Presenters;

use App;
use Nette;
use Nette\Application\UI;

class DashboardPresenter extends Nette\Application\UI\Presenter
{

	public function startup()
	{
		parent::startup();
		if (!$this->user->isLoggedIn()) {
			if ($this->user->logoutReason === Nette\Security\IUserStorage::INACTIVITY) {
				$this->flashMessage('Byli jste odhlášeni z důvodu nečinnosti. Přihlaste se prosím znovu.', 'danger');
			}
			$this->redirect(':Auth:Sign:in', ['backlink' => $this->storeRequest()]);
		} /*elseif (!$this->user->isAllowed($this->name, 'TODO')) { //TODO
			$this->flashMessage('Přístup byl odepřen. Nemáte oprávnění k zobrazení této stránky.', 'danger');
			$this->redirect(':Auth:Sign:in', ['backlink' => $this->storeRequest()]);
		}*/
	}

}
