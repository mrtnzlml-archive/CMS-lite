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
	 * @ORM\Column(type="string", name="`value`", options={"comment":"Value of the option"})
	 * @var string
	 */
	protected $value;

	public function __construct($optionValue)
	{
		$this->value = $optionValue;
	}

}
