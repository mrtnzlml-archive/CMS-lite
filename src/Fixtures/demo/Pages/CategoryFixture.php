<?php

use Doctrine\Common\Persistence\ObjectManager;

class CategoryFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	private $lastId = NULL;

	public function load(ObjectManager $manager)
	{
		$faker = Faker\Factory::create('cs_CZ');
		$process = new \Pages\CategoryProcess($manager);

		for ($iterator = 0; $iterator <= 10; $iterator++) {
			$category = $process->createCategory(\Nette\Utils\Strings::firstUpper($faker->word), $this->lastId);
			$this->lastId = $category->getId();
			$this->addReference('category-' . $iterator, $category);
			$manager->persist($category);
			$manager->flush();

			$category->setUrl(\Url\RouteGenerator::generate(
				Nette\Utils\Strings::webalize($category->getName() . ' - ' . $iterator), //fakePath
				'Pages:Front:Category:default', //destination
				$category->getId() //internalId
			));

			$manager->flush();
		}
	}

}
