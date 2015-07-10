<?php

namespace Files;

use Nette\Object;
use Symfony\Component\Filesystem\Exception\IOException;
use Symfony\Component\Filesystem\Filesystem as IO;

class FileStorage extends Object
{

	/** @var IO */
	private $io;

	private $dir;

	public function __construct($dir, IO $io)
	{
		$this->dir = $dir;
		$this->io = $io;
	}

	public function delete($uuid)
	{
		$destination = $this->dir . '/' . $uuid;
		if (!$this->io->exists($destination)) {
			return FALSE;
		}

		try {
			$this->io->remove($destination);
			return TRUE;
		} catch (IOException $e) {
			return FALSE;
		}

	}

}
