<?php

namespace App\AdminModule\Presenters;

use App;
use Articles\Article;
use Articles\ArticleProcess;
use Articles\Query\ArticlesQuery;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;

class PagePresenter extends App\Presenters\BasePresenter
{

	/** @var \Closure[] */
	public $onSave = [];

	/** @var EntityManager @inject */
	public $em;

	/** @var ArticleProcess @inject */
	public $articleProcess;

	public function renderDefault()
	{
		$query = (new ArticlesQuery())->withAllAuthors();
		$articles = $this->em->getRepository(Article::class)->fetch($query);
		$articles->setFetchJoinCollection(FALSE);
		$articles->applyPaging(0, 100);
		$this->template->articles = $articles;
	}

	protected function createComponentPageForm()
	{
		$form = new UI\Form;
		$form->addProtection();
		$form->addText('title', 'Název:')->setRequired('Je zapotřebí vyplnit název stránky.');
		$form->addText('slug', 'URL slug:');
		$form->addTextArea('editor', 'Obsah stránky:')
			->setHtmlId('editor')
			->setRequired('Je zapotřebí napsat nějaký text.');
		$form->addSubmit('save', 'Uložit');
		$form->onSuccess[] = $this->pageFormSucceeded;
		return $form;
	}

	public function pageFormSucceeded(UI\Form $form, Nette\Utils\ArrayHash $values)
	{
		try {
			$article = new Article();
			$article->setTitle($values->title);
			$article->setBody($values->editor);
			$this->articleProcess->onPersist[] = function (ArticleProcess $process, Article $article) {
				$this->em->flush($article);
				$this->flashMessage('OK', 'danger');
				$this->onSave();
			};
			$this->articleProcess->publish($article);
		} catch (\Exception $exc) {
			$this->presenter->flashMessage($exc->getMessage(), 'danger');
		}
		$this->redirect('this');
	}

}
