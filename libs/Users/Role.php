<?php

namespace Users;

use Doctrine\ORM\Mapping as ORM;
use Kdyby\Doctrine\Entities\Attributes\Identifier;
use Kdyby\Doctrine\Entities\BaseEntity;
use Nette\Security\IRole;

/**
 * @ORM\Entity(readOnly=TRUE)
 * @ORM\Table(name="roles")
 *
 * @method setName(string)
 * @method string getName()
 * @method setParent(Role $parent)
 * @method Role getParent
 */
class Role extends BaseEntity implements IRole
{

	const GUEST = 'guest';
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
	 * @ORM\OneToOne(targetEntity="Role", cascade={"persist"}, orphanRemoval=FALSE)
	 * @ORM\JoinColumn(name="parent_id", referencedColumnName="id", onDelete="SET NULL")
	 * @var Role
	 */
	protected $parent;

	/**
	 * Returns a string identifier of the Role.
	 * @return string
	 */
	final public function getRoleId()
	{
		return $this->id;
	}

}
