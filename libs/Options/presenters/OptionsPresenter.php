<?php

namespace Options\Presenters;

use App\AdminModule\Presenters\BasePresenter;
use App\Components\Flashes\Flashes;
use App\Extensions\Registrar;
use Kdyby\Doctrine\EntityManager;
use Options\Components\OptionsForm\IOptionsFormFactory;
use Options\Components\OptionsMenu\IOptionsMenuFactory;

class OptionsPresenter extends BasePresenter
{

	/** @var Registrar */
	public $registrar;

	/** @var EntityManager */
	private $em;

	public function __construct(Registrar $registrar, EntityManager $em)
	{
		$this->registrar = $registrar;
		$this->em = $em;
	}

	public function renderDefault()
	{
		$this->template->extensions = $this->registrar->getExtensions();
	}

	protected function createComponentOptionsMenu(IOptionsMenuFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentGeneralSettings(IOptionsFormFactory $factory)
	{
		return $factory->create('general');
	}

	protected function createComponentSeoSettings(IOptionsFormFactory $factory)
	{
		return $factory->create('seo');
	}

	/**
	 * @secured
	 */
	public function handleInstallExtension($md5)
	{
		$extension = $this->registrar->getExtensionNames($md5);
		$method = 'install';
		if (method_exists($extension, $method)) {
			(new $extension)->$method();
		}

		$this->flashMessage('Rozšíření bylo úspěšně nainstalováno.', Flashes::FLASH_SUCCESS);
		$this->redirect('this');
	}

}
