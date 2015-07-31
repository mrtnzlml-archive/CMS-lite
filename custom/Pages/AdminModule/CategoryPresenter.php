<?php

namespace Pages\AdminModule\Presenters;

use App;
use Kdyby\Doctrine\EntityManager;
use Pages\Components\CategoryForm\ICategoryFormFactory;
use Pages\Components\CategoryGrid\ICategoryGridFactory;
use Pages\PageCategory;

class CategoryPresenter extends App\AdminModule\Presenters\BasePresenter
{

	/** @var EntityManager */
	private $em;

	private $categoryEntity = NULL;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function actionEdit($id = NULL)
	{
		if (NULL === $id) {
			$this->redirect('new');
		}
		if ($categoryEntity = $this->em->getRepository(PageCategory::class)->find($id)) {
			$this->categoryEntity = $categoryEntity;
		} else {
			$this->redirect('new');
		}
	}

	protected function createComponentCategoryGrid(ICategoryGridFactory $factory)
	{
		$control = $factory->create();
		return $control;
	}

	protected function createComponentCategoryForm(ICategoryFormFactory $factory)
	{
		$control = $factory->create($this->categoryEntity);
		return $control;
	}


}
