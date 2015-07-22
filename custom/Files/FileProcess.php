<?php

namespace Files;

use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Security\IUserStorage;
use Users\User;

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

    /** @var IUserStorage */
    private $user;

	public function __construct(EntityManager $em, FileStorage $fileStorage, IUserStorage $user)
	{
		$this->em = $em;
		$this->fileStorage = $fileStorage;
        $this->user = $user;
	}

    public function create(File $file)
    {
        $author = $this->em->getPartialReference(User::class, $this->user->getIdentity()->getId());

        if ($author) {
            $file->setAuthor($author);
        }

        $this->em->persist($file);
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
