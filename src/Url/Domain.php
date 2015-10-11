<?php

namespace Url;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity(readOnly=TRUE)
 */
class Domain
{

	use Identifier;
	use MagicAccessors;

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
