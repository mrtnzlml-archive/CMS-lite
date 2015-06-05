<?php

namespace App\AdminModule\Presenters;

use Eshop\Product;
use Eshop\Query\ProductQuery;
use Kdyby\Doctrine\EntityManager;

class EshopPresenter extends BasePresenter
{

	/** @var EntityManager @inject */
	public $em;

	public function renderDefault()
	{
		$products = $this->em->getRepository(Product::class)->fetch(new ProductQuery);
		$this->template->products = $products;
	}

}
