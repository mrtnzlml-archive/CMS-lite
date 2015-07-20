<?php

namespace WebFontLoader\Components;

use App\Components\AControl;

/**
 * @see https://github.com/typekit/webfontloader
 *
 * @method addFont(string $font)
 */
class WebFontLoader extends AControl
{

	private $fonts = [];

	public function render(array $parameters = NULL)
	{
		if ($this->fonts) {
			$this->template->fonts = $this->fonts;
			$this->template->render(__DIR__ . '/WebFontLoader.latte');
		}
	}

}

interface IWebFontLoaderFactory
{
	/** @return WebFontLoader */
	function create();
}
