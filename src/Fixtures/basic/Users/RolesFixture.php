<?php

use Doctrine\Common\Persistence\ObjectManager;

class RolesFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	public function load(ObjectManager $manager)
	{
		$guest = new \Users\Role();
		$guest->setName(\Users\Role::GUEST);
		$manager->persist($guest);

		$user = new \Users\Role();
		$user->setName(\Users\Role::USER);
		$user->setParent($guest);
		$manager->persist($user);

		$admin = new \Users\Role();
		$admin->setName(\Users\Role::ADMIN);
		$admin->setParent($user);
		$manager->persist($admin);

		$superAdmin = new \Users\Role();
		$superAdmin->setName(\Users\Role::SUPERADMIN);
		$superAdmin->setParent($admin);
		$manager->persist($superAdmin);

		$manager->flush();

		$this->addReference('user-role', $user);
		$this->addReference('admin-role', $admin);
		$this->addReference('superAdmin-role', $superAdmin);
	}

}
