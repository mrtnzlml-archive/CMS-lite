<?php

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class ResourcesFixture extends AbstractFixture implements DependentFixtureInterface
{

	private $resources = [
		'Dashboard' => 'Dashboard:Dashboard',
		'Soubory' => 'Files:AdminFile',
		'Navigace' => 'Navigation:Navigation',
		'Nastavení' => 'Options:Options',
		'Stránky' => 'Pages:Admin:Page',
		'Kategorie' => 'Pages:Admin:Category',
		'Vyhledávání' => 'Search:Search',
		'Uživatelé' => 'Users:Users',
	];

	public function load(ObjectManager $manager)
	{
		foreach ($this->resources as $name => $resource) {
			/** @var \Users\Resource $res */
			$res = (new \Users\Resource())->setResource($resource);
			$res->setName($name);
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
