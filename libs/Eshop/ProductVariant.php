<?php

namespace Eshop;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;

/**
 * @ORM\Entity
 * @ORM\Table(name="product_variants")
 *
 * @method setProduct()
 * @method setVariantName(string)
 * @method setSku(string)
 */
class ProductVariant extends BaseEntity
{

	use Identifier;

	/**
	 * @ORM\ManyToOne(targetEntity="Product", inversedBy="variants", cascade={"persist"})
	 * @ORM\JoinColumn(name="product_id", referencedColumnName="id")
	 * @var Product
	 */
	protected $product;

	/**
	 * @ORM\Column(type="string", options={"comment":"Name of the product variant (e.g. red-wool)."})
	 * @var string
	 */
	protected $variantName;

	/**
	 * @ORM\Column(type="string", unique=TRUE, options={"comment":"SKU – Stock Keeping Unit"})
	 * @var string
	 */
	protected $sku;

	/**
	 * @ORM\ManyToMany(targetEntity="VariantValue", cascade={"persist"})
	 * @ORM\JoinTable(
	 *        joinColumns={@ORM\JoinColumn(name="productVariant_id")},
	 *        inverseJoinColumns={@ORM\JoinColumn(name="variantValue")}
	 *    )
	 * @var VariantValue[]|\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $variantValues;

	//TODO: price

	public function __construct()
	{
		$this->variantValues = new ArrayCollection();
	}

}
