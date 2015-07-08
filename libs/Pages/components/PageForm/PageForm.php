<?php

namespace Pages\Components\PageForm;

use App\Components\AControl;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Nette\Forms\Controls\SubmitButton;
use Nette\Utils\ArrayHash;
use Nette\Utils\Strings;
use Pages\Page;
use Pages\PageCategory;
use Pages\PageProcess;
use Url\Components\RedirectForm\IRedirectFormFactory;
use Url\DuplicateRouteException;
use Url\RouteGenerator;
use Users\User;

/**
 * @method onSave(PageForm $control, Page $entity)
 * @method onPublish(PageForm $control, Page $entity)
 * @method onComplete(PageForm $control)
 * @method onException(PageForm $control, \Exception $exc)
 */
class PageForm extends AControl
{

	/** @var \Closure[] */
	public $onSave = [];

	/** @var \Closure[] */
	public $onPublish = [];

	/** @var \Closure[] */
	public $onComplete = [];

	/** @var \Closure[] */
	public $onException = [];

	/** @var PageProcess */
	private $pageProcess;

	/** @var EntityManager */
	private $em;

	/** @var Page */
	private $editablePage;

	public function __construct($editablePage, PageProcess $pageProcess, EntityManager $em)
	{
		if ($editablePage === NULL) { //NEW
			$editablePage = new Page;
		}
		$this->editablePage = $editablePage;
		$this->pageProcess = $pageProcess;
		$this->em = $em;
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = ArrayHash::from($parameters);
		}
		$this->template->showPublish = $this->editablePage->isPublished() ? FALSE : TRUE;
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/PageForm.latte');
	}

	protected function createComponentRedirectForm(IRedirectFormFactory $factory)
	{
		return $factory->create($this->editablePage->getId());
	}

	protected function createComponentPageForm()
	{
		$form = new UI\Form;
		$form->addProtection();
		$form->addText('title', 'Název:')->setRequired('Je zapotřebí vyplnit název stránky.');
		$form->addText('slug', 'URL stránky:');
		$form->addTinyMCE('editor', NULL)
			->setRequired('Je zapotřebí napsat nějaký text.');

		$authors = $this->em->getRepository(User::class)->findPairs('email');
		$user_id = $this->presenter->user->id;
		$form->addMultiSelect('authors', 'Autor:',
			[NULL => 'Bez autora'] + $authors
		)->setDefaultValue(array_key_exists($user_id, $authors) ? $user_id : NULL);

		$form->addMultiSelect('categories', 'Kategorie:',
			[NULL => 'Bez kategorie'] +
			$this->em->getRepository(PageCategory::class)->findPairs('name')
		);

		// OPTIMIZATION:
		$form->addText('individualTitle', 'Individuální titulek:');
		$form->addTextArea('description', 'Popis stránky (Description):');
		$form->addSelect('index', 'Indexace stránky:', [
			NULL => 'Výchozí',
			'index' => 'Indexovat (index)',
			'noindex' => 'Neindexovat (noindex)',
		]);
		$form->addSelect('follow', 'Sledování odkazů', [
			NULL => 'Výchozí',
			'follow' => 'Sledovat (follow)',
			'nofollow' => 'Nesledovat (nofollow)',
		]);

		$this->setDefaults($form);
		$form->addSubmit('save', 'Uložit')->onClick[] = $this->savePage;
		$form->addSubmit('publish', 'Publikovat')->onClick[] = $this->publishPage;
		$form->addSubmit('preview', 'Zobrazit stránku')->onClick[] = function (SubmitButton $sender) {
			$this->savePage($sender, TRUE);
		};
		return $form;
	}

	public function savePage(SubmitButton $sender, $preview = FALSE)
	{
		try {
			$entity = $this->editablePage;
			$values = $sender->getForm()->getValues();
			$this->fillEntityWithValues($entity, $values);
			$this->pageProcess->onSave[] = function (PageProcess $process, Page $page) use ($entity, $values) {
				$this->em->flush($page);
				$this->setUrl($page, $values);
				$this->onSave($this, $entity);
			};
			$this->pageProcess->save($entity);
		} catch (DuplicateRouteException $exc) {
			$this->presenter->flashMessage($exc->getMessage());
			return;
		} catch (\Exception $exc) {
			$this->onException($this, $exc);
			return;
		}
		if ($preview) {
			$this->presenter->redirect(':Front:Page:preview', $entity->id);
		}
		$this->onComplete($this);
	}

	public function publishPage(SubmitButton $sender)
	{
		try {
			$entity = $this->editablePage;
			$values = $sender->getForm()->getValues();
			$this->fillEntityWithValues($entity, $values);
			$this->pageProcess->onPublish[] = function (PageProcess $process, Page $page) use ($entity, $values) {
				$this->em->flush($page);
				$this->setUrl($page, $values);
				$this->onPublish($this, $entity);
			};
			$this->pageProcess->publish($entity);
		} catch (DuplicateRouteException $exc) {
			$this->presenter->flashMessage($exc->getMessage());
			return;
		} catch (\Exception $exc) {
			$this->onException($this, $exc);
			return;
		}
		$this->onComplete($this);
	}

	/**
	 * TODO: měnit jen někdy a když už, tak použít ještě \Url\RedirectFacade::createRedirect
	 *
	 * @param Page $page
	 * @param ArrayHash $values
	 *
	 * @throws DuplicateRouteException
	 */
	private function setUrl(Page $page, ArrayHash $values)
	{
		$page->setUrl(RouteGenerator::generate(
			empty($values->slug) ? Strings::webalize($values->title) : Strings::webalize($values->slug),
			'Front:Page:default', $page->getId()
		));
		try {
			$this->em->flush($page);
		} catch (UniqueConstraintViolationException $exc) {
			throw new DuplicateRouteException;
		}
	}

	private function fillEntityWithValues(Page $entity, ArrayHash $values)
	{
		$entity->setTitle($values->title);
		$entity->setBody($values->editor);
		$entity->setIndividualTitle($values->individualTitle);
		$entity->setDescription($values->description);
		$entity->setIndex($values->index);
		$entity->setFollow($values->follow);

		$entity->clearAuthors();
		if (!in_array(NULL, $values->authors)) {
			foreach ($values->authors as $authorId) {
				$authorRef = $this->em->getPartialReference(User::class, $authorId);
				$entity->addAuthor($authorRef);
			}
		}

		$entity->clearCategories();
		if (!in_array(NULL, $values->categories)) {
			foreach ($values->categories as $categoryId) {
				$categoryRef = $this->em->getPartialReference(PageCategory::class, $categoryId);
				$entity->addCategory($categoryRef);
			}
		}
	}

	private function setDefaults(UI\Form $form)
	{
		if ($this->editablePage !== NULL) { //EDITING
			$form->setDefaults([
				'title' => $this->editablePage->title,
				'editor' => $this->editablePage->body,
				'authors' => $this->editablePage->getAuthorsIds(),
				'categories' => $this->editablePage->getCategoriesIds(),
				'individualTitle' => $this->editablePage->getIndividualTitle(),
				'description' => $this->editablePage->getDescription(),
				'index' => $this->editablePage->getIndex(),
				'follow' => $this->editablePage->getFollow(),
			]);
		}
	}

}

interface IPageFormFactory
{
	/**
	 * @param NULL|Page $editablePage
	 *
	 * @return PageForm
	 */
	public function create($editablePage);
}
