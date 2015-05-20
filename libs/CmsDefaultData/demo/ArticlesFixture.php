<?php

use Doctrine\Common\Persistence\ObjectManager;

class ArticlesFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	public function load(ObjectManager $manager)
	{
		$title = 'Toto je první příspěvek';
		$body = <<<BODY
Můžete jej upravovat podle libosti.
BODY;

		$article = new \Articles\Article();
		$article->setTitle($title);
		$article->setSlug(\Nette\Utils\Strings::webalize($title));
		$article->setBody($body);
		$article->addAuthor($this->getReference('admin-user'));
		$manager->persist($article);

		$manager->flush();
	}

}
