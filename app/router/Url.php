<?php

namespace App\Router;

use Doctrine\ORM\Mapping as ORM;
use Kdyby;

/**
 * @ORM\Entity
 * @ORM\Table(name="urls", indexes={
 *      @ORM\Index(columns={"fake_path"})
 * })
 *
 * @method setFakePath(string)
 * @method string getFakePath()
 * @method setDestination(string)
 * @method string getDestination()
 */
class Url extends Kdyby\Doctrine\Entities\BaseEntity
{

	use Kdyby\Doctrine\Entities\Attributes\Identifier;

	/**
	 * @ORM\Column(type="string", unique=TRUE, nullable=TRUE)
	 * @var string
	 */
	protected $fakePath;

	/**
	 * @ORM\Column(type="string")
	 * @var string
	 */
	protected $destination;

}
