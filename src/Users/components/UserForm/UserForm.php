<?php

namespace Users\Components\UsersGrid;

use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Users\Role;
use Users\User;

/**
 * @method onCreate(UserForm $userForm, User $user)
 * @method onUpdate(UserForm $userForm, User $user)
 */
class UserForm extends AControl
{

	/** @var \Closure[] */
	public $onCreate = [];

	/** @var \Closure[] */
	public $onUpdate = [];

	/** @var User */
	private $editableUser;

	/** @var EntityManager */
	private $em;

	public function __construct($editableUser, EntityManager $entityManager)
	{
		$this->editableUser = $editableUser;
		$this->em = $entityManager;
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters !== NULL) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/UserForm.latte');
	}

	protected function createComponentUserForm()
	{
		$form = new UI\Form;
		$form->addProtection();
		$form->addText('email', 'Email uživatele:')
			->setRequired('Vyplňtě prosím email uživatele.')
			->addRule(UI\Form::EMAIL, 'Zadejte prosím email ve správném formátu.');
		$form->addPassword('password', 'Heslo uživatele:')
			->setRequired('Zadejte prosím heslo uživatele.');
		$form->addSelect('role', 'Role uživatele:',
			$this->em->getRepository(Role::class)->findPairs('name')
		);
		$this->setDefaults($form);
		if ($this->editableUser === NULL) { //NEW
			$form->addSubmit('create', 'Založit uživatele');
		} else {
			$form->addSubmit('update', 'Upravit uživatele');
		}
		$form->onSuccess[] = $this->userFormSucceeded;
		return $form;
	}

	public function userFormSucceeded(UI\Form $form, Nette\Utils\ArrayHash $values)
	{
		if ($this->editableUser === NULL) { //NEW
			$user = new User($values->email);
		} else {
			$user = $this->editableUser;
			$user->setEmail($values->email);
		}
		$user->setPassword(Nette\Security\Passwords::hash($values->password));

		$user->clearRoles();
		$user->addRole($this->em->getPartialReference(Role::class, $values->role));

		$this->em->persist($user);
		if ($this->editableUser === NULL) { //NEW
			$this->onCreate($this, $user);
		} else {
			$this->onUpdate($this, $user);
		}
	}

	private function setDefaults(UI\Form $form)
	{
		if ($this->editableUser !== NULL) { //EDITING
			/** @var User $e */
			$e = $this->editableUser;
			$form->setDefaults([
				'email' => $e->getEmail(),
				'role' => $e->getRoles() ? $e->getRoles()[0]->getId() : '', //FUJ
			]);
		}
	}

}

interface IUserFormFactory
{
	/**
	 * @param NULL|User $editableUser
	 *
	 * @return UserForm
	 */
	function create($editableUser);
}
