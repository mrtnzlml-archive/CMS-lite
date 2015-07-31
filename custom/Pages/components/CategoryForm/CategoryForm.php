<?php

namespace Pages\Components\CategoryForm;

use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;
use Pages\PageCategory;
use Pages\PageCategoryProcess;

class CategoryForm extends UI\Control
{

	/** @var PageCategory */
	private $categoryEntity;

	/** @var PageCategoryProcess */
	private $categoryProcess;

	/** @var EntityManager */
	private $em;

	public function __construct($categoryEntity, PageCategoryProcess $categoryProcess, EntityManager $em)
	{
		if ($categoryEntity === NULL) { //NEW
			$categoryEntity = new PageCategory;
		}
		$this->categoryEntity = $categoryEntity;
		$this->categoryProcess = $categoryProcess;
		$this->em = $em;
	}

	public function render()
	{
		$this->template->render(__DIR__ . '/CategoryForm.latte');
	}

	/**
	 * @return UI\Form
	 */
	protected function createComponentCategoryForm()
	{
		$form = new UI\Form();
		$form->addProtection();

		$form->addText('name', 'Název kategorie:')->setRequired('Vyplňte prosím název kategorie.');

		$form->addSubmit('send', 'Odeslat');
		if ($this->categoryEntity->getName()) { //EDIT
			$this->setDefaults($form, $this->categoryEntity);
		}
		$form->onSuccess[] = function (UI\Form $form, ArrayHash $values) {
			if ($this->categoryEntity->getName()) { //EDIT
				$this->categoryEntity->setName($values->name);
				$this->em->persist($this->categoryEntity);
				$this->em->flush($this->categoryEntity);
				$this->presenter->flashMessage('Kategorie byla úspěšně upravena.', Flashes::FLASH_SUCCESS);
				$this->presenter->redirect('default');
			} else {
				$category = $this->categoryProcess->createCategory($values->name);
				if ($category) {
					$this->presenter->flashMessage('Kategorie byla úspěšně vytvořena.', Flashes::FLASH_SUCCESS);
					$this->presenter->redirect('edit', $category->id);
				}
			}
		};
		return $form;
	}

	private function setDefaults(UI\Form $form, PageCategory $category)
	{
		$form->setDefaults([
			'name' => $category->getName(),
		]);
	}

}

interface ICategoryFormFactory
{
	/** @return CategoryForm */
	function create($categoryEntity);
}
