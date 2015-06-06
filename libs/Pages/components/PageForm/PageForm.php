<?php

namespace Pages\Components\PageForm;

use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Kdyby\Translation\ITranslator;
use Kdyby\Translation\Translator;
use Nette;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;
use Pages\Page;
use Pages\PageCategory;
use Pages\PageProcess;
use Users\User;

class PageForm extends AControl
{

	/** @var \Closure[] */
	public $onSave = [];

	/** @var \Closure[] */
	public $onComplete = [];

	/** @var Translator */
	private $translator;

	/** @var PageProcess */
	private $pageProcess;

	/** @var EntityManager */
	private $em;

	/** @var Page */
	private $editablePage;

	public function __construct($editablePage, ITranslator $translator = NULL, PageProcess $pageProcess, EntityManager $em)
	{
		$this->editablePage = $editablePage;
		$this->translator = $translator;
		$this->pageProcess = $pageProcess;
		$this->em = $em;
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/PageForm.latte');
	}

	public function createComponentPageForm()
	{
		$form = new UI\Form;
		$form->addProtection();
		$form->addText('title', 'Název:')->setRequired('Je zapotřebí vyplnit název stránky.');
		$form->addText('slug', 'URL slug:');
		$form->addTextArea('editor', 'Obsah stránky:')
			->setHtmlId('editor')
			->setRequired('Je zapotřebí napsat nějaký text.');

		$authors = $this->em->getRepository(User::class)->findPairs('email');
		$user_id = $this->presenter->user->id;
		$form->addMultiSelect('authors', 'Autor:',
			[0 => 'Bez autora'] + $authors
		)->setDefaultValue(array_key_exists($user_id, $authors) ? $user_id : 0);

		$form->addMultiSelect('categories', 'Kategorie:',
			[0 => 'Bez kategorie'] +
			$this->em->getRepository(PageCategory::class)->findPairs('name')
		);
		$form->addSubmit('save', 'Uložit');

		if ($this->editablePage) {
			$form->setDefaults([
				'title' => $this->editablePage->title,
				'slug' => $this->editablePage->slug,
				'editor' => $this->editablePage->body,
				//TODO: authors, categories
			]);
		}

		$form->onSuccess[] = $this->pageFormSucceeded;
		return $form;
	}

	public function pageFormSucceeded(UI\Form $form, Nette\Utils\ArrayHash $values)
	{
		try {
			if (!$this->editablePage) {
				$this->editablePage = new Page;
			}
			$this->editablePage->setTitle($values->title);
			$this->editablePage->setBody($values->editor);
			if ($values->authors) {
				/** @var User $author */
				foreach ($this->em->getRepository(User::class)->findBy(['id' => $values->authors]) as $author) {
					//TODO: update autorů
					$this->editablePage->addAuthor($author);
				}
			}
			if ($values->categories) {
				/** @var PageCategory $author */
				foreach ($this->em->getRepository(PageCategory::class)->findBy(['id' => $values->categories]) as $category) {
					//TODO: update kategorií
					$this->editablePage->addCategory($category);
				}
			}
			$this->pageProcess->onPersist[] = function (PageProcess $process, Page $page) {
				$this->em->flush($page);
				$this->onSave();
			};
			$this->pageProcess->publish($this->editablePage);
		} catch (\Exception $exc) {
			$this->presenter->flashMessage($exc->getMessage(), 'danger');
		}
		$this->onComplete();
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
