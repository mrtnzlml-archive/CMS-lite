<?php

namespace TinyMCE\DI;

use App\Components\Js\Providers\IJsAdminProvider;
use Nette;

class TinyExtension extends Nette\DI\CompilerExtension implements IJsAdminProvider
{

	public function afterCompile(Nette\PhpGenerator\ClassType $class)
	{
		$init = $class->methods['initialize'];
		$init->addBody('\TinyMCE\TinyControl::register(?);', ['addTinyMCE']);
	}

	public function getJsAdminScripts()
	{
		yield 'https://cms.dev/js/tinymce/tinymce.min.js'; //FIXME
		yield __DIR__ . '/../assets/tinymce.js';
	}

}
