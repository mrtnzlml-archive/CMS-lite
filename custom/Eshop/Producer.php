<?php

namespace Eshop;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 */
class Producer
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string", options={"comment":"Name of the producer"})
	 * @var string
	 */
	protected $name;

}
