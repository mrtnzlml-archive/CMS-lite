<?php

namespace TinyMCE;

use Nette;

class TinyControl extends Nette\Forms\Controls\TextArea
{

	public function __construct($label = NULL)
	{
		parent::__construct($label);
	}

	public function getControl()
	{
		/** @var Nette\Forms\Controls\TextArea $control */
		$control = parent::getControl();
		$control->id = 'tinymceTextarea';
		return $control;
	}

	public static function register($method = 'addTinyMCE')
	{
		Nette\Forms\Container::extensionMethod($method, function (Nette\Forms\Container $container, $name, $label = NULL) {
			$container[$name] = new TinyControl($label);
			return $container[$name];
		});
	}

}
