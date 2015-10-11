<?php

use Doctrine\Common\DataFixtures;
use Doctrine\Common\Persistence\ObjectManager;

class ProductsFixture extends DataFixtures\AbstractFixture implements DataFixtures\DependentFixtureInterface
{

	public function load(ObjectManager $manager)
	{
		$faker = Faker\Factory::create('cs_CZ');
		for ($iterator = 0; $iterator < 9; $iterator++) {
			$title = $faker->catchPhrase;
			$product = new \Eshop\Product();
			$product->setTitle($title);
			$product->setSlug(\Nette\Utils\Strings::webalize($title));
			$product->setDescription($faker->realText(500));
			if (rand(0, 1)) {
				$product->addDelivery($this->getReference('ppl-delivery'));
			}
			if (rand(0, 1)) {
				$product->addDelivery($this->getReference('tnt-delivery'));
			}
			if (rand(0, 1)) {
				$product->addDelivery($this->getReference('ups-delivery'));
			}
			$this->addReference('book-product-' . $iterator, $product);
			$manager->persist($product);
		}
		$manager->flush();
	}

	public function getDependencies()
	{
		return [
			\DeliveryFixture::class,
		];
	}

}
