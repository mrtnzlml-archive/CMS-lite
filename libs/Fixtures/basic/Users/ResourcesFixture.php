<?php

use Doctrine\Common\Persistence\ObjectManager;

class ResourcesFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	private $resources = [
		'Dashboard:Dashboard',
		'Files:AdminFile',
		'Navigation:Navigation',
		'Options:Options',
		'Pages:AdminPage',
		'Search:Search',
		'Users:Users',
	];

	public function load(ObjectManager $manager)
	{
		foreach ($this->resources as $resource) {
			$manager->persist((new \Users\Resource())->setName($resource));
		}
		$manager->flush();
	}

}
