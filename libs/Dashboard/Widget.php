<?php

namespace Dashboard;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="widget_dashboard")
 */
class Widget
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="datetime", options={"comment":"Date when this error occurs"})
	 * @var \DateTime
	 */
	private $createdAt;

	public function __construct()
	{
		$this->createdAt = new \DateTime;
	}

	public function getCreatedAt()
	{
		return $this->createdAt;
	}

}
