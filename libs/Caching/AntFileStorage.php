<?php

namespace Caching;

use Nette\Caching\Storages;

class AntFileStorage extends Storages\FileStorage
{

	private $dir;

	public function __construct($dir, Storages\IJournal $journal = NULL)
	{
		parent::__construct($dir, $journal);
		$this->dir = $dir;
	}

	protected function getCacheFile($key)
	{
		$file = urlencode($key);
		$useDirs = Storages\FileStorage::$useDirectories;
		if ($useDirs && $a = strrpos($file, '%00')) { // %00 = urlencode(Nette\Caching\Cache::NAMESPACE_SEPARATOR)
			$file = substr_replace($file, '/_', $a, 3);
			$namespace = '/_' . substr($key, 0, $a);
		}
		$subDir = '/_' . substr(str_replace('_', '', basename($file)), 0, 2);
		if (isset($namespace)) {
			if ($useDirs && !is_dir($dir = $this->dir . $namespace)) {
				@mkdir($dir); // @ - directory may already exist
			}
		} else {
			$namespace = NULL;
		}
		if ($useDirs && !is_dir($dir = $this->dir . $namespace . $subDir)) {
			@mkdir($dir); // @ - directory may already exist
		}
		return $this->dir . $namespace . $subDir . '/' . basename($file);
	}

}
