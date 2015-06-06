<?php

use Doctrine\Common\Persistence\ObjectManager;

class OptionsFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	private $demoOptions = [
		'site_title' => 'Site Title',
		'https' => TRUE,
	];

	public function load(ObjectManager $manager)
	{
		foreach ($this->demoOptions as $key => $value) {
			$manager->persist(new \Options\Option($key, $value));
		}
		$manager->flush();
	}

}
