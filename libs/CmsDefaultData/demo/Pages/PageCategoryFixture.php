<?php

use Doctrine\Common\Persistence\ObjectManager;

class PageCategoryFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	public function load(ObjectManager $manager)
	{
		$faker = Faker\Factory::create('cs_CZ');
		for ($iterator = 0; $iterator < 5; $iterator++) {
			$category = new \Pages\PageCategory();
			$category->setName(\Nette\Utils\Strings::firstUpper($faker->word));
			$manager->persist($category);
			$this->addReference('page-category-' . $iterator, $category);
		}
		$manager->flush();
	}

}
