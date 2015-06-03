<?php

namespace App\Presenters;

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

		//What about XSS?
		$textFormDb = '<b>Toto je komponenta vložená z databáze:</b> {control contactForm, param => 42}';

		$template = $this->templateFactory->createTemplate($this);
		$template->setFile(FileMock::create($textFormDb)); //FIXME: lepší použít Latte s StringLoader než file mock ($latte = $template->getLatte();)

//		$template->param = ...
//		$latte = $template->getLatte(); //Latte\Engine
//		$latte->setLoader(new Latte\Loaders\StringLoader);
//		$rendered = $latte->renderToString($textFormDb, $template->getParameters());

		$this->template->text = Nette\Utils\Html::el()->setHtml($template);


		//QueryObject fetch example:
		$query = (new ArticlesQuery())->withAllAuthors();
		$articles = $this->em->getRepository(Article::class)->fetch($query);
		$articles->setFetchJoinCollection(FALSE);
		$articles->applyPaging(0, 100);
		$this->template->articles = $articles;
	}

}
