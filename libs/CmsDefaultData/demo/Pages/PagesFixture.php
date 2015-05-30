<?php

use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class PagesFixture extends \Doctrine\Common\DataFixtures\AbstractFixture implements DependentFixtureInterface
{

	public function load(ObjectManager $manager)
	{
		$title = 'Toto je první stránka';
		$body = <<<BODY
Můžete ji **upravovat** dle //libosti//...
BODY;

		$page = new \Pages\Page();
		$page->setTitle($title);
		$page->setSlug(\Nette\Utils\Strings::webalize($title));
		$page->setBody($body);
		$page->addAuthor($this->getReference('admin-user'));
		$page->addAuthor($this->getReference('demo-user'));
		$manager->persist($page);

		$manager->flush();
	}

	public function getDependencies()
	{
		return [
			\UsersFixture::class,
		];
	}

}
