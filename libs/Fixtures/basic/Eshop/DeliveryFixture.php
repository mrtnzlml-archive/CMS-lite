<?php

use Doctrine\Common\Persistence\ObjectManager;

class DeliveryFixture //extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	private $deliveries = [
		'CESKA_POSTA' => 'Česká pošta',
		'CESKA_POSTA_NA_POSTU' => 'Česká pošta - Balík Na poštu',
		'CSAD_LOGISTIK_OSTRAVA' => 'ČSAD Logistik Ostrava',
		'DPD' => 'DPD',
		'DHL' => 'DHL',
		'DSV' => 'DSV',
		'EMS' => 'EMS',
		'FOFR' => 'FOFR',
		'GEBRUDER_WEISS' => 'Gebrüder Weiss',
		'GEIS' => 'Geis',
		'GENERAL_PARCEL' => 'General Parcel',
		'GLS' => 'GLS',
		'HDS' => 'HDS',
		'HEUREKAPOINT' => 'HeurekaPoint',
		'INTIME' => 'InTime',
		'PPL' => 'PPL',
		'RADIALKA' => 'Radiálka',
		'SEEGMULLER' => 'Seegmuller',
		'TNT' => 'TNT',
		'TOPTRANS' => 'TOPTRANS',
		'UPS' => 'UPS',
		'VLASTNI_PREPRAVA' => 'Vlastní přeprava',
	];

	public function load(ObjectManager $manager)
	{
		foreach ($this->deliveries as $deliveryId => $name) {
			$delivery = new \Eshop\Delivery();
			$delivery->setDeliveryId($deliveryId);
			$delivery->setName($name);
			$delivery->setDeliveryPrice(rand(950, 2500) / 10);
			$delivery->setHeureka(TRUE);
			$manager->persist($delivery);
			$this->addReference(mb_strtolower($deliveryId) . '-delivery', $delivery);
		}
		$manager->flush();
	}

}
