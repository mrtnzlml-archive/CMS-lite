<?php

namespace Navigation;

use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette\Application\UI;
use Nette\Application\UI\Control;
use Nette\Forms\Controls\SubmitButton;
use Nette\Utils\ArrayHash;
use Nextras\Application\UI\SecuredLinksControlTrait;
use Pages\Page;
use Pages\Query\PagesQuery;

class MenuEditor extends Control
{

	use SecuredLinksControlTrait;

	/** @var EntityManager */
	private $em;

	/** @var NavigationFacade */
	private $navigationFacade;

	/**
	 * @persistent
	 * @var null|Navigation
	 */
	public $navigation_id = NULL;

	/** @var NavigationItem */
	private $item_root;

	public function __construct(EntityManager $em, NavigationFacade $navigationFacade)
	{
		$this->em = $em;
		$this->navigationFacade = $navigationFacade;
	}

	public function attached($presenter)
	{
		parent::attached($presenter);

		if ($presenter instanceof UI\Presenter) {
			if ($this->navigation_id === NULL) {
				$this->navigation_id = $this->em->getRepository(Navigation::class)->findOneBy([])->getId();
			}
			$this->item_root = $this->em->getRepository(NavigationItem::class)->findOneBy([
				'root' => TRUE,
				'navigations.id' => $this->navigation_id,
			]);
		}
	}

	public function render()
	{
		$this->template->menuItems = $this->navigationFacade->getItemTreeBelow($this->item_root->getId());
		$this->template->render(__DIR__ . '/templates/MenuEditor.latte');
	}

	public function createComponentNavigationCreate()
	{
		$form = new UI\Form;
		$form->addText('navigation', 'Název nové navigace')
			->setRequired('Zadejte prosím název nové navigace');
		$form->addSubmit('create', 'Vytvořit navigaci');
		$form->onSuccess[] = function ($_, ArrayHash $values) {
			$navigation = (new Navigation)->setName($values->navigation);
			$this->em->persist($navigation);
			$this->em->flush($navigation);
			$this->presenter->flashMessage('Nové menu bylo úspěšně vytvořeno.', Flashes::FLASH_SUCCESS);
			$this->redirect('this');
		};
		return $form;
	}

	public function createComponentNavigationSelect()
	{
		$form = new UI\Form;
		$form->addSelect('navigation', 'Navigace',
			$this->em->getRepository(Navigation::class)->findPairs('name')
		)->setDefaultValue($this->navigation_id ?: NULL);
		$form->addSubmit('delete', 'Smazat zvolenou navigaci')->onClick[] = function (SubmitButton $submitButton) {
			$values = $submitButton->getForm()->getValues();
			$partialEntity = $this->em->getPartialReference(Navigation::class, $values->navigation);
			$this->em->remove($partialEntity);
			$this->em->flush($partialEntity);
			$this->presenter->flashMessage('Navigace byla úspěšně smazána.', Flashes::FLASH_SUCCESS);
			$this->redirect('this');
		};
		$form->addSubmit('load', 'Načíst')->onClick[] = function (SubmitButton $submitButton) {
			$values = $submitButton->getForm()->getValues();
			$this->redirect('this', ['navigation_id' => $values->navigation]);
		};
		return $form;
	}

	public function createComponentMenuItems()
	{
		$form = new UI\Form;

		$pages = $this->em->getRepository(Page::class)->fetch(new PagesQuery);
		$items = [];
		/** @var Page $page */
		foreach ($pages as $page) {
			$items[$page->getId()] = $page->getTitle();
		}
		$form->addSelect('pages', 'Publikované stránky:', $items);
		$form->addText('title', 'Alternativní název:');
		$form->addText('href', 'URL adresa')
			->addCondition($form::FILLED)
			->addRule($form::URL, 'Vyplňte prosím platnou URL adresu');
		$form['title']->addConditionOn($form['href'], $form::FILLED)
			->setRequired('Vyplňte prosím alternativní název odkazu.');

		$form->onSuccess[] = function ($_, ArrayHash $values) {
			$menuItem = new NavigationItem;
			if ($values->href) {
				$menuItem->setName($values->title);
				$menuItem->setExternalUrl($values->href);
			} else {
				/** @var Page $page */
				$page = $this->em->find(Page::class, $values->pages);
				$menuItem->setName($values->title ?: $page->getTitle());
				$menuItem->setUrl($page->getUrl());
			}
			$this->navigationFacade->createItem(
				$menuItem,
				$this->em->find(Navigation::class, $this->navigation_id),
				md5(\Navigation\AdminMenu::class) //FIXME!
			);
			$this->redirect('this'); //If AJAX redraw menu editor
		};

		$form->addSubmit('addItem', 'Přidat do menu');
		return $form;
	}

	/**
	 * FIXME: @secured
	 */
	public function handleUpdateNavigation($json)
	{
		if (!$this->presenter->isAjax()) {
			$this->redirect('this');
		}

		$root = $this->em->getRepository(NavigationItem::class)->findOneBy([
			'root' => 1,
			'navigations.id' => $this->navigation_id,
		]);
		$this->navigationFacade->recalculatePathsForNode($root->getId(), Nestable::resolveJson($json));

		$this->getPresenter()->redrawControl('adminMenu');
	}

	/**
	 * FIXME: @secured
	 */
	public function handleDeleteNavigationItem($id)
	{
		$partialEntity = $this->em->getPartialReference(NavigationItem::class, $id);
		$this->em->remove($partialEntity);
		$this->em->flush($partialEntity);
		$this->redirect('this');
	}

}

interface IMenuEditorFactory
{
	/** @return MenuEditor */
	function create();
}
