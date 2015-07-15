<?php

namespace Navigation;

use Nette;

/**
 * @see http://dbushell.github.io/Nestable/
 */
class Nestable extends Nette\Object
{

	public static function resolveJson($input)
	{
		if (is_string($input)) {
			$input = Nette\Utils\Json::decode($input);
		}
		$tree = [];
		foreach ($input as $item) {
			if (!isset($item->children)) {
				$tree[$item->id] = $item->id;
			} else {
				$tmp = [];
				foreach ($item->children as $child) {
					$tmp[$child->id] = isset($child->children) ? self::resolveJson($child->children) : $child->id;
				}
				$tree[$item->id] = $tmp;
			}
		}
		return array_filter($tree);
	}

}
