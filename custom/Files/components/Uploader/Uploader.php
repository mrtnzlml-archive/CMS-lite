<?php

namespace Files\Components;

use Files\File;
use Files\FileProcess;
use Files\FineUploader;
use Files\FineUploaderException;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Options\OptionFacade;

/**
 * @method onSuccess(Uploader $control, File $file, array $result)
 * @method onFailed(Uploader $control, array $result)
 */
class Uploader extends UI\Control
{

	/** @var EntityManager */
	private $em;

	/** @var Uploader */
	private $uploader;

	/** @var FileProcess */
	private $fileProcess;

	/** @var OptionFacade */
	private $optionFacade;

	public $onSuccess = [];
	public $onFailed = [];

	private $pictureUploader = FALSE;

	public function __construct($pictureUploader, EntityManager $em, FineUploader $uploader, FileProcess $fileProcess, OptionFacade $optionFacade)
	{
		$this->em = $em;
		$this->uploader = $uploader;
		$this->fileProcess = $fileProcess;
		$this->optionFacade = $optionFacade;
		$this->pictureUploader = $pictureUploader;
	}

	public function handleUpload()
	{
		try {
			$result = $this->fileProcess->upload($this->pictureUploader);
		} catch (FineUploaderException $exc) {
			$this->onFailed($this, $exc->getResult());
			exit;
		}
		$this->onSuccess($this, $result[0]/*file*/, $result[1]);
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameteres = Nette\Utils\ArrayHash::from($parameters);
		}
		if ($this->pictureUploader) {
			$template = __DIR__ . '/templates/image-uploader.latte';
		} else {
			$template = __DIR__ . '/templates/file-uploader.latte';
		}
		$this->template->render($template);
	}

}

interface IUploaderFactory
{
	/** @return Uploader */
	public function create($pictureUploader = FALSE);
}
