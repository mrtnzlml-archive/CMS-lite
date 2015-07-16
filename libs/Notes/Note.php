<?php

namespace Notes;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;
use Users\User;

/**
 * @ORM\Entity
 *
 * @method setTitle(string $title)
 * @method setBody(string $body)
 * @method setAuthor(User $author)
 */
class Note extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\Column(type="string", options={"comment":"Title of the note"})
	 * @var string
	 */
	protected $title;

	/**
	 * @ORM\Column(type="text", options={"comment":"Full text of the note"})
	 * @var string
	 */
	protected $body;

	/**
	 * @ORM\ManyToOne(targetEntity="Users\User", cascade={"persist"})
	 * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
	 * @var \Users\User
	 */
	protected $author;

	/**
	 * @ORM\Column(type="datetime", options={"comment":"Date of the note creation"})
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

}
