<?php

namespace Dashboard;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="widgets_dashboard")
 *
 * TODO: zde ukládat všechny widgety na dashboardu a jejich pozici (např. pro drag'n'drop, skrývání nebo přidávání)
 */
class Widget
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="boolean", options={"comment":"Is widget draggable?"})
	 * @var bool
	 */
	protected $draggable = TRUE;

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
