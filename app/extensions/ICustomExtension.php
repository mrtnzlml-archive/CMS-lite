<?php

namespace App\Extensions;

interface ICustomExtension
{

	/**
	 * @return array(
	 *      App\Extensions\Extension $extension,
	 *      string - class with install script (optional)
	 * )
	 */
	public function getExtensionInfo();

}
