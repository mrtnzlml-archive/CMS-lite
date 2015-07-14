<?php

namespace Navigation;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 *
 * @method setIcon(string $icon)
 * @method setName(string $name)
 * @method string getName()
 * @method setUrl(\Url\Url $url)
 */
class NavigationItem extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\Column(type="string", nullable=TRUE)
	 */
	protected $icon = NULL;

	/**
	 * @ORM\Column(type="string")
	 */
	protected $name;

	/**
	 * @ORM\OneToOne(targetEntity="Url\Url", cascade={"persist"})
	 * @ORM\JoinColumn(name="url_id", referencedColumnName="id")
	 * @var \Url\Url
	 */
	protected $url;

}
