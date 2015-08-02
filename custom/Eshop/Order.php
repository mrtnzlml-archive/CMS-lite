<?php

namespace Eshop;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="orders")
 */
class Order
{

	use Identifier;
	use MagicAccessors;

}
