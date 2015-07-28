<?php

namespace Options\Presenters;

use App\AdminModule\Presenters\BasePresenter;
use App\Components\Flashes\Flashes;
use App\Extensions\Registrar;
use Options\Components\AclForm\IAclFactory;
use Options\Components\GeneralForm\IGeneralFormFactory;
use Options\Components\OptionsMenu\IOptionsMenuFactory;
use Options\Components\SeoForm\ISeoFormFactory;

class OptionsPresenter extends BasePresenter
{

	/** @var Registrar */
	public $registrar;

	public function __construct(Registrar $registrar)
	{
		$this->registrar = $registrar;
	}

	public function renderDefault()
	{
		$this->template->extensions = $this->registrar->getExtensions();
	}

	protected function createComponentOptionsMenu(IOptionsMenuFactory $factory)
	{
		$control = $factory->create();
		return $control;
	}

	protected function createComponentAclForm(IAclFactory $factory)
	{
		$control = $factory->create();
		return $control;
	}


	protected function createComponentGeneral(IGeneralFormFactory $factory)
	{
		$control = $factory->create();
		return $control;
	}

	protected function createComponentSeo(ISeoFormFactory $factory)
	{
		$control = $factory->create();
		return $control;
	}

	/**
	 * @secured
	 */
	public function handleInstallExtension($md5)
	{
		$this->registrar->installExtension($md5);
		$this->flashMessage('Rozšíření bylo úspěšně nainstalováno.', Flashes::FLASH_SUCCESS);
		$this->redirect('this');
	}

	/**
	 * @secured
	 */
	public function handleUninstallExtension($id)
	{
		$this->registrar->uninstallExtension($id);
		$this->flashMessage('Rozšíření bylo úspěšně odinstalováno.', Flashes::FLASH_SUCCESS);
		$this->redirect('this');
	}

}
