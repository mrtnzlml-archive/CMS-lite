<?php

namespace App\FrontModule\Presenters;

use Articles\Article;
use Articles\ArticleProcess;
use Articles\Query\ArticlesQuery;
use Kdyby\Doctrine\EntityManager;
use Latte;
use Nette;
use Tester\FileMock;

class HomepagePresenter extends BasePresenter
{

	/** @var Nette\Application\UI\ITemplateFactory @inject */
	public $templateFactory;

	/** @var EntityManager @inject */
	public $em;

	/** @var ArticleProcess @inject */
	public $articleProcess;

	public function beforeRender()
	{
		parent::beforeRender();
		$query = (new ArticlesQuery())->withAllAuthors();
		$articles = $this->em->getRepository(Article::class)->fetch($query);
		$articles->setFetchJoinCollection(FALSE);
		$articles->applyPaging(0, 100);
		$this->template->articles = $articles;
	}

}
