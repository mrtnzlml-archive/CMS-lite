<?php

namespace App\Components\Doctype;

use Nette;

class Doctype extends Nette\Application\UI\Control
{

	const HTML4_TRANSITIONAL = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">';
	const HTML4_STRICT = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">';
	const HTML5 = '<!DOCTYPE html>';
	const XHTML1_TRANSITIONAL = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';
	const XHTML1_STRICT = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">';

	private $selected = self::HTML5;

	public function render()
	{
		$this->template->doctype = Nette\Utils\Html::el()->setHtml($this->selected);
		$this->template->render(__DIR__ . '/templates/Doctype.latte');
	}

	public function setDoctype($doctype)
	{
		if (!in_array($doctype, [
			self::HTML4_TRANSITIONAL,
			self::HTML4_STRICT,
			self::HTML5,
			self::XHTML1_TRANSITIONAL,
			self::XHTML1_STRICT,
		], TRUE)
		) {
			throw new Nette\InvalidArgumentException("Invalid doctype.");
		}
		$this->selected = $doctype;
	}

}

interface IDoctypeFactory
{
	/** @return Doctype */
	public function create();
}
