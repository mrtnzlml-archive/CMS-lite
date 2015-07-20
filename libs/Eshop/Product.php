<?php

namespace Eshop;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="products")
 *
 * @method setTitle(string)
 * @method string getTitle()
 * @method setSlug(string)
 * @method setDescription(string)
 * @method string getDescription()
 * @method Delivery[] getDeliveries()
 * @method ProductVariant[] getVariants()
 */
class Product
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="text", options={"comment":"Title of the product"})
	 * @var string
	 */
	protected $title;

	/**
	 * @ORM\Column(type="text", options={"comment":"Webalized title (slug) of the product"})
	 * @var string
	 */
	protected $slug;

	/**
	 * @ORM\Column(type="text", options={"comment":"Long description of the product"})
	 * @var string
	 */
	protected $description;

	/**
	 * @ORM\ManyToMany(targetEntity="Delivery", cascade={"persist"})
	 * @ORM\JoinTable(
	 *        joinColumns={@ORM\JoinColumn(name="product_id")},
	 *        inverseJoinColumns={@ORM\JoinColumn(name="delivery")}
	 *    )
	 * @var Delivery[]|ArrayCollection
	 */
	protected $deliveries;

	/**
	 * @ORM\OneToMany(targetEntity="ProductVariant", mappedBy="product")
	 */
	protected $variants;

	public function __construct()
	{
		$this->deliveries = new ArrayCollection();
	}

}
