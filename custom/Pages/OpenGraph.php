<?php

namespace Pages;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 */
class OpenGraph
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string")
	 * @var string
	 */
	protected $property;

	/**
	 * @ORM\Column(type="text")
	 * @var string
	 */
	protected $content;

	public function __construct($property, $content)
	{
		$this->property = $property;
		$this->content = $content;
	}

}
