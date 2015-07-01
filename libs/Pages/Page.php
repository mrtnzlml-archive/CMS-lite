<?php

namespace Pages;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;
use Users\User;

/**
 * @ORM\Entity
 * @ORM\Table(name="pages")
 * @ORM\InheritanceType("SINGLE_TABLE")
 * @ORM\DiscriminatorColumn(name="discriminator", type="string", length=10)
 * @ORM\DiscriminatorMap({
 *      "page" = "Page",
 *      "news" = "News"
 * })
 *
 * @method setTitle(string)
 * @method string getTitle()
 * @method setSlug(string)
 * @method string getSlug()
 * @method setBody(string)
 * @method string getBody()
 * @method boolean getDeleted()
 *
 * @method addAuthor(User $author)
 * @method addCategory(PageCategory $category)
 *
 * //remove<name>($entity)
 * //has<name>($entity)
 *
 * //get<name>($entity)
 *
 * @method setRealAuthor(User $realAuthor)
 *
 *
 */
class Page extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\Column(type="text", options={"comment":"Title of the article"})
	 * @var string
	 */
	protected $title;

	/**
	 * @ORM\Column(type="text", options={"comment":"Webalized title (slug) of the article"})
	 * @var string
	 */
	protected $slug;

	/**
	 * @ORM\Column(type="text", options={"comment":"Body of the article"})
	 * @var string
	 */
	protected $body;

	/**
	 * @ORM\Column(type="datetime", options={"comment":"Date of the article creation"})
	 * @var \DateTime
	 */
	private $createdAt;

	/**
	 * @ORM\Column(type="datetime", nullable=TRUE, options={"comment":"Date of the article publication"})
	 * @var \DateTime
	 */
	protected $publishedAt;

	/**
	 * @ORM\Column(type="boolean", nullable=FALSE, options={"default":"0"})
	 * @var boolean
	 */
	private $deleted = FALSE;

	/**
	 * @ORM\ManyToMany(targetEntity="Users\User", cascade={"persist"})
	 * @ORM\JoinTable(
	 *        joinColumns={@ORM\JoinColumn(name="page_id")},
	 *        inverseJoinColumns={@ORM\JoinColumn(name="author")}
	 * )
	 * @var \Users\User[]|ArrayCollection
	 */
	protected $authors;

	/**
	 * @ORM\ManyToOne(targetEntity="Users\User", cascade={"persist"})
	 * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
	 * @var \Users\User
	 */
	protected $realAuthor;

	/**
	 * @ORM\ManyToMany(targetEntity="Pages\PageCategory", cascade={"persist"})
	 * @ORM\JoinTable(
	 *        joinColumns={@ORM\JoinColumn(name="page_id")},
	 *        inverseJoinColumns={@ORM\JoinColumn(name="category")}
	 * )
	 * @var \Pages\PageCategory[]|ArrayCollection
	 */
	protected $categories;

	public function __construct()
	{
		$this->createdAt = new \DateTime();
		$this->authors = new ArrayCollection();
		$this->categories = new ArrayCollection();
	}

	public function setDeleted($deleted = TRUE)
	{
		$this->deleted = $deleted;
	}

	/**
	 * @return bool
	 */
	public function isPublished()
	{
		return $this->publishedAt ? TRUE : FALSE;
	}

	public function getAuthorsIds()
	{
		$authorIds = [];
		foreach ($this->authors as $author) {
			$authorIds[] = $author->id;
		}
		return $authorIds;
	}

	public function getCategoriesIds()
	{
		$categoriesIds = [];
		foreach ($this->categories as $category) {
			$categoriesIds[] = $category->id;
		}
		return $categoriesIds;
	}

	public function clearAuthors()
	{
		$this->authors->clear();
	}

	public function clearCategories()
	{
		$this->categories->clear();
	}

}
