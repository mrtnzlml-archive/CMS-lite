<?php

namespace Pages\Components\PagesGrid;

use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Pages\Page;
use Pages\Query\PagesQueryAdmin;

class PagesGrid extends AControl
{

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	/** @param $presenter UI\Presenter */
	public function attached($presenter)
	{
		parent::attached($presenter);
		/** @var \App\Components\Css\Css $component */
		foreach ($presenter->getComponents(FALSE, \App\Components\Js\Js::class) as $component) {
			//dump($component);
			//TODO: nějakou vlastní komponentu, která umožní podobně přidávat custom styly (ale ne do webloaderu)
		}
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$query = (new PagesQueryAdmin())->withAllAuthors()->withAllCategories();
		$pages = $this->em->getRepository(Page::class)->fetch($query);
		$pages->setFetchJoinCollection(FALSE);
		$pages->applyPaging(0, 100);
		$this->template->pages = $pages;
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/PagesGrid.latte');
	}

	public function handleDelete($id)
	{
		//TODO: is user allowed to delete this page? (same with edit)
		//TODO: should set delete flag instead of actually deleting (?)
		//TODO: log
		if ($page = $this->em->getPartialReference(Page::class, $id)) {
			$this->em->remove($page);
			$this->em->flush($page);
		}
		$this->redirect('this');
	}

}

interface IPagesGridFactory
{
	/** @return PagesGrid */
	function create();
}
