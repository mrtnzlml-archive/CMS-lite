<?php

namespace Pages;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;
use Localization\ILocaleAware;
use Nette\Security\Passwords;
use Users\User;

/**
 * @ORM\Entity
 * @ORM\Table(name="pages")
 *
 * @method setTitle(string $title)
 * @method string getTitle()
 * @method setBody(string $body)
 * @method string getBody()
 * @method boolean getDeleted()
 * @method setIndividualTitle(string $title)
 * @method string getIndividualTitle()
 * @method setDescription(string $description)
 * @method string getDescription()
 * @method setIndex(string $index)
 * @method string getIndex()
 * @method setFollow(string $follow)
 * @method string getFollow()
 * @method setUrl(\Url\Url $url)
 * @method \Url\Url getUrl()
 * @method boolean getProtected()
 *
 * @method addAuthor(User $author)
 * @method addCategory(PageCategory $category)
 * @method addTag(Tag $tag)
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
class Page extends BaseEntity implements ILocaleAware
{

	use Identifier;

	/**
	 * @ORM\Column(type="text", options={"comment":"Title of the article"})
	 * @var string
	 */
	protected $title;

	/**
	 * @ORM\Column(type="text", nullable=TRUE, options={"comment":"Meta title of the article"})
	 * @var string
	 */
	protected $individualTitle = NULL;

	/**
	 * @ORM\Column(type="text", nullable=TRUE, options={"comment":"Meta description of the article"})
	 * @var string
	 */
	protected $description = NULL;

	/**
	 * @ORM\Column(type="text", options={"comment":"Body of the article"})
	 * @var string
	 */
	protected $body;

	/**
	 * @ORM\Column(type="string", name="`index`", nullable=TRUE, options={"comment":"Meta robots - index value"})
	 * @var string
	 */
	protected $index = NULL;

	/**
	 * @ORM\Column(type="string", nullable=TRUE, options={"comment":"Meta robots - follow value"})
	 * @var string
	 */
	protected $follow = NULL;

	/**
	 * @ORM\Column(type="datetime", options={"comment":"Date of the article creation"})
	 * @var \DateTime
	 */
	private $createdAt;

	/**
	 * @ORM\Column(type="datetime", nullable=TRUE, options={"comment":"Date of the article publication"})
	 * @var \DateTime
	 */
	protected $publishedAt = NULL;

	/**
	 * @ORM\Column(type="string", nullable=TRUE, options={"comment":"Individual CSS IDs in body element"})
	 * @var string
	 */
	protected $individualCssId = NULL;

	/**
	 * @ORM\Column(type="string", nullable=TRUE, options={"comment":"Individual CSS classes in body element"})
	 * @var string
	 */
	protected $individualCssClass = NULL;

	/**
	 * @ORM\Column(type="boolean", options={"comment":"Is this page protected by password?"})
	 * @var bool
	 */
	protected $protected = FALSE;

	/**
	 * @ORM\Column(type="string", nullable=TRUE)
	 * @var string
	 */
	protected $password;

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

	/**
	 * @ORM\ManyToMany(targetEntity="Pages\Tag", cascade={"persist"})
	 * @ORM\JoinTable(
	 *        joinColumns={@ORM\JoinColumn(name="page_id", referencedColumnName="id")},
	 *        inverseJoinColumns={@ORM\JoinColumn(name="tag_id", referencedColumnName="id")}
	 *    )
	 * @var \Pages\Tag[]|\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $tags;

	/**
	 * @ORM\OneToOne(targetEntity="Url\Url", cascade={"persist"})
	 * @ORM\JoinColumn(name="url_id", referencedColumnName="id", onDelete="SET NULL")
	 * @var \Url\Url
	 */
	protected $url;

	/**
	 * @ORM\ManyToOne(targetEntity="Localization\Locale", cascade={"persist"})
	 * @ORM\JoinColumn(name="locale_id", referencedColumnName="id")
	 * @var \Localization\Locale
	 */
	protected $locale;

	public function __construct()
	{
		$this->createdAt = new \DateTime();
		$this->authors = new ArrayCollection();
		$this->categories = new ArrayCollection();
		$this->tags = new ArrayCollection();
	}

	public function setDeleted($deleted = TRUE)
	{
		$this->deleted = $deleted;
		return $this;
	}

	public function setProtected($password, $protected = TRUE)
	{
		if ($password != NULL) { // intentionally !=
			$this->password = Passwords::hash($password);
		}
		$this->protected = $protected;
		return $this;
	}

	/**
	 * @return bool
	 */
	public function isPublished()
	{
		return $this->publishedAt ? TRUE : FALSE;
	}

	public function setIndividualCss($styles)
	{
		$classes = [];
		$this->individualCssId = '';
		preg_match_all('~([#.]?)([a-z][a-z0-9_-]*)~', $styles, $matches, PREG_SET_ORDER);
		foreach ($matches as $m) {
			if ($m[1] === '#') { // #ID
				$this->individualCssId = $m[2];
			} else { // .class
				$classes[] = $m[2];
			}
		}
		$this->individualCssClass = implode(' ', $classes);
		return TRUE;
	}

	public function getIndividualCss()
	{
		$output = $this->individualCssId ? '#' . $this->individualCssId : '';
		foreach (array_filter(explode(' ', $this->individualCssClass)) as $class) {
			$output .= ' .' . $class;
		}
		return $output;
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

	public function getTagsString()
	{
		return implode(',', array_map(function ($tag) {
			return $tag->name;
		}, $this->tags->toArray()));
	}

	public function clearAuthors()
	{
		$this->authors->clear();
	}

	public function clearCategories()
	{
		$this->categories->clear();
	}

	public function clearTags()
	{
		$this->tags->clear();
	}

}
