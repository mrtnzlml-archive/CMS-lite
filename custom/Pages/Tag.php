<?php

namespace Pages;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 *
 * @method setName(string $name)
 * @method string getName()
 *
 * @method ArrayCollection getPages()
 */
class Tag
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string", unique=TRUE)
	 * @var string
	 */
	protected $name;

	/**
	 * @ORM\ManyToMany(targetEntity="Page", mappedBy="tags", cascade={"persist"})
	 * @ORM\JoinTable(
	 *        joinColumns={@ORM\JoinColumn(name="page_id", referencedColumnName="id")},
	 *        inverseJoinColumns={@ORM\JoinColumn(name="tag_id", referencedColumnName="id")}
	 *    )
	 * @var Page[]|\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $pages;

	public function __construct()
	{
		$this->pages = new ArrayCollection;
	}

	public function addPage(Page $page)
	{
		$this->pages[] = $page;
	}

	public function removePage(Page $page)
	{
		$this->pages->removeElement($page);
	}

}
