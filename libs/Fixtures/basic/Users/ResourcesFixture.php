<?php

use Doctrine\Common\Persistence\ObjectManager;

class ResourcesFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	public function load(ObjectManager $manager)
	{
		$manager->persist((new \Users\Resource())->setName('Admin:Dashboard'));
		$manager->persist((new \Users\Resource())->setName('Admin:Options'));
		$manager->persist((new \Users\Resource())->setName('Admin:Page'));
		$manager->persist((new \Users\Resource())->setName('Admin:Files'));
		$manager->persist((new \Users\Resource())->setName('Admin:Users'));
		$manager->flush();
	}

}
