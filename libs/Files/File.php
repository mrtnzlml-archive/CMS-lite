<?php

namespace Files;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;
use Users\User;

/**
 * @ORM\Entity
 * @ORM\Table(name="files")
 *
 * @method setName(string)
 * @method string getName()
 * @method setSanitizedName(string)
 * @method string getSanitizedName()
 * @method setTitle(string)
 * @method string getTitle()
 * @method setDescription(string)
 * @method string getDescription()
 * @method setUuid(string)
 * @method string getUuid()
 * @method setSize(int)
 * @method int getSize()
 * @method setType(string)
 * @method string getType()
 */
class File extends BaseEntity
{
    use Identifier;

    const TYPE_ATTACHMENT = 'ATTACHMENT';

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
     * @ORM\Column(type="integer")
     * @var string
     */
    protected $size;

    /**
     * @ORM\Column(type="string")
     * @var string
     */
    protected $type = self::TYPE_ATTACHMENT;

}
