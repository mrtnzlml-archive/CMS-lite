<?php

namespace Navigation;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;
use Nette;

/**
 * @ORM\Entity
 */
class NavigationTreePath extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\ManyToOne(targetEntity="NavigationItem", cascade={"persist"})
	 * @ORM\JoinColumn(name="ancestor_id", referencedColumnName="id")
	 * @var NavigationItem
	 */
	protected $ancestor;

	/**
	 * @ORM\ManyToOne(targetEntity="NavigationItem", cascade={"persist"})
	 * @ORM\JoinColumn(name="descendant_id", referencedColumnName="id")
	 * @var NavigationItem
	 */
	protected $descendant;

	/**
	 * @ORM\Column(type="integer")
	 * @var int
	 */
	protected $depth;

	public function __construct(NavigationItem $ancestor, NavigationItem $descendant, $depth)
	{
		if (!is_numeric($depth)) {
			throw new Nette\InvalidArgumentException(sprintf('Depth should be numeric, %s given.', gettype($depth)));
		}
		$this->ancestor = $ancestor;
		$this->descendant = $descendant;
		$this->depth = $depth;
	}

}
