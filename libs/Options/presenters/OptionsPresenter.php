<?php

namespace Options\Presenters;

use App\AdminModule\Presenters\BasePresenter;
use App\Components\Flashes\Flashes;
use App\Extensions\Extension;
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
		$this->template->knownExtensions = $this->registrar->getKnownExtensions();
		$this->template->unknownExtensions = $this->registrar->getUnknownExtensions();
		$this->template->knownTemplates = $this->registrar->getKnownTemplates();
		$this->template->unknownTemplates = $this->registrar->getUnknownTemplates();
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
		/** @var Extension $extension */
		$extension = $unknown[$md5];
		$this->em->persist($extension);
		$this->em->flush($extension);

		$this->registrar->onInstall(); //FIXME: oddělené eventy pro jednotlivá rozšíření (jak?)

		$this->flashMessage('Rozšíření bylo úspěšně nainstalováno.', Flashes::FLASH_SUCCESS);
		$this->redirect('this');
	}

	/**
	 * @secured
	 */
	public function handleInstallTemplate($md5)
	{
		$unknown = $this->registrar->getUnknownTemplates();
		$extension = $unknown[$md5];
		$this->em->persist($extension);
		$this->em->flush($extension);

		$this->registrar->onInstall(); //FIXME: oddělené eventy pro jednotlivá rozšíření (jak?)

		$this->flashMessage('Šablona byla úspěšně nainstalována.', Flashes::FLASH_SUCCESS);
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

	/**
	 * @secured
	 */
	public function handleUninstallTemplate($id)
	{
		$extension = $this->em->getPartialReference(Extension::class, $id);
		$this->em->remove($extension);
		$this->em->flush($extension);

		$this->registrar->onUninstall();

		$this->flashMessage('Šablona byla úspěšně odinstalována.', Flashes::FLASH_SUCCESS);
		$this->redirect('this');
	}

}
