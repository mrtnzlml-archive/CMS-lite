<?php

namespace Navigation;

use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette\Application\UI;
use Nette\Application\UI\Control;
use Nette\Utils\ArrayHash;

class MenuEditor extends Control
{

	/** @var EntityManager */
	private $em;

	/** @var NavigationFacade */
	private $navigationFacade;

	public function __construct(EntityManager $em, NavigationFacade $navigationFacade)
	{
		$this->em = $em;
		$this->navigationFacade = $navigationFacade;
	}

	public function render()
	{
		$adminRoot = $this->em->getRepository(NavigationItem::class)->findOneBy(['name' => NavigationFacade::ROOT_ADMIN]);
		$this->template->adminMenu = $this->navigationFacade->getItemTreeBelow($adminRoot->getId());
		$this->template->render(__DIR__ . '/templates/MenuEditor.latte');
	}

	public function createComponentNavigationCreate()
	{
		$form = new UI\Form;
		$form->addText('navigation', 'Název nové navigace')
			->setRequired('Zadejte prosím název nové navigace');
		$form->addSubmit('create', 'Vytvořit navigaci');
		$form->onSuccess[] = function (UI\Form $_, ArrayHash $values) {
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
		$form->addSelect('navigation', 'Navigace', $this->em->getRepository(Navigation::class)->findPairs('name'));
		$form->addSubmit('delete', 'Smazat zvolenou navigaci');
		$form->onSuccess[] = function (UI\Form $_, ArrayHash $values) {
			$partialEntity = $this->em->getPartialReference(Navigation::class, $values->navigation);
			$this->em->remove($partialEntity);
			$this->em->flush($partialEntity);
			$this->presenter->flashMessage('Navigace byla úspěšně smazána.', Flashes::FLASH_SUCCESS);
			$this->redirect('this');
		};
		return $form;
	}

	/**
	 * @secured
	 */
	public function handleUpdateNavigation($json)
	{
		if (!$this->presenter->isAjax()) {
			$this->redirect('this');
		}

		$adminRoot = $this->em->getRepository(NavigationItem::class)->findOneBy(['name' => NavigationFacade::ROOT_ADMIN]);
		$this->navigationFacade->recalculatePathsForNode($adminRoot->getId(), Nestable::resolveJson($json));

		$this->getPresenter()->redrawControl('adminMenu');
	}

}

interface IMenuEditorFactory
{
	/** @return MenuEditor */
	function create();
}
