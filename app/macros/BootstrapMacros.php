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
		$macroset->addMacro('div', [$macroset, 'divBegin'], [$macroset, 'divEnd']);
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
		$class = 'row';
		if ($node->args) {
			$class .= ' ' . $node->args;
		}
		return $writer->write("echo '<div class=\"$class\">'");
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
	 */
	public function colBegin(MacroNode $node, PhpWriter $writer)
	{
		if ($node->args === '') {
			throw new Latte\CompileException('Col arguments cannot be empty');
		}
		preg_match_all("~[-_\s]?([a-z]{1,2})[-_\s]?([0-9]{1,2})~", $node->args, $matches);
		$dict = ['l' => 'lg', 'm' => 'md', 's' => 'sm', 'x' => 'xs'];
		$output = '';
		$iterator = 0;
		foreach ($matches[1] as $match) {
			$output .= $iterator === 0 ? '' : ' ';
			$output .= 'col-' . (isset($dict[$match]) ? $dict[$match] : $match);
			$output .= '-' . $matches[2][$iterator];
			$iterator++;
		}
		return $writer->write("echo '<div class=\"$output\">'");
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
