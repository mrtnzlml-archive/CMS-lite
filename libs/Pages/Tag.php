<?php

namespace Pages;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 *
 * @method setName(string $name)
 */
class Tag extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\Column(type="string")
	 * @var string
	 */
	protected $name;

}
