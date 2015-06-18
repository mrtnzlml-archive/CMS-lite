<?php

namespace Eshop\Presenters;

use App\FrontModule\Presenters\BasePresenter;
use Eshop\Product;
use Eshop\Query\ProductQuery;
use Kdyby\Doctrine\EntityManager;
use Nette;

class ProductPresenter extends BasePresenter
{

	private $layout;

	/** @var EntityManager */
	private $em;

	public function __construct($layout, EntityManager $em)
	{
		$this->layout = $layout;
		$this->em = $em;
	}

	public function renderDefault($slug = NULL)
	{
		if ($slug !== NULL) {
			$this->forward(':Eshop:Product:detail', $slug);
		}
		$this->setTitle('Eshop');
		$query = new ProductQuery();
		$products = $this->em->getRepository(Product::class)->fetch($query);
		$this->template->products = $products;
	}

	public function renderDetail($slug)
	{
		$product = $this->em->getRepository(Product::class)->findOneBy(['slug' => $slug]);
		if (!$product) {
			$this->error('Product not found.');
		}
		$this->template->product = $product;
	}

	public function findLayoutTemplateFile()
	{
		return $this->layout;
	}

}
