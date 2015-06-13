<?php

namespace App\AdminModule\Presenters;

use App;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Pages\Components\PageForm\IPageFormFactory;
use Pages\Components\PagesGrid\IPagesGridFactory;
use Pages\Page;

class PagePresenter extends BasePresenter
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
			$this->flashMessage('Stránka byla úspěšně uložena.', 'success');
		};
		$control->onComplete[] = function () {
			$this->redirect('default');
		};
		return $control;
	}

}
