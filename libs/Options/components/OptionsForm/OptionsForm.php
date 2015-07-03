<?php

namespace Options\Components\OptionsForm;

use App\AdminModule\Presenters\BasePresenter;
use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;
use Options\Option;
use Options\OptionCategory;

class OptionsForm extends AControl
{

	private $category;

	/** @var EntityManager */
	private $em;

	public function __construct($category, EntityManager $em)
	{
		$this->category = $category;
		$this->em = $em;
	}

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/OptionsForm.latte');
	}

	public function createComponentGeneralSettings()
	{
		$form = new UI\Form;
		$form->addProtection();

		$category = $this->em->getRepository(OptionCategory::class)->findBy(['name' => $this->category]);
		$options = $this->em->getRepository(Option::class)->findBy(['category' => $category]);

		/** @var Option $option */
		foreach ($options as $option) {
			if (count($option->values) === 1) {
				$value = $option->values[0]->value;
				if ($this->checkBool($value)) {
					$control = $form->addCheckbox($option->key, $option->description);
				} else {
					$control = $form->addText($option->key, $option->description);
				}
				$control->setDefaultValue($value);
			} else {
				$select = [];
				foreach ($option->values as $value) {
					$select[$value->id] = $value->value;
				}
				$form->addSelect($option->key, $option->description, $select);
				//TODO: default values
			}
		}

		$form->addSubmit('save', 'Uložit změny');
		$form->onSuccess[] = $this->generalSettingsSucceeded;
		return $form;
	}

	public function generalSettingsSucceeded(UI\Form $_, Nette\Utils\ArrayHash $values)
	{
		foreach ($values as $key => $value) {
			//...
		}
		$this->em->flush();
//		$this->presenter->flashMessage('Nastavení bylo úspěšně uloženo.', BasePresenter::FLASH_SUCCESS); //FIXME: :-( BasePresenter
		$this->presenter->flashMessage('TODO', BasePresenter::FLASH_DANGER);
		$this->redirect('this');
	}

	private function checkBool($string)
	{
		$string = strtolower($string);
		return in_array($string, ['true', 'false', '1', '0', 'yes', 'no'], TRUE);
	}

}

interface IOptionsFormFactory
{
	/**
	 * @param $category
	 *
	 * @return OptionsForm
	 */
	public function create($category);
}
