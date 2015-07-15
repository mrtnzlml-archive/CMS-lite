<?php

namespace Users\Presenters;

use App\AdminModule\Presenters\BasePresenter;
use Kdyby\Doctrine\EntityManager;
use Users\Query\UsersQuery;
use Users\User;

class UsersPresenter extends BasePresenter
{

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function renderDefault()
	{
		$query = new UsersQuery;
		$users = $this->em->getRepository(User::class)->fetch($query);
		$this->template->users = $users;
	}

}
