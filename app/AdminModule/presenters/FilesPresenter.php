<?php

namespace App\AdminModule\Presenters;

use App;
use Files\Components\IFileFormFactory;
use Files\Components\IFineUploaderFactory;
use Files\File;
use Files\FileProcess;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Files\FineUploader;
use Nette\Application\Responses\JsonResponse;

class FilesPresenter extends BasePresenter
{
    /** @var EntityManager */
    private $em;
    /** @var FineUploader */
    private $fineUploader;
    /** @var FileProcess */
    private $fileProcess;

    /** @var File */
    private $file;

    public function __construct(EntityManager $em, FineUploader $uploader, FileProcess $fileProcess)
    {
        $this->em = $em;
        $this->fineUploader = $uploader;
        $this->fileProcess = $fileProcess;
    }

    public function renderDefault()
    {
        $this->template->files = $this->em->getRepository(File::class)->findAll();
    }

    public function actionEdit($id)
    {
        $this->file = $this->em->getRepository(File::class)->find((int)$id);
        if ($this->file === null) {
            $this->redirect('default');
        }
    }

	/**
	 * @secured
	 */
    public function handleDelete($id)
    {
        $file = $this->em->getRepository(File::class)->find((int) $id);
        if($file === NULL) {
            $this->redirect('this');
        }

        $deleted = $this->fileProcess->delete($file);
        ($deleted !== false) ? $this->flashMessage(_('Soubor byl smazán'), self::FLASH_SUCCESS)
                             : $this->flashMessage(_('Soubor nebyl smazán'), self::FLASH_ERROR);

        $this->redirect('this');
    }

    protected function createComponentFineUploader(IFineUploaderFactory $factory)
    {
        $control = $factory->create($this->fineUploader);

        $control->onSuccess[] = function ($control, $file, $result) {
            $this->sendResponse(new JsonResponse($result));
        };

        $control->onFailed[] = function ($control, $result) {
            $this->sendResponse(new JsonResponse($result));
        };

        return $control;
    }

    protected function createComponentFileForm(IFileFormFactory $factory)
    {
        $control = $factory->create($this->file, $this->fileProcess);

        $control->onUpdate[] = function () {
            $this->flashMessage('Změny byly uloženy.', self::FLASH_SUCCESS);
        };

        $control->onComplete[] = function () {
            $this->redirect('default');
        };

        return $control;
    }

}
