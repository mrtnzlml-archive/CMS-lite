<?php

namespace Users;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;
use Nette\Security\IRole;

/**
 * @ORM\Entity(readOnly=TRUE)
 */
class Role extends BaseEntity implements IRole
{

	const USER = 'user';
	const ADMIN = 'admin';
	const SUPERADMIN = 'superadmin';

	use Identifier;

	/**
	 * @ORM\ManyToMany(targetEntity="Role", cascade={"persist"})
	 * @ORM\JoinTable(
	 *        joinColumns={@ORM\JoinColumn(name="role")},
	 *        inverseJoinColumns={@ORM\JoinColumn(name="inherit")}
	 * )
	 * @var Role[]|\Doctrine\Common\Collections\ArrayCollection
	 */
	protected $inherits;

	/**
	 * Returns a string identifier of the Role.
	 * @return string
	 */
	final public function getRoleId()
	{
		return $this->id;
	}

}
