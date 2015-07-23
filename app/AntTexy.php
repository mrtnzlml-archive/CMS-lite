<?php

namespace App;

use Nette;

class AntTexy extends \Texy
{

	public function process($text, $singleLine = FALSE)
	{
		$this->headingModule->generateID = TRUE;
		$output = parent::process($text, $singleLine);
		return Nette\Utils\Html::el()->setHtml($output);
	}

}
