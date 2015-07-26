<?php

use Doctrine\Common\Persistence\ObjectManager;

//FIXME: každé rozšíření by si mělo přidat vlastní options (při instalaci) - \App\Extensions\InstallHelper
class OptionsFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	private $demoOptions = [];

	public function __construct()
	{
		//title => default value
		$this->demoOptions = [
			'site_title' => 'ANTstudio CMS',
			'site_title_separator' => '|',
			'index' => TRUE,
			'page_url_end' => NULL,
			'category_url_end' => NULL,
			'download_protected' => 0,
			'max_filesize' => 5, //Should be in bytes (there si "|bytes" helper in Latte)
			'allowed_extensions' => serialize([
				'pdf', 'odt', 'doc', 'xls', 'xlxs',
			])
		];
	}

	public function load(ObjectManager $manager)
	{
		foreach ($this->demoOptions as $key => $value) {
			$entity = new \Options\Option($key, $value);
			$manager->persist($entity);
		}
		$manager->flush();
	}

}
