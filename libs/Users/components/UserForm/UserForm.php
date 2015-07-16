<?php

namespace Users\Components\UsersGrid;

use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Users\Role;
use Users\User;

/**
 * @method onSave(UserForm $userForm, User $user)
 */
class UserForm extends AControl
{

	/** @var \Closure[] */
	public $onSave = [];

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $entityManager)
	{
		$this->em = $entityManager;
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters !== NULL) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/UserForm.latte');
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
		$form->addSubmit('create', 'Založit uživatele');
		$form->onSuccess[] = $this->userFormSucceeded;
		return $form;
	}

	public function userFormSucceeded(UI\Form $form, Nette\Utils\ArrayHash $values)
	{
		$newUser = new User($values->email);
		$newUser->setPassword($values->password);
		$newUser->addRole($this->em->getPartialReference(Role::class, $values->role));
		$this->em->persist($newUser);
		$this->onSave($this, $newUser);
	}

}

interface IUserFormFactory
{
	/** @return UserForm */
	function create();
}
