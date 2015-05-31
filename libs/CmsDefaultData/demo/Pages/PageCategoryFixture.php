<?php

use Doctrine\Common\Persistence\ObjectManager;

class PageCategoryFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	public function load(ObjectManager $manager)
	{
		$category = new \Pages\PageCategory();
		$category->setName('Kategorie 1');
		$manager->persist($category);
		$this->addReference('page-category-1', $category);

		$category = clone $category;
		$category->setName('Kategorie 2');
		$manager->persist($category);
		$this->addReference('page-category-2', $category);

		$category = clone $category;
		$category->setName('Kategorie 3');
		$manager->persist($category);
		$this->addReference('page-category-3', $category);

		$manager->flush();
	}

}
