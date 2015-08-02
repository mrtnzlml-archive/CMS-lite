<?php

namespace Pages;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 *
 * @method string getProperty()
 * @method string getContent()
 * @method setPage(Page $page)
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

	/**
	 * @ORM\ManyToOne(targetEntity="Page", inversedBy="openGraphs", cascade={"persist"})
	 * @ORM\JoinColumn(name="page_id", referencedColumnName="id")
	 * @var Page
	 */
	protected $page;

	public function __construct($property, $content)
	{
		$this->property = $property;
		$this->content = $content;
	}

}
