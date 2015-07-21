<?php

namespace Options\Presenters;

use App\AdminModule\Presenters\BasePresenter;
use App\Components\Flashes\Flashes;
use App\Extensions\Extension;
use App\Extensions\Registrar;
use Kdyby\Doctrine\EntityManager;
use Navigation\IMenuEditorFactory;
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
		$this->template->known = $this->registrar->getKnownExtensions();
		$this->template->unknown = $this->registrar->getUnknownExtensions();
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
		$unknown = $this->registrar->getUnknownExtensions();

		$extension = new Extension;
		$extension->setName($unknown[$md5]);
		$this->em->persist($extension);
		$this->em->flush($extension);

		$this->registrar->onInstall();

		$this->flashMessage('Rozšíření bylo úspěšně nainstalováno.', Flashes::FLASH_SUCCESS);
		$this->redirect('this');
	}

	/**
	 * @secured
	 */
	public function handleUninstallExtension($id)
	{
		$extension = $this->em->getPartialReference(Extension::class, $id);
		$this->em->remove($extension);
		$this->em->flush($extension);

		$this->registrar->onUninstall();

		$this->flashMessage('Rozšíření bylo úspěšně odinstalováno.', Flashes::FLASH_SUCCESS);
		$this->redirect('this');
	}

}
