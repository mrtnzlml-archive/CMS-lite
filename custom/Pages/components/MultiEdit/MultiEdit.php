<?php

namespace Pages\Components\MultiEdit;

use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Pages\Page;
use Pages\PageCategory;
use Users\User;

class MultiEdit extends UI\Control
{

	/** @var array */
	private $ids;

	/** @var EntityManager */
	private $em;

	public function __construct(array $ids, EntityManager $em)
	{
		$this->ids = $ids;
		$this->em = $em;
	}

	public function render()
	{
		$this->template->render(__DIR__ . '/MultiEdit.latte');
	}

	protected function createComponentMultiEdit()
	{
		$form = new UI\Form;
		$form->addProtection();
		$form->addMultiSelect('pages', 'Upravované články:',
			$this->em->getRepository(Page::class)->findPairs(['id' => $this->ids], 'title')
		)->setDisabled(TRUE);
		$form->addMultiSelect('authors', 'Autor:',
			[NULL => 'Bez autora'] + $this->em->getRepository(User::class)->findPairs('email')
		);
		$form->addMultiSelect('categories', 'Kategorie:',
			[NULL => 'Bez kategorie'] + $this->em->getRepository(PageCategory::class)->findPairs('name')
		);
		$form->addSelect('index', 'Indexace stránky:', [ //FIXME: DRY
			NULL => 'Výchozí',
			'index' => 'Indexovat (index)',
			'noindex' => 'Neindexovat (noindex)',
		]);
		$form->addSelect('follow', 'Sledování odkazů', [ //FIXME: DRY
			NULL => 'Výchozí',
			'follow' => 'Sledovat (follow)',
			'nofollow' => 'Nesledovat (nofollow)',
		]);
		$form->addSubmit('submit');
		$form->onSuccess[] = $this->multiEditSucceeded;
		return $form;
	}

	public function multiEditSucceeded(UI\Form $form, Nette\Utils\ArrayHash $values)
	{
		foreach ($this->ids as $page_id) {
			/** @var Page $page */
			$page = $this->em->find(Page::class, $page_id);

			$page->clearAuthors();
			if (!in_array(NULL, $values->authors)) {
				foreach ($values->authors as $authorId) {
					/** @var User $authorRef */
					$authorRef = $this->em->getPartialReference(User::class, $authorId);
					$page->addAuthor($authorRef);
				}
			}

			$page->clearCategories();
			if (!in_array(NULL, $values->categories)) {
				foreach ($values->categories as $categoryId) {
					/** @var PageCategory $categoryRef */
					$categoryRef = $this->em->getPartialReference(PageCategory::class, $categoryId);
					$page->addCategory($categoryRef);
				}
			}

			$page->setIndex($values->index);
			$page->setFollow($values->follow);
			$this->em->persist($page);
			//FIXME: batch processing?
		}
		$this->em->flush();
		$this->presenter->flashMessage('Změny úspěšně uloženy.', Flashes::FLASH_SUCCESS);
		$this->presenter->redirect('default');
	}

}

interface IMultiEditFactory
{
	/** @return MultiEdit */
	function create(array $ids);
}
