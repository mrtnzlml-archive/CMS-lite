<?php

namespace App;

use Nette\Forms\IControl;
use Nette\Utils\Strings;

class Validator
{

	const FAKE_PATH = 'App\Validator::validateFakePath';

	public static function validateFakePath(IControl $control)
	{
		return (bool)Strings::match($control->getValue(), '~[a-z0-9\/-]+~i');
	}

}
