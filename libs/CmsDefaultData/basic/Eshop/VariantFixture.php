<?php

use Doctrine\Common\Persistence\ObjectManager;

class VariantFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	public function load(ObjectManager $manager)
	{
		$barva = (new \Eshop\Variant)->setName('barva');
		$manager->persist($barva);
		$this->addReference('var-barva', $barva);

		$velikost = (new \Eshop\Variant)->setName('velikost');
		$manager->persist($velikost);
		$this->addReference('var-velikost', $velikost);

		$material = (new \Eshop\Variant)->setName('materiál');
		$manager->persist($material);
		$this->addReference('var-material', $material);

		$manager->flush();
	}

}
