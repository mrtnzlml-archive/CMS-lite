<?php

namespace Options\Presenters;

use App\AdminModule\Presenters\BasePresenter;
use App\Components\Flashes\Flashes;
use App\Extensions\Registrar;
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
		return $factory->create();
	}

	protected function createComponentGeneral(IGeneralFormFactory $factory)
	{
		return $factory->create();
	}

	protected function createComponentSeo(ISeoFormFactory $factory)
	{
		return $factory->create();
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
