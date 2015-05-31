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

	/** @var IPageFormFactory @inject */
	public $pageFormFactory;

	public function renderDefault()
	{
		$query = (new PagesQuery())->withAllAuthors()->withAllCategories();
		$pages = $this->em->getRepository(Page::class)->fetch($query);
		$pages->setFetchJoinCollection(FALSE);
		$pages->applyPaging(0, 100);
		$this->template->pages = $pages;
	}

	protected function createComponentPageForm()
	{
		$control = $this->pageFormFactory->create();
		$control->onSave[] = function () {
			$this->flashMessage('Stránka byla úspěšně uložena.', 'success');
		};
		$control->onComplete[] = function () {
			$this->redirect('default');
		};
		return $control;
	}

}
