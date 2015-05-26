<?php

namespace Articles;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 * @ORM\Table(name="articles")
 *
 * @method setTitle(string)
 * @method string getTitle()
 * @method setSlug(string)
 * @method string getSlug()
 * @method setBody(string)
 * @method string getBody()
 * @method boolean getDeleted()
 */
class Article extends BaseEntity
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
	 * @ORM\Column(type="datetime", options={"comment":"Date of the article publication"})
	 * @var \DateTime
	 */
	private $publishedAt;

	/**
	 * @ORM\Column(type="boolean", nullable=FALSE, options={"default":"0"})
	 * @var boolean
	 */
	private $deleted = FALSE;

	/**
	 * @ORM\ManyToMany(targetEntity="Users\User", cascade={"persist"})
	 * @ORM\JoinTable(
	 *        joinColumns={@ORM\JoinColumn(name="article_id")},
	 *        inverseJoinColumns={@ORM\JoinColumn(name="role")}
	 * )
	 * @var \Users\User[]|ArrayCollection
	 */
	protected $authors;

	public function __construct()
	{
		$this->createdAt = new \DateTime();
		$this->publishedAt = new \DateTime();
		$this->authors = new ArrayCollection();
	}

	public function setDeleted($deleted = TRUE)
	{
		$this->deleted = $deleted;
	}

}
