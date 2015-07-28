<?php

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class ResourcesFixture extends AbstractFixture implements DependentFixtureInterface
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
			$res = (new \Users\Resource())->setName($resource);
			$manager->persist($res);

			$permission = new \Users\Permission;
			$permission->setRole($this->getReference('admin-role'));
			$permission->setResource($res);
			$permission->setRead()->setWrite()->setCreate();
			$manager->persist($permission);

			$permission = new \Users\Permission;
			$permission->setRole($this->getReference('user-role'));
			$permission->setResource($res);
			$permission->setRead();
			$manager->persist($permission);
		}
		$manager->flush();
	}

	function getDependencies()
	{
		return [RolesFixture::class];
	}

}
