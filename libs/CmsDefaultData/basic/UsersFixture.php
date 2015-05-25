<?php

use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use Nette\Security\Passwords;

class UsersFixture extends \Doctrine\Common\DataFixtures\AbstractFixture implements DependentFixtureInterface
{

	public function load(ObjectManager $manager)
	{
		$admin = new \Users\User('admin@antstudio.cz');
		$admin->setPassword(Passwords::hash('admin'));
		$admin->addRole($this->getReference('superAdmin-role'));
		$manager->persist($admin);

		$demo = new \Users\User('demo@antstudio.cz');
		$demo->setPassword(Passwords::hash('demo'));
		$demo->addRole($this->getReference('user-role'));
		$manager->persist($demo);

		$manager->flush();

		$this->addReference('admin-user', $admin);
		$this->addReference('demo-user', $demo);
	}

	public function getDependencies()
	{
		return [
			\RolesFixture::class,
		];
	}

}
