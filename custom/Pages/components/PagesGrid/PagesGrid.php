<?php

namespace Pages\Components\PagesGrid;

use App\Components\AControl;
use Carrooi\NoGrid\DataSource\DoctrineQueryObjectDataSource;
use Carrooi\NoGrid\INoGridFactory;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Pages\Category;
use Pages\Page;
use Pages\PageFacade;
use Pages\Query\PagesQueryAdmin;

class PagesGrid extends AControl
{

	/** @persistent */
	public $category_id = NULL;

	/** @persistent */
	public $tag_id = NULL;

	/** @persistent */
	public $author_id = NULL;

	/** @var EntityManager */
	private $em;

	private $pages;

	/** @var PageFacade */
	private $pageFacade;

	/** @var INoGridFactory */
	private $gridFactory;

	private $total_pages;

	public function __construct(EntityManager $em, PageFacade $pageFacade, INoGridFactory $gridFactory)
	{
		$this->em = $em;
		$this->pageFacade = $pageFacade;
		$this->gridFactory = $gridFactory;
	}

	/** @param $presenter UI\Presenter */
	public function attached($presenter)
	{
		parent::attached($presenter);

		//TODO: zde odstranit a převelet na nogrid
		$query = (new PagesQueryAdmin())
			->withCategories($this->category_id)
			->withTags($this->tag_id)
			->withAuthors($this->author_id);
		$result = $this->em->getRepository(Page::class)->fetch($query);
		$this->pages = $result;
		$this->pages->applyPaging(0, 100)->setFetchJoinCollection(FALSE);
		$this->total_pages = $result->getTotalCount();
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->pages = $this->pages;
		$this->template->total_pages = $this->total_pages;
		$this->template->render($this->templatePath ?: __DIR__ . '/PagesGrid.latte');
	}

	protected function createComponentGrid()
	{
		$query = (new PagesQueryAdmin())
			->withCategories($this->category_id)
			->withTags($this->tag_id)
			->withAuthors($this->author_id);
		$dataSource = new DoctrineQueryObjectDataSource($this->em->getRepository(Page::class), $query);

		$grid = $this->gridFactory->create($dataSource);
		return $grid;
	}

	protected function createComponentGridForm()
	{
		$form = new UI\Form();
		$form->addProtection();

		$checkboxes = $form->addContainer('page');

		$categories = $tags = $authors = [];
		/** @var Page $page */
		foreach ($this->pages as $page) {
			$checkboxes->addCheckbox($page->id, NULL);
			/** @var Category $category */
			foreach ($page->getCategories() as $category) {
				$categories[$category->getId()] = $category->getName();
			}
			foreach ($page->tags as $tag) { //FIXME: toto není moc pěkné
				$tags[$tag->getId()] = $tag->getName();
			}
			foreach ($page->authors as $author) { //FIXME: toto není moc pěkné
				$authors[$author->getId()] = $author->email;
			}
		}

		$form->addSelect('actionAbove', NULL, $actions = [
			NULL => 'Hromadné úpravy',
			'edit' => 'Editovat',
			'delete' => 'Smazat', //TODO js:alert
		]);
		$form->addSelect('actionBelow', NULL, $actions);

		$form->addSelect('categories', NULL, [
				NULL => 'Kategorie',
			] + $categories)->setDefaultValue($this->category_id);
		$form->addSelect('tags', NULL, [
				NULL => 'Štítky',
			] + $tags)->setDefaultValue($this->tag_id);
		$form->addSelect('authors', NULL, [
				NULL => 'Autor',
			] + $authors)->setDefaultValue($this->author_id);

//		$form->addSubmit('submit');

		$form->onSuccess[] = $this->gridFormSucceeded;
		return $form;
	}

	public function gridFormSucceeded($_, Nette\Utils\ArrayHash $values)
	{
		$this->category_id = $values->categories;
		$this->tag_id = $values->tags;
		$this->author_id = $values->authors;

		$multiEdit = [];
		foreach ($values->page as $id => $checked) {
			if ($checked) {
				$multiEdit[$id] = $id;
			}
		}
		$action = $values->actionBelow ?: $values->actionAbove;
		if ($action === 'edit') {
			$this->presenter->redirect(':Pages:Admin:Page:multiEdit', [$multiEdit]);
		} elseif ($action === 'delete') {
			$this->pageFacade->onRemove[] = function () {
				$this->em->flush();
				$this->redirect('this');
			};
			$this->pageFacade->remove($multiEdit);
		} else {
			$this->redirect('this');
		}
	}

	/**
	 * @secured
	 * @deprecated
	 */
	public function handleDelete($id)
	{
		//TODO: is user allowed to delete this page? (same with edit)
		$this->pageFacade->onRemove[] = function (PageFacade $process, Page $page) {
			$this->em->flush();
			$this->redirect('this');
		};
		$this->pageFacade->remove($id);
	}

}

interface IPagesGridFactory
{
	/** @return PagesGrid */
	function create();
}
