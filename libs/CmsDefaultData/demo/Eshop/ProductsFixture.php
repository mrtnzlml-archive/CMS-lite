<?php

use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class ProductsFixture extends \Doctrine\Common\DataFixtures\AbstractFixture implements DependentFixtureInterface
{

	public function load(ObjectManager $manager)
	{
		$title = 'Rothschildova flaška';
		$description = <<<BODY
Rothschildova flaška je příběh takřka detektivní, napsaný autorovým nezaměnitelným a vyzrálým stylem.
Příběh ze současnosti a o současnosti zavede čtenáře do Anglie, do jedné velké londýnské herny.
Najde pozoruhodný proutkař ztracenou dívku a poradí si s výherními automaty?
A co všechno je možné s pomocí obyčejné pružiny na posilování svalů?
BODY;
		$prod_1 = new \Eshop\Product();
		$prod_1->setTitle($title);
		$prod_1->setSlug(\Nette\Utils\Strings::webalize($title));
		$prod_1->setDescription($description);
		$prod_1->addDelivery($this->getReference('ppl-delivery'));
		$prod_1->addDelivery($this->getReference('tnt-delivery'));
		$prod_1->addDelivery($this->getReference('ups-delivery'));
		$manager->persist($prod_1);
		$this->addReference('book-product', $prod_1);

		$title = 'To prší moře';
		$description = <<<BODY
Napínavé psychologické drama jedné zdánlivě obyčejné rodiny, ve kterém autorka umožní čtenáři nahlédnout nejen do křehké duše dvacetileté Hanky, ale také do osudů dalších, vzájemně propojených postav.
S lehkostí sobě vlastní vypráví nelehký příběh o pocitech.
O bolesti, o nedorozumění, o strachu, o bezpodmínečné lásce, o otázkách a odpovědích, které se všichni snažíme v životě najít.
O naději.
BODY;
		$prod_2 = new \Eshop\Product();
		$prod_2->setTitle($title);
		$prod_2->setSlug(\Nette\Utils\Strings::webalize($title));
		$prod_2->setDescription($description);
		$prod_2->addDelivery($this->getReference('dpd-delivery'));
		$prod_2->addDelivery($this->getReference('dhl-delivery'));
		$prod_2->addDelivery($this->getReference('dsv-delivery'));
		$prod_2->addDelivery($this->getReference('ceska_posta-delivery'));
		$manager->persist($prod_2);

		$manager->flush();
	}

	public function getDependencies()
	{
		return [
			\DeliveryFixture::class,
		];
	}

}
