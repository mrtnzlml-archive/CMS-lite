<?php

use Doctrine\Common\DataFixtures;
use Doctrine\Common\Persistence\ObjectManager;

class VariantValueFixture //extends DataFixtures\AbstractFixture implements DataFixtures\DependentFixtureInterface
{

	public function load(ObjectManager $manager)
	{
		$varval = new \Eshop\VariantValue();
		$varval->setVariant($this->getReference('var-barva'));
		$varval->setValue('modrá');
		$manager->persist($varval);
		$this->addReference('modra-varval', $varval);
		$varval = clone $varval;
		$varval->setValue('červená');
		$manager->persist($varval);
		$this->addReference('cervena-varval', $varval);
		$varval = clone $varval;
		$varval->setValue('žlutá');
		$manager->persist($varval);

		$varval = new \Eshop\VariantValue();
		$varval->setVariant($this->getReference('var-velikost'));
		$varval->setValue('S');
		$manager->persist($varval);
		$this->addReference('S-varval', $varval);
		$varval = clone $varval;
		$varval->setValue('M');
		$manager->persist($varval);
		$this->addReference('M-varval', $varval);
		$varval = clone $varval;
		$varval->setValue('L');
		$manager->persist($varval);

		$varval = new \Eshop\VariantValue();
		$varval->setVariant($this->getReference('var-material'));
		$varval->setValue('bavlna');
		$manager->persist($varval);
		$varval = clone $varval;
		$varval->setValue('dřevo');
		$manager->persist($varval);
		$varval = clone $varval;
		$varval->setValue('polyester');
		$manager->persist($varval);

		$manager->flush();
	}

	public function getDependencies()
	{
		return [
			\VariantFixture::class,
		];
	}

}
