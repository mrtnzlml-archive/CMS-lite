<?php

namespace App\Extensions;

use Kdyby\Doctrine\EntityManager;
use Nette;

/**
 * @method onExtensionRegistration(Registrar $registrar)
 * @method onInstall()
 * @method onUninstall()
 */
class Registrar extends Nette\Object
{

	private $extensions = [];

	public $onExtensionRegistration = [];

	/** @var \Closure[] function(); Occurs when extension is being installed */
	public $onInstall = [];

	/** @var \Closure[] function(); Occurs when extension is being uninstalled */
	public $onUninstall = [];

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function registerExtension(Extension $extension)
	{
		$this->extensions[] = $extension;
	}

	public function getKnownExtensions()
	{
		return $this->em->getRepository(Extension::class)->findBy(['template' => FALSE]);
	}

	public function getKnownTemplates()
	{
		return $this->em->getRepository(Extension::class)->findBy(['template' => TRUE]);
	}

	public function getUnknownExtensions()
	{
		$this->onExtensionRegistration($this);

		$extensionsRepository = $this->em->getRepository(Extension::class);
		/** @var Extension $extension */
		foreach ($this->extensions as $extension) {
			if ($extension->getTemplate()) {
				continue;
			}
			if ($extensionsRepository->findOneBy([
					'name' => $extension->getName(),
					'template' => FALSE,
				]) === NULL
			) {
				$unknown[md5($extension->getName())] = $extension;
			}
		}

		return isset($unknown) ? $unknown : NULL;
	}

	public function getUnknownTemplates()
	{
		$this->onExtensionRegistration($this); //FIXME: event pro šablony

		$extensionsRepository = $this->em->getRepository(Extension::class);
		/** @var Extension $extension */
		foreach ($this->extensions as $extension) {
			if (!$extension->getTemplate()) {
				continue;
			}
			if ($extensionsRepository->findOneBy([
					'name' => $extension->getName(),
					'template' => TRUE,
				]) === NULL
			) {
				$unknown[md5($extension->getName())] = $extension;
			}
		}

		return isset($unknown) ? $unknown : NULL;
	}

}
