<?php

namespace Pages\FrontModule\Presenters;

use App\FrontModule\Presenters\BasePresenter;
use Kdyby\Doctrine\EntityManager;
use Pages\Page;
use Pages\PageCategory;
use Pages\Query\PagesQuery;

class CategoryPresenter extends BasePresenter
{

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function actionDefault($id = NULL)
	{
		if (NULL === $id) {
			$this->redirect(':Front:Homepage:default');
		}
		$category = $this->em->getRepository(PageCategory::class)->find($id);
		if (!$category) {
			$this->error();
		}
		$query = (new PagesQuery)->byCategoryId($id);
		$this->template->pages = $this->em->getRepository(Page::class)->fetch($query);
	}

}
