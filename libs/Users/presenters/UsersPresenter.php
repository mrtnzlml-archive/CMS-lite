<?php

namespace Users\Presenters;

use App\AdminModule\Presenters\BasePresenter;
use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Users\Components\UsersGrid\IUserFormFactory;
use Users\Components\UsersGrid\IUsersGridFactory;
use Users\Components\UsersGrid\UserForm;
use Users\User;

class UsersPresenter extends BasePresenter
{

	/** @var EntityManager */
	private $em;

	/** @var User|NULL */
	private $editableUser = NULL;

	public function __construct(EntityManager $entityManager)
	{
		$this->em = $entityManager;
	}

	public function actionEdit($id = NULL)
	{
		if ($id === NULL) {
			$this->redirect('new');
		}
		if ($editableUser = $this->em->getRepository(User::class)->find($id)) {
			$this->editableUser = $editableUser;
		} else {
			$this->redirect('new');
		}
	}

	protected function createComponentUserForm(IUserFormFactory $factory)
	{
		$control = $factory->create($this->editableUser);
		$control->onCreate[] = function (UserForm $_, User $user) {
			$this->em->flush($user);
			$this->flashMessage('Uživatel byl úspěšně založen.', Flashes::FLASH_SUCCESS);
			$this->redirect('default');
		};
		$control->onUpdate[] = function (UserForm $_, User $user) {
			$this->em->flush($user);
			$this->flashMessage('Uživatel byl úspěšně upraven.', Flashes::FLASH_SUCCESS);
			$this->redirect('default');
		};
		return $control;
	}

	protected function createComponentUsersGrid(IUsersGridFactory $factory)
	{
		return $factory->create();
	}

}
