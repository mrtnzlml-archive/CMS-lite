<?php

namespace App\AdminModule\Presenters;

use App;
use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Localization\ILocaleSelectFactory;
use Localization\Locale;
use Navigation\IAdminMenuFactory;
use Nette;
use Nextras;
use Search\Components\ISearchFactory;
use Users;
use WebLoader;

abstract class BasePresenter extends Nette\Application\UI\Presenter
{

	use App\Traits\PublicComponentsTrait;
	use Nextras\Application\UI\SecuredLinksPresenterTrait;

	/** @persistent */
	public $locale;

	/** @var EntityManager @inject */
	public $_em;

	public function checkRequirements($element)
	{
		parent::checkRequirements($element);
		if (!$this->user->isLoggedIn()) {
			if ($this->user->logoutReason === Nette\Security\IUserStorage::INACTIVITY) {
				$this->flashMessage('Byli jste odhlášeni z důvodu nečinnosti. Přihlaste se prosím znovu.', Flashes::FLASH_DANGER);
			} else {
				$this->flashMessage('Pro vstup do této sekce se musíte přihlásit.', Flashes::FLASH_DANGER);
			}
			$this->redirect(':Auth:Sign:in', ['backlink' => $this->storeRequest()]);
		} elseif (!$this->user->isAllowed($this->name, Users\Authorizator::READ)) {
			//dump($this->name);
			$this->flashMessage('Přístup byl odepřen. Nemáte oprávnění k zobrazení této stránky.', Flashes::FLASH_DANGER);
			$this->redirect(':Auth:Sign:in', ['backlink' => $this->storeRequest()]);
		}
	}

	public function startup()
	{
		parent::startup();
		/** @var Locale $localeEntity */
//		if ($localeEntity = $this->_em->getRepository(Locale::class)->findOneByCode($this->locale)) {
//			$filter = $this->_em->getFilters()->enable('locale');
//			$filter->setParameter('locale', $localeEntity->getId());
//		}
//		TODO: umožnit rychlé vypnutí v extension
	}

	public function createComponentLocaleSelect(ILocaleSelectFactory $factory)
	{
		return $factory->create();
	}

	public function createComponentSearch(ISearchFactory $factory)
	{
		return $factory->create();
	}

	public function beforeRender()
	{
		$this->template->locale = $this->locale;
		$this->template->host = $this->getHttpRequest()->getUrl()->getHost();
	}

	protected function createComponentAdminMenu(IAdminMenuFactory $factory)
	{
		return $factory->create();
	}

	public function findLayoutTemplateFile()
	{
		if ($this->layout === FALSE) {
			return;
		}
        return __DIR__ . DIRECTORY_SEPARATOR . 'templates' . DIRECTORY_SEPARATOR . '@layout.latte';
	}

}
