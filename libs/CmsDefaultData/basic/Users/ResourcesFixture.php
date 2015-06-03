<?php

use Doctrine\Common\Persistence\ObjectManager;

class ResourcesFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	public function load(ObjectManager $manager)
	{
		$manager->persist((new \Users\Resource())->setName('Admin:Dashboard'));
		$manager->persist((new \Users\Resource())->setName('Admin:Page'));

		$manager->flush();
	}

}
