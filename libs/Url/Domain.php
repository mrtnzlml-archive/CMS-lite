<?php

namespace Url;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 */
class Domain extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\Column(type="string", unique=TRUE)
	 * @var string
	 */
	protected $host;

	/**
	 * @ORM\Column(type="string", unique=TRUE)
	 * @var string
	 */
	protected $locale;

}
