<?php

namespace Pages;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Nette;

/**
 * @ORM\Entity
 */
class PageCategoryTreePath extends Nette\Object
{

	use Identifier;

	/**
	 * @ORM\ManyToOne(targetEntity="PageCategory", cascade={"persist"})
	 * @ORM\JoinColumn(name="ancestor_id", referencedColumnName="id")
	 * @var PageCategory
	 */
	protected $ancestor;

	/**
	 * @ORM\ManyToOne(targetEntity="PageCategory", cascade={"persist"})
	 * @ORM\JoinColumn(name="descendant_id", referencedColumnName="id")
	 * @var PageCategory
	 */
	protected $descendant;

	/**
	 * @ORM\Column(type="integer")
	 * @var int
	 */
	protected $depth;

	/**
	 * @ORM\Column(type="integer")
	 * @var int
	 */
	protected $item_order = 0;

	public function __construct(PageCategory $ancestor, PageCategory $descendant, $depth)
	{
		if (!is_numeric($depth)) {
			throw new Nette\InvalidArgumentException(sprintf('Depth should be numeric, %s given.', gettype($depth)));
		}
		$this->ancestor = $ancestor;
		$this->descendant = $descendant;
		$this->depth = $depth;
	}

}
