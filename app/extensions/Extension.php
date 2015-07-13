<?php

namespace App\Extensions;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 *
 * @method setName(string $name)
 */
class Extension extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\Column(type="string")
	 */
	protected $name;

}
