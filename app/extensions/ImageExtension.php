<?php

namespace App\Extensions;

use Nette;

class ImageExtension extends Nette\DI\CompilerExtension
{

	private $imagesCacheFolder;

	public function __construct()
	{
		$this->imagesCacheFolder = __DIR__ . '/../../www/images';
	}

	public function beforeCompile()
	{
		$cb = $this->getContainerBuilder();

		/** @var IImageProvider $extension */
		foreach ($this->compiler->getExtensions(IImageProvider::class) as $extension) {
			$this->purge($this->imagesCacheFolder);
			$this->copy($extension->getImagesFolder(), $this->imagesCacheFolder);
			file_put_contents($this->imagesCacheFolder . DIRECTORY_SEPARATOR . '.gitignore', "*\n!.gitignore");
		}
	}

	private function purge($dir)
	{
		if (!is_dir($dir)) {
			mkdir($dir);
		}
		foreach ($iterator = new \RecursiveIteratorIterator(
			new \RecursiveDirectoryIterator(
				$dir, \RecursiveDirectoryIterator::SKIP_DOTS
			), \RecursiveIteratorIterator::CHILD_FIRST
		) as $entry) {
			if ($entry->isDir()) {
				rmdir($entry);
			} else {
				unlink($entry);
			}
		}
	}

	private function copy($from, $to)
	{
		foreach ($iterator = new \RecursiveIteratorIterator(
			new \RecursiveDirectoryIterator(
				$from, \RecursiveDirectoryIterator::SKIP_DOTS
			), \RecursiveIteratorIterator::SELF_FIRST
		) as $entry) {
			if ($entry->isDir()) {
				mkdir($to . DIRECTORY_SEPARATOR . $iterator->getSubPathName());
			} else {
				copy($entry, $to . DIRECTORY_SEPARATOR . $iterator->getSubPathName());
			}
		}
	}

}
