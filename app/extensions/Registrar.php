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

	/** @var \Closure[] */
	public $onExtensionRegistration = [];

	/** @var EntityManager */
	private $em;

	/** @var array [md5 => Extension $extension] */
	private $extensions = [];

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	/**
	 * This function is called on event "onExtensionRegistration" and it's used for collect known extensions in CMS
	 * environment. Valid extension is extension which implements ICustomExtension interface and is instantiable.
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
		return $this->extensions;
	}

	public function getExtensionNames($key = NULL)
	{
		$this->onExtensionRegistration($this);
		if ($key === NULL) {
			return $this->extensions;
		}
		return $this->extensions[$key];
	}

}
