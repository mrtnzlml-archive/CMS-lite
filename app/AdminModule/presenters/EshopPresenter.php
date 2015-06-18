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
		$query = (new ProductQuery)->withAllDeliveries();
		$products = $this->em->getRepository(Product::class)->fetch($query);
		$this->template->products = $products;
	}

}
