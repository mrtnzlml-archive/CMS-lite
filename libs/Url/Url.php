<?php

namespace Url;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 * @ORM\Table(name="urls", indexes={
 *      @ORM\Index(columns={"fake_path"})
 * })
 *
 * @method setFakePath(string $path)
 * @method string getFakePath()
 * @method setInternalId(integer $internalId)
 * @method integer getInternalId()
 * @method setRedirectTo(Url $url)
 *
 * @ORM\HasLifecycleCallbacks
 */
class Url
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="string", unique=TRUE, nullable=TRUE, options={"comment":"Fake path of the URL"})
	 * @var string
	 */
	protected $fakePath;

	/**
	 * @ORM\Column(type="string", nullable=TRUE, options={"comment":"Internal link presenter (Module:Presenter)"})
	 * @var string
	 */
	private $presenter = NULL;

	/**
	 * @ORM\Column(type="string", nullable=TRUE, options={"comment":"Internal link action"})
	 * @var string
	 */
	private $action = NULL;

	/**
	 * @ORM\Column(type="integer", nullable=TRUE, options={"comment":"Internal ID passed to the action (optional)"})
	 * @var int
	 */
	protected $internalId = NULL;

	/**
	 * @ORM\ManyToOne(targetEntity="Url", cascade={"persist"})
	 * @ORM\JoinColumn(referencedColumnName="id", onDelete="SET NULL")
	 * @var Url
	 */
	protected $redirectTo = NULL;

	public function getDestination()
	{
		return $this->presenter . ':' . $this->action;
	}

	/**
	 * @param string $presenter Destination if you leave action blank.
	 * @param NULL|string $action
	 */
	public function setDestination($presenter, $action = NULL)
	{
		if ($action === NULL) {
			$destination = $presenter;
		} else {
			$destination = $presenter . ':' . $action;
		}
		$pos = strrpos($destination, ':');
		$this->presenter = substr($destination, 0, $pos);
		$this->action = substr($destination, $pos + 1);
	}

	public function getAbsoluteDestination($withAsterisk = FALSE)
	{
		if (!isset($this->presenter) || !isset($this->action)) {
			return NULL;
		}
		return ':' . $this->presenter . ':' . ($withAsterisk ? '*' : $this->action);
	}

}
