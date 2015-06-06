<?php

namespace Options\Components\OptionsForm;

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
			if ($this->checkBool($option->value)) {
				$control = $form->addCheckbox($option->key, $option->fullName);
			} else {
				$control = $form->addText($option->key, $option->fullName);
			}
			$control->setDefaultValue($option->value);
		}

		$form->onSuccess[] = $this->generalSettingsSucceeded;
		return $form;
	}

	public function generalSettingsSucceeded(UI\Form $form, Nette\Utils\ArrayHash $values)
	{
		$this->presenter->flashMessage('TODO', 'danger');
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
