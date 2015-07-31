<?php

namespace Pages;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="page_categories")
 *
 * @method setName(string $name)
 * @method string getName()
 */
class PageCategory
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="text", options={"comment":"Name of the page category"})
	 * @var string
	 */
	protected $name;

	/**
	 * @ORM\Column(type="datetime", options={"comment":"Date of the page category creation"})
	 * @var \DateTime
	 */
	private $createdAt;

	public function __construct()
	{
		$this->createdAt = new \DateTime();
	}

	public function getCreatedAt()
	{
		return $this->createdAt;
	}

}
