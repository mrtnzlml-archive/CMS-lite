<?php

namespace Users;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\MagicAccessors;

/**
 * @ORM\Entity
 *
 * @method boolean getAllow()
 * @method boolean getRead()
 * @method boolean getWrite()
 * @method boolean getCreate()
 * @method boolean getDelete()
 *
 * @method Role getRole()
 * @method Resource getResource()
 */
class Permission
{

	use Identifier;
	use MagicAccessors;

	/**
	 * @ORM\Column(type="boolean", name="`allow`", options={"comment":"It's allow rule or not?"})
	 * @var boolean
	 */
	protected $allow = TRUE;

	/**
	 * @ORM\Column(type="boolean", name="`read`")
	 * @var bool
	 */
	protected $read = FALSE;

	/**
	 * @ORM\Column(type="boolean", name="`write`")
	 * @var bool
	 */
	protected $write = FALSE;

	/**
	 * @ORM\Column(type="boolean", name="`create`")
	 * @var bool
	 */
	protected $create = FALSE;

	/**
	 * @ORM\Column(type="boolean", name="`delete`")
	 * @var bool
	 */
	protected $delete = FALSE;

	/**
	 * @ORM\ManyToOne(targetEntity="Role", cascade={"persist"})
	 * @ORM\JoinColumn(name="role_id", referencedColumnName="id")
	 * @var Role
	 */
	protected $role;

	/**
	 * @ORM\ManyToOne(targetEntity="Resource", cascade={"persist"})
	 * @ORM\JoinColumn(name="resource_id", referencedColumnName="id")
	 * @var Resource
	 */
	protected $resource;

	public function setAllow($allow = TRUE)
	{
		$this->allow = $allow;
		return $this;
	}

	public function setRead($read = TRUE)
	{
		$this->read = $read;
		return $this;
	}

	public function setWrite($write = TRUE)
	{
		$this->write = $write;
		return $this;
	}

	public function setCreate($create = TRUE)
	{
		$this->create = $create;
		return $this;
	}

	public function setDelete($delete = TRUE)
	{
		$this->delete = $delete;
		return $this;
	}

}
