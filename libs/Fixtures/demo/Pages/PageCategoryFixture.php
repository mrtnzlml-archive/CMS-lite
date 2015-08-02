<?php

use Doctrine\Common\Persistence\ObjectManager;

class PageCategoryFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	private $lastId = NULL;

	public function load(ObjectManager $manager)
	{
		$faker = Faker\Factory::create('cs_CZ');
		$process = new \Pages\PageCategoryProcess($manager);

		for ($iterator = 0; $iterator < 5; $iterator++) {
			$category = $process->createCategory(\Nette\Utils\Strings::firstUpper($faker->word), $this->lastId);
			$this->lastId = $category->getId();
			$this->addReference('page-category-' . $iterator, $category);
		}
	}

}
