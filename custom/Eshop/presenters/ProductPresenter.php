<?php

namespace Eshop\Presenters;

use App\FrontModule\Presenters\BasePresenter;
use Eshop\Product;
use Eshop\Query\ProductQuery;
use Kdyby\Doctrine\EntityManager;
use Nette;

class ProductPresenter extends BasePresenter
{

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function renderDefault($id = NULL)
	{
		if ($id !== NULL) {
			$this->forward(':Eshop:Product:detail', $id);
		}
		$this->setTitle('Eshop');
		$query = new ProductQuery();
		$products = $this->em->getRepository(Product::class)->fetch($query);
		$this->template->products = $products;
	}

	public function renderDetail($id)
	{
		$product = $this->em->find(Product::class, $id);
		if (!$product) {
			$this->error('Product not found.');
		}
		$this->template->product = $product;
	}

}
