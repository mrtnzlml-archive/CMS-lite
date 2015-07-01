<?php

namespace App\FrontModule\Presenters;

use Kdyby\Doctrine\EntityManager;
use Latte;
use Nette;
use Pages\Page;
use Pages\Query\PagesQuery;
use Pages\Query\PagesQueryAdmin;

class PagePresenter extends BasePresenter
{

	/** @var EntityManager @inject */
	public $em;

	public function actionDefault($slug)
	{
		$pageQuery = (new PagesQuery)->bySlug($slug);
		$page = $this->em->getRepository(Page::class)->fetchOne($pageQuery);
		if ($page === NULL) {
			$this->error('Page not found.');
		}
		$this->setTitle($page->title);
		$this->template->page = $page;
	}

	public function actionPreview($id)
	{
		if (!$this->user->isLoggedIn()) {
			$this->error('Page not found.');
		}
		$pageQuery = (new PagesQueryAdmin)->preview($id, $this->getUser()->getId());
		$page = $this->em->getRepository(Page::class)->fetchOne($pageQuery);
		if ($page === NULL) {
			$this->error('Page not found.');
		}
		$this->setTitle($page->title);
		$this['meta']->setMeta('robots', 'noindex');
		$this->template->page = $page;
		$this->setView('default');
	}

}
