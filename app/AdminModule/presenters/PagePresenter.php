<?php

namespace App\AdminModule\Presenters;

use App;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Pages\Components\PageForm\IPageFormFactory;
use Pages\Page;
use Pages\Query\PagesQuery;

class PagePresenter extends BasePresenter
{

	/** @var EntityManager @inject */
	public $em;

	private $editablePage = NULL;

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

	public function renderDefault()
	{
		$query = (new PagesQuery())->withAllAuthors()->withAllCategories();
		$pages = $this->em->getRepository(Page::class)->fetch($query);
		$pages->setFetchJoinCollection(FALSE);
		$pages->applyPaging(0, 100);
		$this->template->pages = $pages;
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

	public function handleDelete($id)
	{
		//TODO: is user allowed to delete this page? (same with edit)
		if ($page = $this->em->getRepository(Page::class)->find($id)) {
			$this->em->remove($page);
			$this->em->flush($page);
		}
		$this->redirect('this');
	}

}
