<?php

namespace App\Components\Meta;

use Nette;

class Meta extends Nette\Application\UI\Control
{

	private $metas = [
		'viewport' => 'width=device-width, initial-scale=1.0',
		'auhor' => 'vytvořili v www.antstudio.cz',
		'robots' => 'all',
	];

	private $httpEquivs = [];

	public function render()
	{
		if (!isset($this->metas['description'])) {
			throw new Nette\UnexpectedValueException('You should set up description meta tag.');
		}
		$this->template->metas = $this->metas;
		$this->template->httpEquivs = $this->httpEquivs;
		$this->template->render(__DIR__ . '/templates/Meta.latte');
	}

	public function setMeta($name, $content)
	{
		$this->metas[$name] = $content;
	}

	public function setMetas(array $metas)
	{
		//Order of this arrays is important!
		$this->metas = $metas + $this->metas;
	}

	public function setHttpEquiv($http_equiv, $content)
	{
		if (in_array(mb_strtolower($http_equiv), [
			'content-type', 'content-language'
		])) {
			throw new Nette\InvalidArgumentException(sprintf('You are not allowed to take care about %s meta tag. I\'ll do it for you.', $http_equiv));
		}
		$this->httpEquivs[$http_equiv] = $content;
	}

}

interface IMetaFactory
{
	/** @return Meta */
	public function create();
}
