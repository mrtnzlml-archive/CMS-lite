<?php

namespace Files\Components;

use App\Components\AControl;
use Files\File;
use Files\FileProcess;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Nette\Application\UI\Form;
use Nette\Utils\ArrayHash;
use Nette\Utils\Validators;


/**
 * @method onUpdate(FileForm $control, File $entity)
 * @method onComplete(FileForm $control)
 */
class FileForm extends AControl
{
	/** @var \Closure[] */
	public $onUpdate = [];

	/** @var \Closure[] */
	public $onComplete = [];

	/** @var File $file */
	private $file;
	/** @var EntityManager $em */
	private $em;
	/** @var FileProcess */
	private $fileProcess;

	public function __construct(File $file, FileProcess $fileProcess, EntityManager $em)
	{
		$this->file = $file;
		$this->fileProcess = $fileProcess;
		$this->em = $em;
	}

	protected function createComponentForm()
	{
		$form = new Form;
        $form->addText('title', 'Název (nadpis) souboru')
            ->setValue($this->file->getTitle());
        $form->addTinyMCE('editor')
			->setValue($this->file->getDescription());
		$form->addSubmit('save', 'Uložit');
		$form->onSuccess[] = $this->save;
		return $form;
	}

	public function save(Form $_, ArrayHash $values)
	{
		$this->fillEntityWithValues($values);

		$entity = $this->file;
		$this->fileProcess->onUpdate[] = function (FileProcess $fp, File $file) use ($entity) {
			$this->em->flush($entity);
			$this->onUpdate($this, $entity);
		};

		$this->fileProcess->update($entity);

		$this->onComplete($this);
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameteres = Nette\Utils\ArrayHash::from($parameters);
		}

		$this->template->setFile(dirname(__FILE__) . '/templates/form.latte');
        $this->template->file = $this->file;
		$this->template->render();
	}

	private function fillEntityWithValues(ArrayHash $values)
	{
		$title = Validators::is($values->title, 'string:1..') ? $values->title : NULL;
		$description = Validators::is($values->editor, 'string:1..') ? $values->editor : NULL;

		$this->file->setTitle($title);
		$this->file->setDescription($description);
	}
}

interface IFileFormFactory
{
	/**
	 * @return FileForm
	 */
	public function create(File $file);
}
