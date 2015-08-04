<?php

namespace Pages\Components\CategoryGrid;

use Carrooi\NoGrid\DataSource\DoctrineQueryObjectDataSource;
use Carrooi\NoGrid\INoGridFactory;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Pages\Category;
use Pages\Query\CategoryQuery;

class CategoryGrid extends UI\Control
{

	/** @var EntityManager */
	private $em;

	/** @var INoGridFactory */
	private $gridFactory;

	private $categories;

	public function __construct(EntityManager $em, INoGridFactory $gridFactory)
	{
		$this->em = $em;
		$this->gridFactory = $gridFactory;

		$query = new CategoryQuery;
		$categories = $this->em->getRepository(Category::class)->fetch($query);
		$this->categories = $categories;
	}

	public function render()
	{
		$this->template->render(__DIR__ . '/CategoryGrid.latte');
	}

	public function createComponentGrid()
	{
		$grid = $this->gridFactory->create(new DoctrineQueryObjectDataSource(
			$this->em->getRepository(Category::class),
			new CategoryQuery
		));
		return $grid;
	}

	/**
	 * @return UI\Form
	 */
	protected function createComponentGridForm()
	{
		$form = new UI\Form();

		$checkboxes = $form->addContainer('category');
		foreach ($this->categories as $category) {
			$checkboxes->addCheckbox($category->id, NULL);
		}

		$form->addSubmit('send', 'Odeslat');
		$form->onSuccess[] = function (UI\Form $form) {
			throw new Nette\NotImplementedException;
		};
		return $form;
	}

}

interface ICategoryGridFactory
{
	/** @return CategoryGrid */
	function create();
}
