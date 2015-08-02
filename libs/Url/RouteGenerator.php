<?php

namespace Url;

use Nette;

class RouteGenerator extends Nette\Object
{

	public static function generate($defaultPath, $destination, $id = NULL)
	{
		$url = new Url;
		$url->setFakePath($defaultPath);
		$url->setDestination($destination);
		$url->setInternalId($id);
		return $url;
	}

}
