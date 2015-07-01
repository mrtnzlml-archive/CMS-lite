<?php

namespace TinyMCE;

class TinyExtension extends \Nette\DI\CompilerExtension
{

	public function afterCompile(\Nette\PhpGenerator\ClassType $class)
	{
		$init = $class->methods['initialize'];
		$init->addBody('\TinyMCE\TinyControl::register(?);', ['addTinyMCE']);
	}

}
