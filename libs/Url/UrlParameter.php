<?php

namespace Url;

use Doctrine\ORM\Mapping as ORM;
use Kdyby;

/**
 * @ORM\Entity
 *
 * @method setName()
 * @method setValue()
 */
class UrlParameter extends Kdyby\Doctrine\Entities\BaseEntity
{

	use Kdyby\Doctrine\Entities\Attributes\Identifier;

	/**
	 * @ORM\ManyToOne(targetEntity="Url", inversedBy="parameters", cascade={"persist"})
	 * @ORM\JoinColumn(name="url_id", referencedColumnName="id")
	 * @var Url
	 */
	protected $url;

	/**
	 * @ORM\Column(type="string")
	 * @var string
	 */
	protected $name;

	/**
	 * @ORM\Column(type="string")
	 * @var string
	 */
	protected $value;

}
