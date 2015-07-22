<?php

namespace Files;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="files")
 *
 * @method setName(string $name)
 * @method string getName()
 * @method setSanitizedName(string $sanitizedName)
 * @method string getSanitizedName()
 * @method setTitle(string $title)
 * @method string getTitle()
 * @method setDescription(string)
 * @method string getDescription()
 * @method setUuid(string $uuid)
 * @method string getUuid()
 * @method setExtension(string)
 * @method string getExtension()
 * @method setSize(int $size)
 * @method int getSize()
 * @method setType(string $type)
 * @method string getType()
 * @method User getAuthor()
 * @method setAuthor(User $author)
 */
class File
{

    use Identifier;
    use MagicAccessors;

    const TYPE_ATTACHMENT = 'ATTACHMENT';

    public function __construct()
    {
        $this->createdAt = new \DateTime();
    }

    /**
     * @ORM\Column(type="string")
     * @var string
     */
    protected $name;

    /**
     * @ORM\Column(type="string")
     * @var string
     */
    protected $sanitizedName;

    /**
     * @ORM\Column(type="string", nullable=TRUE)
     * @var string
     */
    protected $title;

    /**
     * @ORM\Column(type="text", nullable=TRUE)
     * @var string
     */
    protected $description;

    /**
     * @ORM\Column(type="string")
     * @var string
     */
    protected $uuid;

    /**
     * @ORM\Column(type="string")
     * @var string
     */
    protected $extension;

    /**
     * @ORM\Column(type="integer")
     * @var string
     */
    protected $size;

    /**
     * @ORM\Column(type="datetime")
     * @var \DateTime
     */
    private $createdAt;

    /**
     * @ORM\Column(type="string")
     * @var string
     */
    protected $type = self::TYPE_ATTACHMENT;

    /**
     * @ORM\ManyToOne(targetEntity="Users\User", cascade={"persist"})
     * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
     * @var \Users\User
     */
    protected $author;

    public function getCreatedAt()
    {
        return $this->createdAt;
    }

}
