<?php

namespace Pages;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="page_page_categories", uniqueConstraints={
 *      @ORM\UniqueConstraint(columns={"page_id", "category_id"})
 * })
 *
 * @method setPageOrder(integer $order)
 * @method integer getPageOrder()
 */
class PageCategory
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\ManyToOne(targetEntity="Page", inversedBy="pageCategories", cascade={"persist"})
	 * @ORM\JoinColumn(name="page_id", referencedColumnName="id")
	 * @var Page
	 */
	protected $page;

	/**
	 * @ORM\ManyToOne(targetEntity="Category", inversedBy="pageCategories", cascade={"persist"})
	 * @ORM\JoinColumn(name="category_id", referencedColumnName="id")
	 * @var Category
	 */
	protected $category;

	/**
	 * @ORM\Column(type="integer", options={"default": 0})
	 * @var int
	 */
	protected $pageOrder = 0;

	public function setPage($page)
	{
		$this->page = $page;
		return $this;
	}

	public function setCategory(Category $category)
	{
		$this->category = $category;
		return $this;
	}

}
