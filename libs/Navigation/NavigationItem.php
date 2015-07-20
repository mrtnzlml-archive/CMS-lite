<?php

namespace Navigation;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 *
 * @method setIcon(string $icon)
 * @method setName(string $name)
 * @method string getName()
 * @method setUrl(\Url\Url $url)
 */
class NavigationItem
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string", nullable=TRUE)
	 */
	protected $icon = NULL;

	/**
	 * @ORM\Column(type="string")
	 */
	protected $name;

	/**
	 * @ORM\Column(type="boolean")
	 */
	protected $root = FALSE;

	/**
	 * @ORM\OneToOne(targetEntity="Url\Url", cascade={"persist"})
	 * @ORM\JoinColumn(name="url_id", referencedColumnName="id")
	 * @var \Url\Url
	 */
	protected $url;

	/**
	 * @ORM\ManyToMany(targetEntity="Navigation", inversedBy="items", cascade={"persist"})
	 * @ORM\JoinTable(
	 *        joinColumns={@ORM\JoinColumn(name="item_id", referencedColumnName="id")},
	 *        inverseJoinColumns={@ORM\JoinColumn(name="navigation_id", referencedColumnName="id")}
	 *    )
	 * @var Navigation[]|\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $navigations;

	public function __construct()
	{
		$this->navigations = new ArrayCollection;
	}

	public function setRoot()
	{
		$this->root = TRUE;
		return $this;
	}

}
