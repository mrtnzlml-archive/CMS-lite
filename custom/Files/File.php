<?php

namespace Files;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;
use Users\User;

/**
 * @ORM\Entity
 * @ORM\Table(name="files")
 *
 * @method setName(string $name)
 * @method string getName()
 * @method setFakeName(string $fakeName)
 * @method string getFakeName()
 * @method setDescription(string $description)
 * @method string getDescription()
 * @method setUuid(string $uuid)
 * @method string getUuid()
 * @method setExtension(string $extension)
 * @method string getExtension()
 * @method setSize(int $size)
 * @method int getSize()
 * @method User getAuthor()
 * @method setAuthor(User $author)
 */
class File
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string", options={"comment":"Original name of the file"})
	 * @var string
	 */
	protected $name;

	/**
	 * @ORM\Column(type="string", options={"comment":"Fake name of the file"})
	 * @var string
	 */
	protected $fakeName;

	/**
	 * @ORM\Column(type="text", nullable=TRUE)
	 * @var string
	 */
	protected $description;

	/**
	 * @ORM\Column(type="string", unique=TRUE, options={"comment":"UUID is used for storing files (unique filename)"})
	 * @var string
	 */
	protected $uuid;

	/**
	 * @ORM\Column(type="string", options={"comment":"Extension of the file"})
	 * @var string
	 */
	protected $extension;

	/**
	 * @ORM\Column(type="integer", options={"comment":"File size in bytes (B)"})
	 * @var string
	 */
	protected $size;

	/**
	 * @ORM\Column(type="boolean", options={"comment":"Is it picture file?"})
	 * @var bool
	 */
	protected $picture = FALSE;

	/**
	 * @ORM\ManyToOne(targetEntity="Users\User", cascade={"persist"})
	 * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
	 * @var \Users\User
	 */
	protected $author;

	/**
	 * @ORM\Column(type="datetime", options={"comment":"Date of the file first creation"}))
	 * @var \DateTime
	 */
	private $createdAt;

	public function __construct()
	{
		$this->createdAt = new \DateTime();
	}

	public function getCreatedAt()
	{
		return $this->createdAt;
	}

	public function setPicture($picture = TRUE)
	{
		$this->picture = $picture;
		return $this;
	}

}
