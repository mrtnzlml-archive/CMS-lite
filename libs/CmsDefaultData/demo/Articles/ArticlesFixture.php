<?php

use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class ArticlesFixture extends \Doctrine\Common\DataFixtures\AbstractFixture implements DependentFixtureInterface
{

	public function load(ObjectManager $manager)
	{
		$faker = Faker\Factory::create('cs_CZ');
		for ($iterator = 0; $iterator < 5; $iterator++) {
			$title = $faker->catchPhrase;
			$body = $faker->realText(500);
			$article = new \Articles\Article();
			$article->setTitle($title);
			$article->setSlug(\Nette\Utils\Strings::webalize($title));
			$article->setBody($body);
			$article->addAuthor($this->getReference('admin-user'));
			if (rand(0, 1)) {
				$article->addAuthor($this->getReference('demo-user'));
			}
			$manager->persist($article);
		}
		$manager->flush();
	}

	public function getDependencies()
	{
		return [
			\UsersFixture::class,
		];
	}

}
