<?php

namespace App\Extensions;

use Nette;
use Tracy;

class AntPanel extends Nette\Object implements Tracy\IBarPanel
{

	/**
	 * Renders tab.
	 * @return string
	 */
	public function getTab()
	{
		ob_start();
		require __DIR__ . '/templates/AntPanel.tab.phtml';
		return ob_get_clean();
	}

	/**
	 * Renders panel.
	 * @return string
	 */
	public function getPanel()
	{
		return NULL;
	}

}
