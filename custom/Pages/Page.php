<?php

namespace Pages;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Files\File;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;
use Localization\ILocaleAware;
use Nette\Security\Passwords;
use Users\User;

/**
 * @ORM\Entity
 * @ORM\Table(
 *      name="pages",
 *      indexes={
 *          @ORM\Index(columns={"title"}, flags={"fulltext"}),
 *          @ORM\Index(columns={"body"}, flags={"fulltext"}),
 *          @ORM\Index(columns={"title", "body"}, flags={"fulltext"})
 *      }
 * )
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
 * @method string getPassword()
 * @method setRealAuthor(User $realAuthor)
 * @method setPublishedAt(\DateTime $publishedAt)
 *
 * @method addFile(File $file)
 */
class Page implements ILocaleAware
{

	use Identifier;
	use MagicAccessors;

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
	 * @ORM\OneToMany(targetEntity="PageCategory", mappedBy="page", cascade={"persist"}, orphanRemoval=TRUE)
	 * @var PageCategory[]|\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $pageCategories;

	/**
	 * @ORM\ManyToMany(targetEntity="Pages\Tag", inversedBy="pages", cascade={"persist"})
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

	/**
	 * @ORM\ManyToMany(targetEntity="Files\File", cascade={"persist"})
	 * @ORM\JoinTable(
	 *      joinColumns={@ORM\JoinColumn(name="page_id", referencedColumnName="id", onDelete="CASCADE")},
	 *      inverseJoinColumns={@ORM\JoinColumn(name="file_id", referencedColumnName="id", onDelete="CASCADE")}
	 * )
	 * @var \Files\File[]\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $files;

	/**
	 * @ORM\OneToMany(targetEntity="OpenGraph", mappedBy="page", cascade={"persist", "remove"})
	 * @var OpenGraph[]|\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $openGraphs;

	public function __construct()
	{
		$this->createdAt = new \DateTime();
		$this->authors = new ArrayCollection();
		$this->pageCategories = new ArrayCollection();
		$this->tags = new ArrayCollection();
		$this->files = new ArrayCollection();
		$this->openGraphs = new ArrayCollection();
	}

	public function getCreatedAt()
	{
		return $this->createdAt;
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

	///// CATEGORIES /////

	public function addPageCategory(PageCategory $category)
	{
		if (!$this->pageCategories->contains($category)) {
			$this->pageCategories->add($category);
			$category->setPage($this);
		}
		return $this;
	}

	public function getCategories()
	{
		return array_map(
			function ($pageCategory) {
				return $pageCategory->category;
			},
			$this->pageCategories->toArray()
		);
	}

	public function getCategoryIds()
	{
		$categoriesIds = [];
		/** @var PageCategory $category */
		foreach ($this->getCategories() as $category) {
			$categoriesIds[] = $category->getId();
		}
		return $categoriesIds;
	}

	public function clearCategories()
	{
		foreach ($this->pageCategories as $pageCategory) {
			$this->pageCategories->removeElement($pageCategory);
			$pageCategory->setPage(NULL);
		}
		return $this;
	}

	public function removePageCategory(PageCategory $pageCategory)
	{
		$this->pageCategories->removeElement($pageCategory);
		$pageCategory->setPage(NULL);
		return $this;
	}

	///// AUTHORS /////

	public function getAuthorIds()
	{
		$authorIds = [];
		foreach ($this->authors as $author) {
			$authorIds[] = $author->id;
		}
		return $authorIds;
	}

	public function setAuthor(User $author)
	{
		if (!$this->authors->contains($author)) {
			$this->authors->add($author);
		}
	}

	public function removeAuthor(User $author)
	{
		$this->authors->removeElement($author);
	}

	public function clearAuthors()
	{
		$this->authors->clear();
	}

	///// TAGS /////

	public function getTagsString()
	{
		return implode(',', array_map(function ($tag) {
			return $tag->name;
		}, $this->tags->toArray()));
	}

	public function addTag(Tag $tag)
	{
		if (!$this->tags->contains($tag)) {
			$tag->addPage($this);
			$this->tags[] = $tag;
		}
	}

	public function removeTag(Tag $tag)
	{
		$tag->removePage($this);
		$this->tags->removeElement($tag);
	}

	///// FILES ////

	public function clearFiles()
	{
		$this->files->clear();
	}

	///// OPEN GRAPH /////

	public function setOpenGraph(OpenGraph $og)
	{
		$og->setPage($this);
		$this->openGraphs->add($og);
	}

	public function getOpenGraphContent($property)
	{
		$ogs = $this->getOpenGraphs();
		return isset($ogs[$property]) ? $ogs[$property]->getContent() : NULL;
	}

	/**
	 * @return array of [property => content]
	 */
	public function getOpenGraphs()
	{
		$ogs = [];
		/** @var OpenGraph $og */
		foreach ($this->openGraphs as $og) {
			$ogs[$og->getProperty()] = $og;
		}
		return $ogs;
	}

}
