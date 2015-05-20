<?php

namespace Users;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;
use Nette\Security\IRole;

/**
 * @ORM\Entity(readOnly=TRUE)
 * @ORM\Table(name="roles")
 *
 * @method setName(string)
 */
class Role extends BaseEntity implements IRole
{

	const USER = 'user';
	const ADMIN = 'admin';
	const SUPERADMIN = 'superadmin';

	use Identifier;

	/**
	 * @ORM\Column(type="string", options={"comment":"Identifier of the role"})
	 * @var string
	 */
	protected $name;

	/**
	 * @ORM\ManyToMany(targetEntity="Role", cascade={"persist"})
	 * @ORM\JoinTable(
	 *        joinColumns={@ORM\JoinColumn(name="role")},
	 *        inverseJoinColumns={@ORM\JoinColumn(name="inherit")}
	 * )
	 * @var Role[]|\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $inherits;

	public function __construct()
	{
		$this->inherits = new ArrayCollection();
	}

	/**
	 * Returns a string identifier of the Role.
	 * @return string
	 */
	final public function getRoleId()
	{
		return $this->id;
	}

}
