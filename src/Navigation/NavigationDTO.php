<?php

namespace Navigation;

use Nette;

/**
 * @method string getItemName()
 * @method integer getTreeDepth()
 */
class NavigationDTO extends Nette\Object
{

	protected $itemId;
	protected $itemName;
	protected $treeDepth;

	public function __construct($itemId, $itemName, $treeDepth)
	{
		$this->itemId = $itemId;
		$this->itemName = $itemName;
		$this->treeDepth = $treeDepth;
	}

}
