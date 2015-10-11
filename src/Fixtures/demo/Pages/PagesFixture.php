<?php

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class PagesFixture extends AbstractFixture implements DependentFixtureInterface
{

	public function load(ObjectManager $manager)
	{
		$faker = Faker\Factory::create('cs_CZ');
		for ($iterator = 0; $iterator <= 50; $iterator++) {
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
			$page->setLocale($this->getReference('locale-cz'));

			$this->addReference('page-' . $iterator, $page);
			$manager->persist($page);
			$manager->flush();

			$page->setUrl(\Url\RouteGenerator::generate(
				Nette\Utils\Strings::webalize($title . ' - ' . $iterator), //fakePath
				'Pages:Front:Page:default', //destination
				$page->getId() //internalId
			));

			$manager->flush();
		}
	}

	public function getDependencies()
	{
		return [
			\UsersFixture::class,
		];
	}

}
