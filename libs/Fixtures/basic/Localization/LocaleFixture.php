<?php

use Doctrine\Common\Persistence\ObjectManager;

class LocaleFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	private $locales = [
		'cz' => 'Čeština',
		'en' => 'English',
	];

	public function load(ObjectManager $manager)
	{
		$iterator = 0;
		foreach ($this->locales as $code => $name) {
			$entity = new \Localization\Locale;
			$entity->setCode($code);
			$entity->setName($name);
			if ($iterator++ === 0) {
				$entity->setDefault();
			}
			$manager->persist($entity);
			$this->addReference('locale-' . $code, $entity);
		}
		$manager->flush();
	}

}
