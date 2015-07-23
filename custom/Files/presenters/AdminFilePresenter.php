<?php
namespace Files\Presenters;

use Files\Components\IFileFormFactory;
use Files\Components\IFileSettingsFactory;
use Files\Components\IFineUploaderFactory;
use Files\FileProcess;
use Nette;
use App;
use App\Components\Flashes\Flashes;
use App\AdminModule\Presenters\BasePresenter;
use Kdyby\Doctrine\EntityManager;
use Files\File;
use Nette\Application\Responses\JsonResponse;
use Options\Option;
use Options\OptionManager;
use Pages\Query\OptionsQuery;

class AdminFilePresenter extends BasePresenter
{
    /** @var EntityManager */
    private $em;
    /** @var FileProcess */
    private $fileProcess;
    /** @var OptionManager */
    private $optionManager;
    /** @var File */
    private $file;
    /** @var Option[] */
    private $options;

    public function __construct(EntityManager $em, FileProcess $fileProcess, OptionManager $optionManager)
    {
        $this->em = $em;
        $this->fileProcess = $fileProcess;
        $this->optionManager = $optionManager;
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

    public function actionUpload()
    {
        $this->options = $this->optionManager->getFileOptions();
    }

    public function actionSettings()
    {
        $this->options = $this->optionManager->getFileOptions();
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
        $control->setOptions($this->options);

        $control->onSuccess[] = function ($control, $file, $result) {
            //@todo kontrola na dodatecne parametry -> napr.pridani ke strance -> jeste lepe udelat UploadPresenter
            $this->sendResponse(new JsonResponse($result));
        };

        $control->onFailed[] = function ($control, $result) {
            $this->sendResponse(new JsonResponse($result));
        };

        return $control;
    }

    protected function createComponentFileSettings(IFileSettingsFactory $factory)
    {
        $control = $factory->create($this->options);
        return $control;
    }
} 