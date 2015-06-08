<?php

namespace Options;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 * @ORM\Table(name="options")
 *
 * @method setDescription(string)
 * @method string getDescription()
 * @method setCategory(OptionCategory $category)
 */
class Option extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\Column(type="string", name="`key`", unique=TRUE, options={"comment":"Key of the option"})
	 * @var string
	 */
	protected $key;

	/**
	 * @ORM\Column(type="text", name="`value`", options={"comment":"Value of the option"})
	 * @var string
	 */
	protected $value;

	/**
	 * @ORM\Column(type="string", options={"comment":"Description of the option (form label)"})
	 * @var string
	 */
	protected $description;

	/**
	 * @ORM\ManyToOne(targetEntity="OptionCategory", cascade={"persist"})
	 * @ORM\JoinColumn(name="category_id", referencedColumnName="id")
	 * @var OptionCategory
	 */
	protected $category;

	public function __construct($key, $value)
	{
		$this->key = $key;
		$this->value = $value;
	}

}
