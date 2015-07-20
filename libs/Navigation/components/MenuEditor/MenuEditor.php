<?php

namespace Navigation;

use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette\Application\UI;
use Nette\Application\UI\Control;
use Nette\Forms\Controls\SubmitButton;
use Nette\Utils\ArrayHash;

class MenuEditor extends Control
{

	/** @var EntityManager */
	private $em;

	/** @var NavigationFacade */
	private $navigationFacade;

	/** @persistent */
	public $navigation;

	private $root;

	public function __construct(EntityManager $em, NavigationFacade $navigationFacade)
	{
		$this->em = $em;
		$this->navigationFacade = $navigationFacade;
	}

	public function attached($presenter)
	{
		parent::attached($presenter);
		if ($presenter instanceof UI\Presenter) {
			if ($this->navigation) {
				$this->root = $this->em->getRepository(NavigationItem::class)->findOneBy([
					'root' => 1,
					'navigations.id' => $this->navigation,
				]);
				if (!$this->root) {
					$this->navigation = NULL;
					$this->redirect('this');
				}
			} else { //default fallback
				$this->root = $this->em->getRepository(NavigationItem::class)->findOneBy(['root' => 1]);
			}
		}
	}

	public function render()
	{
		$this->template->adminMenu = $this->navigationFacade->getItemTreeBelow($this->root->getId());
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
		)->setDefaultValue($this->navigation ?: NULL);
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
			$this->redirect('this', [
				'navigation' => $values->navigation,
			]);
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

		$root = $this->em->getRepository(NavigationItem::class)->findOneBy([
			'root' => 1,
			'navigations.id' => $this->navigation,
		]);
		$this->navigationFacade->recalculatePathsForNode($root->getId(), Nestable::resolveJson($json));

		$this->getPresenter()->redrawControl('adminMenu');
	}

}

interface IMenuEditorFactory
{
	/** @return MenuEditor */
	function create();
}
