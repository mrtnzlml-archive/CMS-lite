<?php

namespace Users;

use Kdyby\Doctrine\EntityManager;
use Nette;

class Authorizator implements Nette\Security\IAuthorizator
{

	const READ = 'read';
	const WRITE = 'write';
	const CREATE = 'create';
	const DELETE = 'delete';

	/** @var EntityManager */
	private $em;

	/** @var Nette\Caching\Cache */
	private $cache;

	/** @var Nette\Security\Permission */
	private $acl;

	const CACHE_NAMESPACE = 'ANT.Users';

	public function __construct(EntityManager $em, Nette\Caching\IStorage $cacheStorage)
	{
		$this->em = $em;
		$this->cache = new Nette\Caching\Cache($cacheStorage, self::CACHE_NAMESPACE);
		$this->acl = new Nette\Security\Permission;

		if (PHP_SAPI === 'cli') {
			// FIXME: It's blocking Kdyby\Console...
			return;
		}

		$roles = $this->cache->load('roles', function (& $dependencies) {
			$dependencies = [Nette\Caching\Cache::TAGS => [self::CACHE_NAMESPACE . '/roles']];
			return $this->em->getRepository(Role::class)->findAll();
		});
		/** @var Role $role */
		foreach ($roles as $role) {
			$this->acl->addRole($role->getName(), $role->getParent() ? $role->getParent()->getName() : NULL);
		}

		$resources = $this->cache->load('resources', function (& $dependencies) {
			$dependencies = [Nette\Caching\Cache::TAGS => [self::CACHE_NAMESPACE . '/resources']];
			return $this->em->getRepository(Resource::class)->findAll();
		});
		/** @var Resource $resource */
		foreach ($resources as $resource) {
			$this->acl->addResource($resource->getResource());
		}

		$permissions = $this->cache->load('permissions', function (& $dependencies) {
			$dependencies = [Nette\Caching\Cache::TAGS => [self::CACHE_NAMESPACE . '/permissions']];
			return $this->em->getRepository(\Users\Permission::class)->findAll();
		});
		/** @var \Users\Permission $permission */
		foreach ($permissions as $permission) {
			$method = $permission->getAllow() ? 'allow' : 'deny';
			if ($permission->getRead()) {
				$this->acl->$method($permission->getRole()->getName(), $permission->getResource()->getResource(), self::READ);
			}
			if ($permission->getWrite()) {
				$this->acl->$method($permission->getRole()->getName(), $permission->getResource()->getResource(), self::WRITE);
			}
			if ($permission->getCreate()) {
				$this->acl->$method($permission->getRole()->getName(), $permission->getResource()->getResource(), self::CREATE);
			}
			if ($permission->getDelete()) {
				$this->acl->$method($permission->getRole()->getName(), $permission->getResource()->getResource(), self::DELETE);
			}
		}
		$this->acl->allow(Role::SUPERADMIN, Nette\Security\Permission::ALL, Nette\Security\Permission::ALL);
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
