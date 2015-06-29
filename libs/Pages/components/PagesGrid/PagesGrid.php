<?php

namespace Pages\Components\PagesGrid;

use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Pages\Components\MultiEdit\IMultiEditFactory;
use Pages\Page;
use Pages\Query\PagesQueryAdmin;

class PagesGrid extends AControl
{

	/** @persistent */
	public $multiEdit = [];

	/** @var EntityManager */
	private $em;

	private $pages;

	/** @var IMultiEditFactory */
	private $multiEditFactory;

	public function __construct(EntityManager $em, IMultiEditFactory $multiEditFactory)
	{
		$this->em = $em;
		$this->multiEditFactory = $multiEditFactory;
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
		$this->template->multiEdit = $this->multiEdit;
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/PagesGrid.latte');
	}

	protected function createComponentGridForm()
	{
		$form = new UI\Form();

		$checkboxes = $form->addContainer('page');
		foreach ($this->pages as $page) {
			$checkboxes->addCheckbox($page->id, NULL)
				->setValue(isset($this->multiEdit[$page->id]) ? $this->multiEdit[$page->id] : NULL);
		}

		$form->addSelect('action', NULL, [
			'edit' => 'Editovat',
		]);
		$form->addSubmit('submit');
		$form->onSuccess[] = function ($_, $values) {
			$multiEdit = [];
			foreach ($values->page as $id => $checked) {
				if ($checked) {
					$multiEdit[$id] = $checked;
				}
			}
			$this->multiEdit = $multiEdit;
			$this->redirect('this');
		};
		return $form;
	}

	protected function createComponentMultiEdit()
	{
		return $this->multiEditFactory->create($this->multiEdit);
	}

	/**
	 * @secured
	 */
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
