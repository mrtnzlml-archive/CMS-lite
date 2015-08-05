<?php

namespace Navigation\Latte;

use Latte\CompileException;
use Latte\Compiler;
use Latte\MacroNode;
use Latte\Macros\MacroSet;
use Latte\PhpWriter;

class Menu extends MacroSet
{

	public static function install(Compiler $compiler)
	{
		/** @var Menu $macroset */
		$macroset = new static($compiler);
		$macroset->addMacro('menu', [$macroset, 'macroMenu']);
		return $macroset;
	}

	public function macroMenu(MacroNode $node, PhpWriter $writer)
	{
		$words = $node->tokenizer->fetchWords();
		if (!$words) {
			throw new CompileException('Missing menu name in {menu}');
		}
		$name = $writer->formatWord($words[0]);
		return '$_l->tmp = $_control->getComponent(\'customMenu\'); '
		. '$_l->tmp->setIdentifier(' . $name . '); '
		. 'if ($_l->tmp instanceof Nette\Application\UI\IRenderable) $_l->tmp->redrawControl(NULL, FALSE); '
		. ($writer->write("ob_start(); \$_l->tmp->render(); echo %modify(ob_get_clean())"));
	}

}
