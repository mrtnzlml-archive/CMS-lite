<?php

use Doctrine\Common\Persistence\ObjectManager;

class ProductsFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
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
		$manager->persist($prod_1);

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
		$manager->persist($prod_2);

		$manager->flush();
	}

}
