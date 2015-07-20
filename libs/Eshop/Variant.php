<?php

namespace Eshop;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="variants")
 *
 * @method setName(string)
 */
class Variant
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string", unique=TRUE, options={"comment":"Name of the variant (e.g. color, size, material)."})
	 * @var string
	 */
	protected $name;

}
