<?php

namespace Eshop;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 * @ORM\Table(name="deliveries")
 *
 * @method setDeliveryId(string)
 * @method string getDeliveryId()
 * @method setName(string)
 * @method setDeliveryPrice(float)
 * @method float getDeliveryPrice()
 * @method setHeureka(boolean)
 */
class Delivery extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\Column(type="string", unique=TRUE, options={"comment":"Identifier of the delivery"})
	 * @var string
	 */
	protected $deliveryId;

	/**
	 * @ORM\Column(type="string", options={"comment":"Human readable name of the delivery"})
	 * @var string
	 */
	protected $name;

	/**
	 * @ORM\Column(type="decimal", scale=2, options={"comment":"Delivery price including VAT!"})
	 * @var float
	 */
	protected $deliveryPrice;

	/**
	 * @ORM\Column(type="boolean", options={"comment":"Heureka acceptable?"})
	 * @var boolean
	 */
	protected $heureka = FALSE;

}
