<?php

namespace App\Macros;

use Latte;
use Latte\Compiler;
use Latte\MacroNode;
use Latte\Macros\MacroSet;
use Latte\PhpWriter;

class BootstrapMacros extends MacroSet
{

	public static function install(Compiler $compiler)
	{
		/** @var BootstrapMacros $macroset */
		$macroset = new static($compiler);
		$macroset->addMacro('row', [$macroset, 'rowBegin'], [$macroset, 'rowEnd']);
		$macroset->addMacro('col', [$macroset, 'colBegin'], [$macroset, 'colEnd']);
		return $macroset;
	}

	/**
	 * @param MacroNode $node
	 * @param PhpWriter $writer
	 *
	 * @return string
	 */
	public function rowBegin(MacroNode $node, PhpWriter $writer)
	{
		return $writer->write("echo '<div class=row>'");
	}

	/**
	 * @param MacroNode $node
	 * @param PhpWriter $writer
	 *
	 * @return string
	 */
	public function rowEnd(MacroNode $node, PhpWriter $writer)
	{
		return $writer->write("echo '</div>'");
	}

	/**
	 * @param MacroNode $node
	 * @param PhpWriter $writer
	 *
	 * @return string
	 * @throws Latte\CompileException
	 *
	 * TODO: ještě další varianty (md, xs)
	 */
	public function colBegin(MacroNode $node, PhpWriter $writer)
	{
		if ($node->args === '') {
			throw new Latte\CompileException('Col arguments cannot be empty');
		}
		preg_match('~[-_]?([a-z0-9]{1,2})[-_\s]([a-z0-9]{1,2})~', $node->args, $matches);
		if (is_numeric($matches[1])) {
			$size = (int)$matches[1];
			$type = $matches[2];
		} else {
			$size = (int)$matches[2];
			$type = $matches[1];
		}
		return $writer->write("echo '<div class=col-$type-$size>'");
	}

	/**
	 * @param MacroNode $node
	 * @param PhpWriter $writer
	 *
	 * @return string
	 */
	public function colEnd(MacroNode $node, PhpWriter $writer)
	{
		return $writer->write("echo '</div>'");
	}

}
