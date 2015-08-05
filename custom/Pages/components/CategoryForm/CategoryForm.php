<?php

namespace Pages\Components\CategoryForm;

use App\Components\AControl;
use App\Components\Flashes\Flashes;
use Files\Components\IUploaderFactory;
use Files\File;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\Responses\JsonResponse;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;
use Pages\Category;
use Pages\CategoryFacade;
use Pages\Page;
use Pages\Query\PagesQuery;
use Url\DuplicateRouteException;

class CategoryForm extends AControl
{

	/** @var Category */
	private $categoryEntity;

	/** @var CategoryFacade */
	private $categoryFacade;

	/** @var EntityManager */
	private $em;

	public function __construct($categoryEntity, CategoryFacade $categoryFacade, EntityManager $em)
	{
		if ($categoryEntity === NULL) { //NEW
			$categoryEntity = new Category;
		}
		$this->categoryEntity = $categoryEntity;
		$this->categoryFacade = $categoryFacade;
		$this->em = $em;
	}

	public function render(array $parameters = NULL)
	{
		$query = (new PagesQuery)->byCategoryId($this->categoryEntity->getId());
		$this->template->pages = $this->em->getRepository(Page::class)->fetch($query);
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
//		$form->addSelect('parent', 'Rodičovská kategorie:',
//			[NULL => 'Žádná'] + $this->em->getRepository(Category::class)->findPairs(['id neq' => $this->categoryEntity->getId()], 'name')
//		);
		$form->addText('fakePath', 'URL cesta:')
			->addCondition($form::FILLED)
			->addRule(\App\Validator::FAKE_PATH, 'URL cesta může obsahovat pouze písmena, čísla, lomítko a pomlčku.');
		$form->addTinyMCE('before', 'Text před výpisem kategorie:');
		$form->addTinyMCE('after', 'Text za výpisem kategorie:');

		$form->addSubmit('send', 'Odeslat');
		if ($this->categoryEntity->getName()) { //EDIT
			$this->setDefaults($form, $this->categoryEntity);
		}
		$form->onSuccess[] = $this->categoryFormSucceeded;
		return $form;
	}

	public function categoryFormSucceeded(UI\Form $form, ArrayHash $values)
	{
		try {
			$this->categoryFacade->saveCategory($this->categoryEntity, $values);
			$this->presenter->flashMessage('Kategorie byla úspěšně uložena.', Flashes::FLASH_SUCCESS);
		} catch (DuplicateRouteException $exc) {
			$this->presenter->flashMessage('Tato URL adresa je již zabraná, zvolte prosím jinou.', Flashes::FLASH_WARNING);
			exit;
		}
		$this->presenter->redirect('default');
	}

	private function setDefaults(UI\Form $form, Category $category)
	{
		$form->setDefaults([
			'name' => $category->getName(),
			'before' => $category->getTextBefore(),
			'after' => $category->getTextAfter(),
			'fakePath' => $category->getUrl() ? $category->getUrl()->getFakePath() : '',
		]);
	}

	protected function createComponentPicturesUploader(IUploaderFactory $factory)
	{
		$control = $factory->create(TRUE);

		$control->onSuccess[] = function ($_, File $file, array $result) {
			$this->categoryEntity->addFile($file);
			$this->em->flush($this->categoryEntity);
			$this->presenter->sendResponse(new JsonResponse($result));
		};

		$control->onFailed[] = function ($_, array $result) {
			$this->presenter->sendResponse(new JsonResponse($result));
		};

		return $control;
	}

}

interface ICategoryFormFactory
{
	/** @return CategoryForm */
	function create($categoryEntity);
}
