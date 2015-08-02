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

			//TODO: přesunout do vlastního rozšíření
			'upload_max_filesize' => 5242880, //5*1024*1024 = 5MB
			'allowed_file_extensions' => [
				'pdf', 'odt', 'doc', 'xls', 'xlxs',
			],
			'allowed_picture_extensions' => [
				'jpg', 'png', 'gif',
			],
			'image_resize_matrix' => [
				'small' => ['100', '?'],
				'medium' => ['200', '?'],
				'big' => ['400', '?'],
			],
			'watermark_opacity' => 50,
			'image_quality' => 90,
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
