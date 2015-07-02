<?php

use Doctrine\Common\DataFixtures;
use Doctrine\Common\Persistence\ObjectManager;

class ProductVariantFixture //extends DataFixtures\AbstractFixture implements DataFixtures\DependentFixtureInterface
{

	public function load(ObjectManager $manager)
	{
		$prodVar = new \Eshop\ProductVariant();
		$prodVar->setProduct($this->getReference('book-product-1'));
		$prodVar->setVariantName('modrá-M');
		$prodVar->setSku('blue1');
		$prodVar->addVariantValue($this->getReference('modra-varval'));
		$prodVar->addVariantValue($this->getReference('M-varval'));
		$manager->persist($prodVar);

		$prodVar = new \Eshop\ProductVariant();
		$prodVar->setProduct($this->getReference('book-product-2'));
		$prodVar->setVariantName('červená-S');
		$prodVar->setSku('red1');
		$prodVar->addVariantValue($this->getReference('cervena-varval'));
		$prodVar->addVariantValue($this->getReference('S-varval'));
		$manager->persist($prodVar);

		$manager->flush();
	}

	public function getDependencies()
	{
		return [
			\ProductsFixture::class,
			\VariantValueFixture::class,
		];
	}

}
