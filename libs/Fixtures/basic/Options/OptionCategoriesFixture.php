<?php

use Doctrine\Common\Persistence\ObjectManager;

class OptionCategoriesFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	private $categories = [
		'general' => 'Obecné',
		'seo' => 'SEO',
        'files' => 'Soubory'
    ];

	public function load(ObjectManager $manager)
	{
		foreach ($this->categories as $key => $fullName) {
			$entity = new \Options\OptionCategory($key, $fullName);
			$manager->persist($entity);
			$this->addReference('option-' . $key, $entity);
		}
		$manager->flush();
	}

}
