<?php

namespace App\Extensions;

use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\DI\Container;

/**
 * @method onExtensionRegistration(Registrar $registrar)
 * @method onInstall()
 * @method onUninstall()
 */
class Registrar extends Nette\Object
{

	/** @var \Closure[] */
	public $onExtensionRegistration = [];

	/** @var EntityManager */
	private $em;

	/** @var array [md5 => Extension $extension] */
	private $extensions = [];

	/** @var Container */
	private $serviceLocator;

	public function __construct(EntityManager $em, Container $serviceLocator)
	{
		$this->em = $em;
		$this->serviceLocator = $serviceLocator;
	}

	/**
	 * This function is called on event "onExtensionRegistration" and it's used for collect known extensions in CMS
	 * environment. Valid extension is extension which implements ICustomExtension interface and is instantiable.
	 *
	 * @param array $extensionNames
	 */
	public function registerExtensionNames(array $extensionNames)
	{
		$tmp = [];
		foreach ($extensionNames as $extensionName) {
			$tmp[md5($extensionName)] = (new $extensionName)->getExtensionInfo();
		}
		$this->extensions = $tmp;
	}

	public function getExtensions()
	{
		$this->onExtensionRegistration($this);
		return array_map(function ($extension) {
			return $extension[0];
		}, $this->extensions);
	}

	public function getExtensionNames($key = NULL)
	{
		$this->onExtensionRegistration($this);
		if ($key === NULL) {
			return $this->extensions;
		}
		return $this->extensions[$key];
	}

	public function installExtension($md5)
	{
		//TODO: check if it's allready installed
		$extension = $this->getExtensionNames($md5);
		$extension[0]->setHash($md5);
		$this->em->persist($extension[0]);
		$this->em->flush($extension[0]);

		if (isset($extension[1])) {
			$installer = $this->serviceLocator->getByType($extension[1]);
			$installer->install();
		}
	}

	public function uninstallExtension($md5)
	{
		$extension = $this->getExtensionNames($md5);

		$extEntity = $this->em->getRepository(Extension::class)->findOneBy(['hash' => $md5]);
		$this->em->remove($extEntity);
		$this->em->flush($extEntity);

		if (isset($extension[1])) {
			$installer = $this->serviceLocator->getByType($extension[1]);
			$installer->uninstall();
		}
	}

}
