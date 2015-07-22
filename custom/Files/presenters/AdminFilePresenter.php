<?php
namespace Files\Presenters;

use Files\FileProcess;
use Nette;
use App;
use App\Components\Flashes\Flashes;
use App\AdminModule\Presenters\BasePresenter;
use Kdyby\Doctrine\EntityManager;
use Files\File;

class AdminFilePresenter extends BasePresenter
{
    /** @var EntityManager */
    private $em;
    /** @var FileProcess */
    private $fileProcess;

    public function __construct(EntityManager $em, FileProcess $fileProcess)
    {
        $this->em = $em;
        $this->fileProcess = $fileProcess;
    }

    public function renderDefault()
    {
        $this->template->files = $this->em->getRepository(File::class)->findAll();
    }

    public function handleDelete($id)
    {
        //@todo permission

        $file = $this->em->getRepository(File::class)->find((int)$id);
        if ($file === null) {
            $this->redirect('this');
        }

        $deleted = $this->fileProcess->delete($file);

        ($deleted !== false)    ? $this->flashMessage(_('Soubor byl smazán'), Flashes::FLASH_SUCCESS)
                                : $this->flashMessage(_('Soubor nebyl smazán'), Flashes::FLASH_DANGER);

        $this->redirect('this');

    }
} 