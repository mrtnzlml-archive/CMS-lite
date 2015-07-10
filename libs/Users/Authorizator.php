<?php

namespace Users;

use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Security\Permission;

class Authorizator implements Nette\Security\IAuthorizator
{

	const READ = 'read';

	/** @var EntityManager */
	private $em;

	/** @var Nette\Caching\Cache */
	private $cache;

	/** @var Permission */
	private $acl;

	public function __construct(EntityManager $em, Nette\Caching\IStorage $cacheStorage)
	{
		if (PHP_SAPI === 'cli') {
			// It's blocking Kdyby\Console...
			return;
		}

		$this->em = $em;
		$this->cache = new Nette\Caching\Cache($cacheStorage, 'ANT.' . __NAMESPACE__);
		$acl = new Permission;

		//FIXME: invalidovat při uložení v administraci
		$roles = $this->cache->load('roles', function (& $dependencies) {
			return $this->em->getRepository(Role::class)->findAll();
		});
		/** @var Role $role */
		foreach ($roles as $role) {
			$acl->addRole($role->getName(), $role->getParent() ? $role->getParent()->getName() : NULL);
		}

		$resources = $this->cache->load('resources', function (& $dependencies) {
			return $this->em->getRepository(Resource::class)->findAll();
		});
		/** @var Resource $resource */
		foreach ($resources as $resource) {
			$acl->addResource($resource->getName());
		}

		$acl->allow(Role::SUPERADMIN, Permission::ALL, Permission::ALL);
		$this->acl = $acl;
	}

	/**
	 * Performs a role-based authorization.
	 *
	 * @param string role
	 * @param string resource
	 * @param string privilege
	 *
	 * @return bool
	 */
	public function isAllowed($role, $resource, $privilege)
	{
		try {
			return $this->acl->isAllowed($role, $resource, $privilege);
		} catch (Nette\InvalidStateException $exc) {
			// Role / Resource does not exist
			return FALSE;
		}
	}

}
