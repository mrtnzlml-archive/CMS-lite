<?php

namespace Pages;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Files\File;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;
use Url;

/**
 * @ORM\Entity
 * @ORM\Table(name="page_categories")
 *
 * @method setName(string $name)
 * @method string getName()
 * @method setTextBefore(string $before)
 * @method string getTextBefore()
 * @method setTextAfter(string $after)
 * @method string getTextAfter()
 * @method boolean getVirtual()
 * @method setUrl(Url\Url $url)
 * @method Url\Url getUrl()
 * @method PageCategory[] getPageCategories()
 *
 * @method addFile(File $file)
 */
class Category
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="text", options={"comment":"Name of the page category"})
	 * @var string
	 */
	protected $name;

	/**
	 * @ORM\Column(type="text", nullable=TRUE)
	 * @var string
	 */
	protected $textBefore;

	/**
	 * @ORM\Column(type="text", nullable=TRUE)
	 * @var string
	 */
	protected $textAfter;

	/**
	 * @ORM\Column(type="boolean", name="`virtual`", nullable=FALSE, options={"default": 0})
	 * @var bool
	 */
	protected $virtual = FALSE;

	/**
	 * @ORM\OneToMany(targetEntity="PageCategory", mappedBy="category", cascade={"persist"}, orphanRemoval=TRUE)
	 * @var PageCategory[]|\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $pageCategories;

	/**
	 * @ORM\OneToOne(targetEntity="Url\Url", cascade={"persist"})
	 * @ORM\JoinColumn(name="url_id", referencedColumnName="id", onDelete="SET NULL")
	 * @var Url\Url
	 */
	protected $url;

	/**
	 * @ORM\ManyToMany(targetEntity="Files\File", cascade={"persist"})
	 * @ORM\JoinTable(
	 *      joinColumns={@ORM\JoinColumn(name="category_id", referencedColumnName="id", onDelete="CASCADE")},
	 *      inverseJoinColumns={@ORM\JoinColumn(name="file_id", referencedColumnName="id", onDelete="CASCADE")}
	 * )
	 * @var \Files\File[]\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $files;

	/**
	 * @ORM\Column(type="datetime", options={"comment":"Date of the page category creation"})
	 * @var \DateTime
	 */
	private $createdAt;

	public function __construct()
	{
		$this->pageCategories = new ArrayCollection();
		$this->createdAt = new \DateTime();
		$this->files = new ArrayCollection();
	}

	public function getCreatedAt()
	{
		return $this->createdAt;
	}

	public function setVirtual($virtual = TRUE)
	{
		$this->virtual = $virtual;
		return $this;
	}

	public function addPageCategory(PageCategory $category)
	{
		if (!$this->pageCategories->contains($category)) {
			$this->pageCategories->add($category);
			$category->setCategory($this);
		}
		return $this;
	}

}
