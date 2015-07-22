<?php

namespace Files;

use Kdyby\Doctrine\EntityManager;
use Nette;

/**
 * @method onUpdate(FileProcess $control, File $file)
 */
class FileProcess extends Nette\Object
{

	/** @var \Closure[] */
	public $onUpdate = [];

	/** @var EntityManager */
	private $em;

	/** @var FileStorage */
	private $fileStorage;

	public function __construct(EntityManager $em, FileStorage $fileStorage)
	{
		$this->em = $em;
		$this->fileStorage = $fileStorage;
	}

	public function update(File $file)
	{
		$this->em->persist($file);
		$this->onUpdate($this, $file);
	}

	public function delete(File $file)
	{
		if ($this->fileStorage->delete($file->getUuid())) {
			$this->em->remove($file);
			$this->em->flush($file);
			return TRUE;
		}

        return FALSE;
	}

}
