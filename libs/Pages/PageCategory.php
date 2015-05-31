<?php

namespace Pages;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 * @ORM\Table(name="page_categories")
 *
 * @method setName(string)
 */
class PageCategory extends BaseEntity
{

	use Identifier;

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

}
