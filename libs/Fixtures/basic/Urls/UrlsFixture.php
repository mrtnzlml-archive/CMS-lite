<?php

use Doctrine\Common\DataFixtures;
use Doctrine\Common\Persistence\ObjectManager;

class UrlsFixture extends DataFixtures\AbstractFixture implements DataFixtures\OrderedFixtureInterface
{

	public function load(ObjectManager $manager)
	{
		$handle = fopen(__DIR__ . '/mapping.csv', 'r');
		while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
			$url = new \App\Router\Url;
			$url->setFakePath(isset($data[0]) ? $data[0] : NULL);
			$url->setDestination($data[1]);
			$manager->persist($url);
		}
		fclose($handle);
		$manager->flush();
	}

	public function getOrder()
	{
		return 1; //should be first
	}

}
