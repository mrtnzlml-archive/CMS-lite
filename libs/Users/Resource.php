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
 * @method setResource(string $resource)
 * @method string getResource()
 */
class Resource
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string")
	 * @var string
	 */
	protected $name;

	/**
	 * @ORM\Column(type="string", unique=TRUE, options={"comment":"Identifier of the role"})
	 * @var string
	 */
	protected $resource;

}
