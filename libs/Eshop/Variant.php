<?php

namespace Eshop;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 * @ORM\Table(name="variants")
 *
 * @method setName(string)
 */
class Variant extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\Column(type="string", unique=TRUE, options={"comment":"Name of the variant (e.g. color, size, material)."})
	 * @var string
	 */
	protected $name;

}
