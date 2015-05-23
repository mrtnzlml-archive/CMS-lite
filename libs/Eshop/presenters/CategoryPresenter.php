<?php

namespace Eshop\Presenters;

use App\Presenters\BasePresenter;
use App\Traits\PublicComponentsTrait;
use Nette;

class CategoryPresenter extends BasePresenter
{

	//TODO: nějaký společný předek, který to vše pořeší

	use PublicComponentsTrait;

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
