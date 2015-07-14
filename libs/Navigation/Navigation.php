<?php

namespace Navigation;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 */
class Navigation extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\Column(type="string")
	 */
	protected $name;

	/**
	 * @ORM\ManyToMany(targetEntity="NavigationItem", cascade={"persist"})
	 * @ORM\JoinTable(
	 *        joinColumns={@ORM\JoinColumn(name="item_id", referencedColumnName="id")},
	 *        inverseJoinColumns={@ORM\JoinColumn(name="navigation_id", referencedColumnName="id")}
	 *    )
	 * @var NavigationItem[]|\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $items;

}
