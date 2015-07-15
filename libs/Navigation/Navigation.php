<?php

namespace Navigation;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 *
 * @method setName(string $name)
 */
class Navigation extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\Column(type="string")
	 */
	protected $name;

	/**
	 * @ORM\ManyToMany(targetEntity="NavigationItem", mappedBy="navigations", cascade={"persist"})
	 * @var NavigationItem[]|\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $items;

}
