<?php

namespace Pages\Presenters;

use App;
use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Pages\Components\PageForm\IPageFormFactory;
use Pages\Components\PagesGrid\IPagesGridFactory;
use Pages\Page;

class AdminPagePresenter extends App\AdminModule\Presenters\BasePresenter
{

	/** @var EntityManager */
	private $em;

	/** @var Page|NULL */
	private $editablePage = NULL;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function actionEdit($id = NULL)
	{
		if ($id === NULL) {
			$this->redirect('new');
		}
		if ($editablePage = $this->em->getRepository(Page::class)->find($id)) {
			$this->editablePage = $editablePage;
		} else {
			$this->redirect('new');
		}
	}

	protected function createComponentPagesGrid(IPagesGridFactory $gridFactory)
	{
		return $gridFactory->create();
	}

	protected function createComponentPageForm(IPageFormFactory $factory)
	{
		$control = $factory->create($this->editablePage);
		$control->onSave[] = function () {
			$this->flashMessage('Stránka byla úspěšně uložena.', Flashes::FLASH_SUCCESS);
		};
		$control->onPublish[] = function () {
			$this->flashMessage('Stránka byla úspěšně uložena a publikována.', Flashes::FLASH_SUCCESS);
		};
		$control->onException[] = function () {
			$this->flashMessage('Stránku se nepodařilo uložit. Kontaktujte prosím technickou podporu.', Flashes::FLASH_DANGER);
		};
		$control->onComplete[] = function () {
			$this->redirect('default');
		};
		return $control;
	}

}
