<?php

namespace App\Extensions;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 *
 * @method setName(string $name)
 */
class Extension
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string")
	 */
	protected $name;

}
