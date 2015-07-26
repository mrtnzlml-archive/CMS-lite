<?php

namespace Files\Presenters;

use App;
use App\AdminModule\Presenters\BasePresenter;
use App\Components\Flashes\Flashes;
use Files\Components\IFileFormFactory;
use Files\Components\IFileSettingsFactory;
use Files\Components\IFineUploaderFactory;
use Files\File;
use Files\FileProcess;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\Responses\JsonResponse;

class AdminFilePresenter extends BasePresenter
{

	/** @var EntityManager */
	private $em;
	/** @var FileProcess */
	private $fileProcess;
	/** @var File */
	private $file;

	public function __construct(EntityManager $em, FileProcess $fileProcess)
	{
		$this->em = $em;
		$this->fileProcess = $fileProcess;
	}

    public function renderDefault()
    {
        $this->template->files = $this->em->getRepository(File::class)->findAll();
    }

    public function actionEdit($id)
    {
        $this->file = $this->em->getRepository(File::class)->find((int) $id);
        if ($this->file === NULL) {
            $this->redirect('default');
        }
    }

    public function renderEdit()
    {
        $this->template->file = $this->file;
    }

    /**
     * @secured
     */
    public function handleDelete($id)
    {
        //@todo permission

        $file = $this->em->getRepository(File::class)->find((int) $id);
        if ($file === NULL) {
            $this->redirect('this');
        }

        $deleted = $this->fileProcess->delete($file);

        ($deleted !== FALSE) ? $this->flashMessage(_('Soubor byl smazán'), Flashes::FLASH_SUCCESS)
            : $this->flashMessage(_('Soubor nebyl smazán'), Flashes::FLASH_DANGER);

        $this->redirect('this');

    }

    protected function createComponentFileForm(IFileFormFactory $factory)
    {
        $control = $factory->create($this->file, $this->fileProcess);

        $control->onUpdate[] = function () {
            $this->flashMessage('Změny byly uloženy', Flashes::FLASH_SUCCESS);
        };

        $control->onComplete[] = function () {
            $this->redirect('default');
        };

        return $control;
    }

    protected function createComponentFineUploader(IFineUploaderFactory $factory)
    {
        $control = $factory->create();

        $control->onSuccess[] = function ($control, $file, $result) {
            $this->sendResponse(new JsonResponse($result));
        };

        $control->onFailed[] = function ($control, $result) {
            $this->sendResponse(new JsonResponse($result));
        };

        return $control;
    }

	protected function createComponentFileSettings(IFileSettingsFactory $factory)
	{
		return $factory->create();
	}
}
