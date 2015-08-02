<?php

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class NotesFixture extends AbstractFixture implements DependentFixtureInterface
{

	public function load(ObjectManager $manager)
	{
		$faker = Faker\Factory::create('cs_CZ');

		for ($iterator = 0; $iterator < 3; $iterator++) {
			$note = new \Notes\Note;
			$note->setTitle($faker->catchPhrase);
			$note->setBody($faker->realText(250));
			$note->setAuthor($this->getReference('admin-user'));
			$manager->persist($note);
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
