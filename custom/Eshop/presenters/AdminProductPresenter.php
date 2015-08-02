<?php

namespace Eshop\Presenters;

use App\AdminModule\Presenters\BasePresenter;
use Eshop\Product;
use Eshop\Query\ProductQuery;
use Kdyby\Doctrine\EntityManager;

class AdminProductPresenter extends BasePresenter
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
