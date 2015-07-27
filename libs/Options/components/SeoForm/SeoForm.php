<?php

namespace Options\Components\SeoForm;

use App\Components\AControl;
use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;
use Options\OptionFacade;

class SeoForm extends AControl
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
		$this->template->render($this->templatePath ?: __DIR__ . '/templates/SeoForm.latte');
	}

	public function createComponentForm()
	{
		$form = new UI\Form;
		$form->addProtection();

		$form->addCheckbox($name = 'index', 'Indexovat web')
			->setDefaultValue($this->optionFacade->getOption($name));

		$form->addSelect($name = 'page_url_end', 'URL koncovka stránek', $extensions = [
			NULL => 'Žádná', '/' => '/', '.htm' => '.htm', '.html' => '.html',
		])->setDefaultValue($this->optionFacade->getOption($name));

		$form->addSelect($name = 'category_url_end', 'URL koncovka kategorií', $extensions)
			->setDefaultValue($this->optionFacade->getOption($name));

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

interface ISeoFormFactory
{
	/** @return SeoForm */
	function create();
}
