<?php

namespace Users;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 * @ORM\Table(name="resources")
 *
 * @method setName(string)
 * @method string getName()
 */
class Resource extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\Column(type="string", options={"comment":"Identifier of the role"})
	 * @var string
	 */
	protected $name;

}
