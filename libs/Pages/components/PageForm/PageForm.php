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

	public function __construct(ITranslator $translator = NULL, PageProcess $pageProcess, EntityManager $em)
	{
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
		$form->addMultiSelect('authors', 'Autor:',
			[0 => 'Bez autora'] +
			$this->em->getRepository(User::class)->findPairs('email')
		)->setDefaultValue($this->presenter->user->id);
		$form->addSubmit('save', 'Uložit');
		$form->onSuccess[] = $this->pageFormSucceeded;
		return $form;
	}

	public function pageFormSucceeded(UI\Form $form, Nette\Utils\ArrayHash $values)
	{
		try {
			$page = new Page();
			$page->setTitle($values->title);
			$page->setBody($values->editor);
			if ($values->authors) {
				/** @var User $author */
				foreach ($this->em->getRepository(User::class)->findBy(['id' => $values->authors]) as $author) {
					$page->addAuthor($author);
				}
			}
			$this->pageProcess->onPersist[] = function (PageProcess $process, Page $page) {
				$this->em->flush($page);
				$this->onSave();
			};
			$this->pageProcess->publish($page);
		} catch (\Exception $exc) {
			$this->presenter->flashMessage($exc->getMessage(), 'danger');
		}
		$this->onComplete();
	}

}

interface IPageFormFactory
{
	/** @return PageForm */
	public function create();
}
