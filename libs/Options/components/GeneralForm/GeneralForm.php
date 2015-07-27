<?php

namespace Options\Components\GeneralForm;

use App\Components\AControl;
use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;
use Options\OptionFacade;

class GeneralForm extends AControl
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

	public function render(array $parameters = NULL)
	{
		if ($parameters) {
			$this->template->parameters = ArrayHash::from($parameters);
		}
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/GeneralForm.latte');
	}

	public function createComponentForm()
	{
		$form = new UI\Form;
		$form->addProtection();

		$form->addText($name = 'site_title', 'Název webu')
			->setDefaultValue($this->optionFacade->getOption($name));
		$form->addText($name = 'site_title_separator', 'Oddělovač titulku')
			->setDefaultValue($this->optionFacade->getOption($name));

		$form['test'] = new MyContainer($this->optionFacade);

		$form->addSubmit('save', 'Uložit změny');
		$form->onSuccess[] = $this->formSucceeded;
		return $form;
	}

	/**
	 * @param UI\Form $_
	 * @param ArrayHash $values
	 */
	public function formSucceeded(UI\Form $_, Nette\Utils\ArrayHash $values)
	{
		$this->optionFacade->setOptions($values);
		$this->presenter->flashMessage('Nastavení bylo úspěšně uloženo.', Flashes::FLASH_SUCCESS);
		$this->redirect('this');
	}

}

interface IGeneralFormFactory
{
	/** @return GeneralForm */
	function create();
}


/**
 * @see http://forum.nette.org/cs/11747-skladani-komponent-a-formulare#p84652
 * @see http://pla.nette.org/cs/dedicnost-vs-kompozice
 */
class MyContainer extends Nette\Forms\Container
{

	private $optionFacade;

	public function __construct(OptionFacade $optionFacade)
	{
		parent::__construct();
		$this->optionFacade = $optionFacade;
		$this->monitor(GeneralForm::class);
	}

	protected function attached($obj)
	{
		parent::attached($obj);
		if ($obj instanceof GeneralForm) {
			$this->addText($name = 'a', 'A')->setDefaultValue($this->optionFacade->getOption($name));
			$this->addText($name = 'b', 'B')->setDefaultValue($this->optionFacade->getOption($name));
			$this['test'] = new MyContainer2($this->optionFacade);
		}
	}

}

class MyContainer2 extends Nette\Forms\Container
{

	private $optionFacade;

	public function __construct(OptionFacade $optionFacade)
	{
		parent::__construct();
		$this->optionFacade = $optionFacade;
		$this->monitor(GeneralForm::class);
	}

	protected function attached($obj)
	{
		parent::attached($obj);
		if ($obj instanceof GeneralForm) {
			$this->addText($name = 'c', 'C')->setDefaultValue($this->optionFacade->getOption($name));
			$this->addText($name = 'd', 'D')->setDefaultValue($this->optionFacade->getOption($name));
		}
	}

}
