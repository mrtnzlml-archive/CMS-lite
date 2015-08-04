<?php

namespace Pages;

use Nette;

class CategoryDTO extends Nette\Object
{

	protected $categoryId;
	protected $categoryName;
	protected $createdAt;
	protected $treeDepth;

	public function __construct($categoryId, $categoryName, $createdAt, $treeDepth)
	{
		$this->categoryId = $categoryId;
		$this->categoryName = $categoryName;
		$this->createdAt = $createdAt;
		$this->treeDepth = $treeDepth;
	}

}
