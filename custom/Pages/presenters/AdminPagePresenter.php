<?php

namespace Pages\Presenters;

use App;
use App\Components\Flashes\Flashes;
use Files\Components\IFineUploaderFactory;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Nette\Application\Responses\JsonResponse;
use Options\Option;
use Options\OptionManager;
use Pages\Components\MultiEdit\IMultiEditFactory;
use Pages\Components\PageForm\IPageFormFactory;
use Pages\Components\PagesGrid\IPagesGridFactory;
use Pages\Page;

class AdminPagePresenter extends App\AdminModule\Presenters\BasePresenter
{

    /** @var EntityManager */
    private $em;

    /** @var OptionManager */
    private $optionManager;

    /** @var Page|NULL */
    private $editablePage = NULL;

    /** @var array */
    private $multiEdit;

    /** @var Option[] */
    private $options;

    private $multiEditFactory;

    public function __construct(EntityManager $em, IMultiEditFactory $multiEditFactory, OptionManager $optionManager)
    {
        $this->em = $em;
        $this->multiEditFactory = $multiEditFactory;
        $this->optionManager = $optionManager;
    }

    public function actionEdit($id = NULL)
    {
        $this->loadEditablePage($id);
    }

    public function renderEdit()
    {
        $this->template->page = $this->editablePage;
    }

    public function actionMultiEdit(array $pages)
    {
        $this->multiEdit = $pages;
    }

    public function actionAttachments($id = NULL)
    {
        $this->loadEditablePage($id);
        $this->options = $this->optionManager->getFileOptions();
    }

    public function renderAttachments()
    {
        $this->template->page = $this->editablePage;
    }

    protected function createComponentMultiEdit()
    {
        return $this->multiEditFactory->create($this->multiEdit);
    }

    protected function createComponentPagesGrid(IPagesGridFactory $gridFactory)
    {
        return $gridFactory->create();
    }

    protected function createComponentPageForm(IPageFormFactory $factory)
    {
        $control = $factory->create($this->editablePage);
        $control->onSave[] = function () {
            $this->flashMessage('Stránka byla úspěšně uložena.', Flashes::FLASH_SUCCESS);
        };
        $control->onPublish[] = function () {
            $this->flashMessage('Stránka byla úspěšně uložena a publikována.', Flashes::FLASH_SUCCESS);
        };
        $control->onException[] = function () {
            $this->flashMessage('Stránku se nepodařilo uložit. Kontaktujte prosím technickou podporu.',
                Flashes::FLASH_DANGER);
        };
        return $control;
    }

    protected function createComponentFineUploader(IFineUploaderFactory $factory)
    {
        $control = $factory->create();
        $control->setOptions($this->options);

        $control->onSuccess[] = function ($control, $file, $result) {
            $this->editablePage->addFile($file);
            $this->em->flush($this->editablePage);
            $this->sendResponse(new JsonResponse($result));
        };

        $control->onFailed[] = function ($control, $result) {
            $this->sendResponse(new JsonResponse($result));
        };

        return $control;
    }

    private function loadEditablePage($id = NULL)
    {
        if ($id === NULL) {
            $this->redirect('new');
        }
        if ($editablePage = $this->em->getRepository(Page::class)->find($id)) {
            $this->editablePage = $editablePage;
        } else {
            $this->redirect('new');
        }
    }

}
