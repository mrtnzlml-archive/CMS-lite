<?php

namespace Options;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="option_categories")
 */
class OptionCategory
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string", unique=TRUE, options={"comment":"Name of the option category"})
	 * @var string
	 */
	protected $name;

	/**
	 * @ORM\Column(type="string", options={"comment":"Nice name of the option category"})
	 * @var string
	 */
	protected $fullName;

	public function __construct($name, $fullName)
	{
		$this->name = $name;
		$this->fullName = $fullName;
	}

}
