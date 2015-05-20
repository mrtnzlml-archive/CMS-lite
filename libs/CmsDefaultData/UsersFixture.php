<?php

use Doctrine\Common\DataFixtures\FixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use Nette\Security\Passwords;

class UsersFixture implements FixtureInterface
{

	public function load(ObjectManager $manager)
	{
		$admin = new \Users\User('admin@antstudio.cz');
		$admin->setPassword(Passwords::hash('admin'));
		$manager->persist($admin);

		$demo = new \Users\User('demo@antstudio.cz');
		$demo->setPassword(Passwords::hash('demo'));
		$manager->persist($demo);

		$manager->flush();
	}

}
