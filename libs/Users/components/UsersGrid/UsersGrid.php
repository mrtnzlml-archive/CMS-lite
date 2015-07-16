<?php

namespace Users\Components\UsersGrid;

use App\Components\AControl;
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

}

interface IUsersGridFactory
{
	/** @return UsersGrid */
	function create();
}
