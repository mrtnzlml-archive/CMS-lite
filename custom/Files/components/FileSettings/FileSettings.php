<?php

namespace Files\Components;

use App\Components\AControl;
use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Nette\Application\UI\Form;
use Nette\Utils\ArrayHash;
use Options\OptionFacade;

class FileSettings extends AControl
{

	/** @var EntityManager */
	private $em;

	/** @var OptionFacade */
	private $optionFacade;

	public function __construct(EntityManager $em, OptionFacade $optionFacade)
	{
		$this->em = $em;
		$this->optionFacade = $optionFacade;
	}

	protected function createComponentForm()
	{
		$form = new Form;
		$form->addCheckbox($name = 'download_protected')
			->setDefaultValue($this->optionFacade->getOption($name));

		$form->addText($name = 'max_filesize')
			->setDefaultValue($this->optionFacade->getOption($name));

		$form->addText($name = 'allowed_extensions')
			//TODO: selectize.js (viz Pages)
			->setDefaultValue(implode(', ', $this->optionFacade->getOption($name)));

		$form->onSuccess[] = $this->saveOptions;
		return $form;
	}

	public function saveOptions(Form $_, ArrayHash $values)
	{
		$values->allowed_extensions = array_unique(array_filter(preg_split('~\s*,\s*~', $values->allowed_extensions)));
		$this->optionFacade->setOptions($values);
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
	 * @return FileSettings
	 */
	public function create();
}
