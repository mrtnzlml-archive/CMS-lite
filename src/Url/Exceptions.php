<?php

namespace Url;

class DuplicateRouteException extends \Exception
{

	public function __construct($message = NULL)
	{
		if ($message === NULL) {
			$message = 'Tato URL adresa je již zabraná.';
		}
		parent::__construct($message);
	}

}
