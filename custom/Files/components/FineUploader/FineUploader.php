<?php

namespace Files\Components;

use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Files\FineUploader as Uploader;
use Files\File;
use Files\FileProcess;

class FineUploader extends AControl
{
    /** @var EntityManager */
    private $em;
    /** @var Uploader */
    private $uploader;
    /** @var FileProcess */
    private $fileProcess;
    /** @var string */
    private $dir;

    public $onSuccess = array();
    public $onFailed = array();

    public function __construct($dir, EntityManager $em, Uploader $uploader, FileProcess $fileProcess)
    {
        $this->dir = $dir;
        $this->em = $em;
        $this->uploader = $uploader;
        $this->fileProcess = $fileProcess;
    }

    public function handleUpload()
    {
        //@todo -> moznost si poslat dodatecne parametry -> ty pak pridat do resultu presenteru
        //napr. ID stranky - znamena pridat soubor ke strance
        //dump($this->presenter->getParameters());

        $result = $this->uploader->handleUpload($this->dir);
        $this->uploadProcess($result);
    }

    private function uploadProcess($result)
    {
        if (!isset($result['success']) || $result['success'] !== true) {
            $this->onFailed($this, $result);
        }

        $file = new File();
        $name = $this->uploader->getName(false);
        $file->setName($name);
        $file->setSanitizedName($this->uploader->getName());
        $file->setTitle(str_replace('-', ' ', $result['filename']));
        $file->setUuid($result['uuid']);
        $file->setSize($result['size']);
        $file->setExtension($result['extension']);

        $this->fileProcess->create($file);
        $this->em->flush($file);

        $this->onSuccess($this, $file, $result);
    }

    public function render(array $parameters = null)
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
    public function create();
}