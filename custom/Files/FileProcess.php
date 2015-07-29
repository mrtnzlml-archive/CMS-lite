<?php

namespace Files;

use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Security\IUserStorage;
use Nette\Utils\Image;
use Options\OptionFacade;
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

	/** @var IUserStorage */
	private $user;

	/** @var FineUploader */
	private $fineUploader;

	/** @var OptionFacade */
	private $optionFacade;

	private $directory;

	public function __construct($directory, EntityManager $em, IUserStorage $user, FineUploader $fineUploader, OptionFacade $optionFacade)
	{
		$this->em = $em;
		$this->user = $user;
		$this->directory = $directory;
		$this->fineUploader = $fineUploader;
		$this->optionFacade = $optionFacade;
	}

	public function upload($pictures = FALSE)
	{
		$allowedExtensions = $this->optionFacade->getOption($pictures ? 'allowed_picture_extensions' : 'allowed_file_extensions');
		$this->fineUploader->setAllowedExtensions($allowedExtensions);

		if ($pictures) {
			$result = $this->fineUploader->handleUpload($this->directory . DIRECTORY_SEPARATOR . 'pictures');
		} else {
			$result = $this->fineUploader->handleUpload($this->directory . DIRECTORY_SEPARATOR . 'files');
		}

		if (isset($result['error'])) {
			throw new FineUploaderException($result);
		}

		$name = $this->fineUploader->getName();

		if ($pictures) {
			$this->resizeImage($this->directory . DIRECTORY_SEPARATOR . 'pictures' . DIRECTORY_SEPARATOR . $result['uuid'], $name);
		}

		$file = new File;
		$file->setName($name);
		$file->setFakeName($name);
		$file->setUuid($result['uuid']);
		$file->setSize($result['size']);
		$file->setPicture($pictures);
		$file->setExtension($result['extension']);

		$author = $this->em->getPartialReference(User::class, $this->user->getIdentity()->getId());
		$file->setAuthor($author);

		$this->em->persist($file);
		$this->em->flush($file);

		return [$file, $result];
	}

	public function resizeImage($path, $imageName)
	{
		$matrix = $this->optionFacade->getOption('image_resize_matrix');
		foreach ($matrix as $type => $dimensions) {
			list($width, $height) = $dimensions;
			$width = $width === '?' ? NULL : (int)$width;
			$height = $height === '?' ? NULL : (int)$height;

			$image = Image::fromFile($path . DIRECTORY_SEPARATOR . $imageName);
			$image->resize($width, $height, Image::SHRINK_ONLY);
			$image->sharpen();

			//TODO: customizable watermark
			$watermark = Image::fromBlank($image->getWidth(), $image->getHeight(), Image::rgb(0, 0, 0, 127));
			$watermark->ttfText(
				$image->getWidth() / 18, //size
				0, //angle
				50, //X
				$image->getHeight() - 30, //Y
				Image::rgb(255, 255, 255),
				__DIR__ . '/Verdana.ttf',
				'ANT studio'
			);
			$image->place($watermark, 0, 0, $this->optionFacade->getOption('watermark_opacity'));

			$dir = $path . DIRECTORY_SEPARATOR . $type;
			Nette\Utils\FileSystem::createDir($dir);
			$image->save($dir . DIRECTORY_SEPARATOR . $imageName, $this->optionFacade->getOption('image_quality'));
		}
	}

}

class FineUploaderException extends \Exception
{

	private $result;

	public function __construct(array $result)
	{
		$this->result = $result;
	}

	public function getResult()
	{
		return $this->result;
	}

}
