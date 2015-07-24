<?php
namespace Files\Components;

use App\Components\AControl;
use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Nette\Application\UI\Form;
use Nette\Utils\ArrayHash;
use Nette\Utils\Validators;
use Options\Option;

class FileSettings extends AControl
{
    /** @var Option[] */
    private $options;
    /** @var EntityManager */
    private $em;

    public function __construct($options, EntityManager $em)
    {
        $this->options = $options;
        $this->em = $em;
    }

    protected function createComponentForm()
    {
        $form = new Form;
        $form->addCheckbox(Option::KEY_FILE_DOWNLOAD_PROTECTED)
            ->setValue(isset($this->options[Option::KEY_FILE_DOWNLOAD_PROTECTED])
                ? $this->options[Option::KEY_FILE_DOWNLOAD_PROTECTED]->getValue()->getValue() : FALSE);

        $form->addText(Option::KEY_FILE_MAXFILESIZE)
            ->setValue(isset($this->options[Option::KEY_FILE_MAXFILESIZE])
                ? $this->options[Option::KEY_FILE_MAXFILESIZE]->getValue()->getValue() : FALSE);

        $form->addTextArea(Option::KEY_FILE_ALLOWED_EXTENSIONS)
            ->setValue(isset($this->options[Option::KEY_FILE_ALLOWED_EXTENSIONS])
                ? $this->options[Option::KEY_FILE_ALLOWED_EXTENSIONS]->getValue()->getValue() : FALSE);

        $form->onSuccess[] = $this->saveOptions;

        return $form;
    }

    public function saveOptions(Form $_, ArrayHash $values)
    {
        $allowedExtensions = Validators::is($values->{Option::KEY_FILE_ALLOWED_EXTENSIONS}, 'string:1..')
            ? $values->{Option::KEY_FILE_ALLOWED_EXTENSIONS} : NULL;
        $maxFilesize = ((int) $values->{Option::KEY_FILE_MAXFILESIZE} > 0) ? $values->{Option::KEY_FILE_MAXFILESIZE} : NULL;


        $this->options[Option::KEY_FILE_ALLOWED_EXTENSIONS]->getValue()->setValue($allowedExtensions);
        $this->options[Option::KEY_FILE_MAXFILESIZE]->getValue()->setValue($maxFilesize);
        $this->options[Option::KEY_FILE_DOWNLOAD_PROTECTED]->getValue()->setValue($values->{Option::KEY_FILE_DOWNLOAD_PROTECTED});

        $this->em->flush();

        $this->presenter->flashMessage('Změny byly uloženy', Flashes::FLASH_SUCCESS);
        $this->presenter->redirect('this');
    }

    public function render(array $parameters = NULL)
    {
        if ($parameters) {
            $this->template->parameteres = ArrayHash::from($parameters);
        }

        $this->template->setFile(dirname(__FILE__) . '/templates/fileSettings.latte');
        $this->template->render();
    }
}

interface IFileSettingsFactory
{
    /**
     * @param mixed array | Option[] $options
     * @return FileSettings
     */
    public function create($options);
}

