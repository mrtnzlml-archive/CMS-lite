<?php

namespace Users;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="resources")
 *
 * @method setName(string $name)
 * @method string getName()
 */
class Resource
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string", unique=TRUE, options={"comment":"Identifier of the role"})
	 * @var string
	 */
	protected $name;

}
