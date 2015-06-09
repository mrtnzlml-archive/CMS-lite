<?php

namespace Eshop\Presenters;

use App\FrontModule\Presenters\BasePresenter;
use App\Traits\PublicComponentsTrait;
use Eshop\Product;
use Eshop\Query\ProductQuery;
use Kdyby\Doctrine\EntityManager;
use Nette;

class ProductPresenter extends BasePresenter
{

	//TODO: nějaký společný předek, který to vše pořeší

	use PublicComponentsTrait;

	/** @var EntityManager @inject */
	public $em;

	public function renderDefault()
	{
		$query = new ProductQuery();
		$products = $this->em->getRepository(Product::class)->fetch($query);
		$this->template->products = $products;
	}

	public function formatLayoutTemplateFiles()
	{
		$name = $this->getName();
		$presenter = substr($name, strrpos(':' . $name, ':'));
		$layout = $this->layout ? $this->layout : 'layout';
		$dir = dirname(APP_DIR . '/presenters/templates');
		$dir = is_dir("$dir/templates") ? $dir : dirname($dir);
		$list = [
			"$dir/templates/$presenter/@$layout.latte",
			"$dir/templates/$presenter.@$layout.latte",
		];
		do {
			$list[] = "$dir/templates/@$layout.latte";
			$dir = dirname($dir);
		} while ($dir && ($name = substr($name, 0, strrpos($name, ':'))));
		return $list;
	}

}
