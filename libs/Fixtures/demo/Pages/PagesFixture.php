<?php

use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class PagesFixture extends \Doctrine\Common\DataFixtures\AbstractFixture implements DependentFixtureInterface
{

	public function load(ObjectManager $manager)
	{
		$faker = Faker\Factory::create('cs_CZ');
		for ($iterator = 0; $iterator < 6; $iterator++) {
			$title = \Nette\Utils\Strings::firstUpper($faker->word);
			$body = $faker->realText(500);
			$page = new \Pages\Page;
			$page->setTitle($title);
			$page->setBody($body);
			if (rand(0, 1)) {
				$page->addAuthor($this->getReference('admin-user'));
			}
			if (rand(0, 1)) {
				$page->addAuthor($this->getReference('demo-user'));
			}
			if (rand(0, 1)) {
				$page->addCategory($this->getReference('page-category-1'));
			}
			if (rand(0, 1)) {
				$page->addCategory($this->getReference('page-category-2'));
			}
			if (rand(0, 1)) {
				$page->addCategory($this->getReference('page-category-3'));
			}
			$page->setLocale($this->getReference('locale-cz'));
			$manager->persist($page);
			$manager->flush($page);
			$page->setUrl(\Url\RouteGenerator::generate(Nette\Utils\Strings::webalize($title), 'Pages:Page:default', $page->getId()));
			$manager->flush($page);
		}
	}

	public function getDependencies()
	{
		return [
			\UsersFixture::class,
			\PageCategoryFixture::class,
		];
	}

}
