<?php

namespace Options;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * Položka v nastavení může mít více hodnot, v tom případě se jedná o <select>.
 * Pokud je hodnota jen jedna a je možné ji prohlásit za boolean, pak se vykresluje jako checkbox.
 *
 * @ORM\Entity
 */
class OptionValue extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\ManyToOne(targetEntity="Option", inversedBy="values", cascade={"persist"})
	 * @ORM\JoinColumn(name="option_id", referencedColumnName="id")
	 * @var Option
	 */
	protected $option;

	/**
	 * @ORM\Column(type="string", name="`value`", nullable=TRUE, options={"comment":"Value of the option"})
	 * @var string
	 */
	protected $value;

	/**
	 * @ORM\Column(type="boolean", options={"comment":"Should be this value used as selected?"})
	 * @var boolean
	 */
	protected $selected = FALSE;

	public function __construct($optionValue)
	{
		$this->value = $optionValue;
	}

}
