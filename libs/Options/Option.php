<?php

namespace Options;

use Doctrine\Common\Collections\ArrayCollection;
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
	 * @ORM\Column(type="string", options={"comment":"Description of the option (form label)"})
	 * @var string
	 */
	protected $description;

	/**
	 * //FIXME: klasiku MTM?
	 * @ORM\ManyToMany(targetEntity="OptionValue", cascade={"persist"})
	 * @ORM\JoinTable(name="options_optionvalues",
	 *      joinColumns={@ORM\JoinColumn(name="option_id", referencedColumnName="id")},
	 *      inverseJoinColumns={@ORM\JoinColumn(name="optionvalue_id", referencedColumnName="id", unique=TRUE)}
	 * )
	 * @var OptionValue[]|\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $values;

	/**
	 * @ORM\ManyToOne(targetEntity="OptionCategory", cascade={"persist"})
	 * @ORM\JoinColumn(name="category_id", referencedColumnName="id")
	 * @var OptionCategory
	 */
	protected $category;

	public function __construct($key, $value)
	{
		$this->key = $key;
		$this->values = new ArrayCollection;
		if (is_array($value)) {
			foreach ($value as $v) {
				$this->addValue(new OptionValue($v));
			}
		} else {
			$this->addValue(new OptionValue($value));
		}
	}

	public function getValue()
	{
		if (count($this->values) === 1) {
			return $this->values[0]->value;
		}
		return $this->values;
	}

}
