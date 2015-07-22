<?php

namespace Files\Components;

use App\Components\AControl;
use Files\File;
use Files\FineUploader as Uploader;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;

class FineUploader extends AControl
{

	/** @var EntityManager */
	private $em;
	/** @var Uploader */
	private $uploader;
	/** @var string */
	private $dir;

	public $onSuccess = [];
	public $onFailed = [];

	public function __construct($dir, EntityManager $em, Uploader $uploader)
	{
		$this->dir = $dir;
		$this->em = $em;
		$this->uploader = $uploader;
	}

	public function handleUpload()
	{
		$result = $this->uploader->handleUpload($this->dir);
		$this->uploadProcess($result);
	}

	private function uploadProcess($result)
	{
		if (!isset($result['success']) || $result['success'] !== TRUE) {
			$this->onFailed($this, $result);
		}

		$file = new File();
		$file->setName($this->uploader->getName(FALSE));
		$file->setSanitizedName($this->uploader->getName());
		$file->setUuid($result['uuid']);
		$file->setSize($result['size']);

		$this->em->persist($file);
		$this->em->flush($file);

		$this->onSuccess($this, $file, $result);
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameteres = Nette\Utils\ArrayHash::from($parameters);
		}

		$this->template->setFile(dirname(__FILE__) . '/templates/uploader.latte');
		$this->template->render();
	}
}

interface IFineUploaderFactory
{
	/**
	 * @return FineUploader
	 */
	public function create(Uploader $uploader);
}
