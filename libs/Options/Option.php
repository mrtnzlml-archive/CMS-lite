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
	 * @ORM\OneToMany(targetEntity="OptionValue", mappedBy="option", cascade={"persist"})
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

	public function addValue(OptionValue $value)
	{
		$value->option = $this;
		$this->values->add($value);
	}

	/**
	 * FIXME: Toto je fakt ošklivé (ale funkční)...
	 *
	 * @param $value
	 */
	public function setDefaultValue($value)
	{
		if (is_bool($value)) { //checkbox
			foreach ($this->values as $val) {
				$val->value = $value ? 1 : 0;
				$val->selected = 1;
			}
		} elseif (is_int($value)) { //select
			foreach ($this->values as $val) {
				if ($val->getId() === $value) {
					$val->selected = TRUE;
				} else {
					$val->selected = FALSE;
				}
			}
		} else { //input
			foreach ($this->values as $val) {
				$val->value = $value;
				$val->selected = 1;
			}
		}
	}

	public function getValue()
	{
		if (count($this->values) === 1) {
			return $this->values[0];
		}
		return $this->values;
	}

}
