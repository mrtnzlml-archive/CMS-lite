<?php

namespace Url;

use Nette;
use Tracy;

class AntPanel extends Nette\Object implements Tracy\IBarPanel
{

	/** @var Nette\Http\IRequest */
	private $httpRequest;

	/** @var Nette\Application\IRouter */
	private $router;

	/** @var Nette\Application\Request */
	private $appRequest;

	public function __construct(Nette\Http\IRequest $httpRequest, Nette\Application\IRouter $router)
	{
		$this->httpRequest = $httpRequest;
		$this->router = $router;

		$this->appRequest = $router->match($this->httpRequest);
	}

	/**
	 * Renders tab.
	 * @return string
	 */
	public function getTab()
	{
		ob_start();
		$request = $this->appRequest;
		require __DIR__ . '/templates/AntPanel.tab.phtml';
		return ob_get_clean();
	}

	/**
	 * Renders panel.
	 * @return string
	 */
	public function getPanel()
	{
		ob_start();
		$url = $this->httpRequest->getUrl();
		$request = Tracy\Dumper::toHtml($this->appRequest);
		require __DIR__ . '/templates/AntPanel.panel.phtml';
		return ob_get_clean();
	}

}
