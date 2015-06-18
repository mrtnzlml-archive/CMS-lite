<?php

namespace App\FrontModule\Presenters;

use Kdyby\Doctrine\EntityManager;
use Latte;
use Nette;
use Pages\Page;

class PagePresenter extends BasePresenter
{

	/** @var EntityManager @inject */
	public $em;

	public function actionDefault($slug)
	{
		$page = $this->em->getRepository(Page::class)->findOneBy(['slug' => $slug]);
		$this->setTitle($page->title);
		$this->template->page = $page;
	}

}
