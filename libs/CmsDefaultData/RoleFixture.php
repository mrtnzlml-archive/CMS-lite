<?php

use Doctrine\Common\Persistence\ObjectManager;

class RoleFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	public function load(ObjectManager $manager)
	{
		$user = new \Users\Role();
		$user->setName(\Users\Role::USER);
		$manager->persist($user);

		$admin = new \Users\Role();
		$admin->setName(\Users\Role::ADMIN);
		$admin->addInherit($user);
		$manager->persist($admin);

		$superAdmin = new \Users\Role();
		$superAdmin->setName(\Users\Role::SUPERADMIN);
		$superAdmin->addInherit($user);
		$superAdmin->addInherit($admin);
		$manager->persist($superAdmin);

		$manager->flush();

		$this->addReference('user-role', $user);
		$this->addReference('admin-role', $admin);
		$this->addReference('superAdmin-role', $superAdmin);
	}

}
