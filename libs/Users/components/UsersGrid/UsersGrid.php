<?php

namespace Users\Components\UsersGrid;

use App\Components\AControl;
use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Users\Query\UsersQuery;
use Users\User;

class UsersGrid extends AControl
{

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters !== NULL) {
			$this->template->parameters = Nette\Utils\ArrayHash::from($parameters);
		}
		$users = $this->em->getRepository(User::class)->fetch(new UsersQuery);
		$this->template->users = $users;
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/UsersGrid.latte');
	}

	/**
	 * @secured
	 */
	public function handleDeleteUser($id)
	{
		$partialUser = $this->em->getPartialReference(User::class, $id);
		$this->em->remove($partialUser);
		$this->em->flush($partialUser);
		$this->presenter->flashMessage('Uživatel byl úspěšně smazán.', Flashes::FLASH_SUCCESS);
		$this->redirect('this');
	}

}

interface IUsersGridFactory
{
	/** @return UsersGrid */
	function create();
}
