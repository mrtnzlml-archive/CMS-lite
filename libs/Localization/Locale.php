<?php

namespace Localization;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 *
 * @method setCode(string $code)
 * @method string getCode()
 * @method setName(string $name)
 */
class Locale
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string", options={"comment":"Code of the language"})
	 * @var string
	 */
	protected $code;

	/**
	 * @ORM\Column(type="string", options={"comment":"Name of the language"})
	 * @var string
	 */
	protected $name;

	/**
	 * @ORM\Column(type="boolean", name="`default`")
	 * @var bool
	 */
	protected $default = FALSE;

	public function setDefault()
	{
		$this->default = TRUE;
		return $this;
	}

}
