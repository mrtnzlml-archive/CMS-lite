<?php

namespace App\Extensions;

use App\Components\Favicon\Providers\IFaviconProvider;
use Nette;

class ImageExtension extends Nette\DI\CompilerExtension
{

	private $imagesCacheFolder;
	private $wwwDir;

	public function __construct($wwwDir)
	{
		$this->wwwDir = $wwwDir;
		$this->imagesCacheFolder = $wwwDir . DIRECTORY_SEPARATOR . 'images';
	}

	public function beforeCompile()
	{
		/** @var IImageProvider $extension */
		foreach ($this->compiler->getExtensions(IImageProvider::class) as $extension) {
			//TODO: nemazat pokud to není potřeba (resp. nepřepisovat stejným)
			//TODO: dělá problémy při testování (konkurenční chování!)
			//$this->purge($this->imagesCacheFolder);
			$this->copy($extension->getImagesFolder(), $this->imagesCacheFolder);
			file_put_contents($this->imagesCacheFolder . DIRECTORY_SEPARATOR . '.gitignore', "*\n!.gitignore");
		}

		/** @var IFaviconProvider $extension */
		foreach ($this->compiler->getExtensions(IFaviconProvider::class) as $extension) {
			copy($extension->getFaviconPath(), $this->wwwDir . DIRECTORY_SEPARATOR . 'favicon.ico');
			break; //One is enough...
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
				if (!is_dir($newDir = $to . DIRECTORY_SEPARATOR . $iterator->getSubPathName())) {
					mkdir($newDir);
				}
			} else {
				if (!file_exists($newFile = $to . DIRECTORY_SEPARATOR . $iterator->getSubPathName())) {
					copy($entry, $newFile);
				}
			}
		}
	}

}
