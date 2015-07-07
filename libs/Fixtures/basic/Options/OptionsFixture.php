<?php

use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class OptionsFixture extends \Doctrine\Common\DataFixtures\AbstractFixture implements DependentFixtureInterface
{

	private $demoOptions = [
		//[category, title, value]
		'site_title' => ['general', 'Název webu', 'ANTstudio CMS'],
		'site_title_separator' => ['general', 'Oddělovač titulku', '|'],

		'index' => ['seo', 'Indexovat web', TRUE],
		'page_url_end' => ['seo', 'Koncovka URL stránek', [
			NULL, '/', '.htm', '.html',
		]],
		'category_url_end' => ['seo', 'Koncovka URL kategorií', [
			NULL, '/', '.htm', '.html',
		]],
	];

	public function load(ObjectManager $manager)
	{
		foreach ($this->demoOptions as $key => $value) {
			$entity = new \Options\Option($key, $value[2]);
			$entity->setDescription($value[1]);
			$entity->setCategory($this->getReference('option-' . $value[0]));
			$manager->persist($entity);
		}
		$manager->flush();
	}

	/**
	 * This method must return an array of fixtures classes
	 * on which the implementing class depends on
	 *
	 * @return array
	 */
	function getDependencies()
	{
		return [
			OptionCategoriesFixture::class,
		];
	}

}
