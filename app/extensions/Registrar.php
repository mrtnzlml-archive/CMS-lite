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
	public $onInstall = [];
	public $onUninstall = [];

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function registerExtension($extension)
	{
		$this->extensions[] = $extension;
	}

	public function getKnownExtensions()
	{
		return $this->em->getRepository(Extension::class)->findAll();
	}

	public function getUnknownExtensions()
	{
		$this->onExtensionRegistration($this);

		$extensionsRepository = $this->em->getRepository(Extension::class);
		foreach ($this->extensions as $extension) {
			//FIXME: vlastní repository na tyto find dotazy
			if ($extensionsRepository->findOneBy(['name' => $extension]) === NULL) {
				$unknown[md5($extension)] = $extension;
			}
		}

		return isset($unknown) ? $unknown : NULL;
	}

}
