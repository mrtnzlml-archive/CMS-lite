<?php

namespace Options;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="options")
 *
 * @method setValue(string $value)
 * @method string getValue()
 */
class Option
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string", name="`key`", unique=TRUE, options={"comment":"Key of the option"})
	 * @var string
	 */
	protected $key;

	/**
	 * @ORM\Column(type="text", name="`value`", nullable=TRUE, options={"comment":"Selected value of the key"})
	 * @var string
	 */
	protected $value = NULL;

	public function __construct($key, $value)
	{
		$this->key = $key;
		$this->value = is_array($value) ? serialize($value) : $value;
	}

}
