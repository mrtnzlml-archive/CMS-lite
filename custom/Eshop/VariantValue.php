<?php

namespace Eshop;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="variant_values")
 *
 * @method setVariant
 * @method setValue(string)
 */
class VariantValue
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\ManyToOne(targetEntity="Variant", cascade={"persist"})
	 * @ORM\JoinColumn(name="variant_id", referencedColumnName="id")
	 * @var
	 */
	protected $variant;

	/**
	 * @ORM\Column(type="string", options={"comment":"Value of the variant (e.g. red, medium, wool)."})
	 * @var string
	 */
	protected $value;

}
