<?php

namespace App\Extensions;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 *
 * @method setName(string $name)
 * @method string getName()
 * @method setDescription(string $description)
 * @method boolean getTemplate()
 */
class Extension
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string")
	 * @var string
	 */
	protected $name;

	/**
	 * @ORM\Column(type="boolean")
	 * @var boolean
	 */
	protected $template = FALSE;

	/**
	 * @ORM\Column(type="text", nullable=TRUE)
	 * @var string
	 */
	protected $description = NULL;

	public function setTemplate($template = TRUE)
	{
		$this->template = $template;
		return $this;
	}

}
