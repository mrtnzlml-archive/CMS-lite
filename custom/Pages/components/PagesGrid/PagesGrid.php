<?php

namespace Pages\Components\PagesGrid;

use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Pages\Page;
use Pages\PageFacade;
use Pages\Query\PagesQueryAdmin;

class PagesGrid extends AControl
{

	/** @var EntityManager */
	private $em;

	private $pages;

	/** @var PageFacade */
	private $pageFacade;

	public function __construct(EntityManager $em, PageFacade $pageFacade)
	{
		$this->em = $em;
		$this->pageFacade = $pageFacade;
	}

	/** @param $presenter UI\Presenter */
	public function attached($presenter)
	{
		parent::attached($presenter);

		$query = (new PagesQueryAdmin())->withAllAuthors()->withAllCategories();
		$this->pages = $this->em->getRepository(Page::class)->fetch($query);
		$this->pages->applyPaging(0, 100)->setFetchJoinCollection(FALSE);

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
		$this->template->pages = $this->pages;
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/PagesGrid.latte');
	}

	protected function createComponentGridForm()
	{
		$form = new UI\Form();

		$checkboxes = $form->addContainer('page');
		foreach ($this->pages as $page) {
			$checkboxes->addCheckbox($page->id, NULL);
		}

		$form->addSelect('action', NULL, [
			'edit' => 'Editovat',
			'delete' => 'Smazat',
		]);
		$form->addSubmit('submit');
		$form->onSuccess[] = function ($_, $values) {
			$multiEdit = [];
			foreach ($values->page as $id => $checked) {
				if ($checked) {
					$multiEdit[$id] = $id;
				}
			}
			if ($values->action === 'edit') {
				$this->presenter->redirect(':Pages:AdminPage:multiEdit', [$multiEdit]);
			} else {
				$this->pageFacade->onRemove[] = function () {
					$this->em->flush();
					$this->redirect('this');
				};
				$this->pageFacade->remove($multiEdit);
			}
		};
		return $form;
	}

	/**
	 * @secured
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
