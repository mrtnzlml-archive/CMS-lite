<?php

namespace App\AdminModule\Presenters;

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
