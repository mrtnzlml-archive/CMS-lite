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

	const CACHE_NAMESPACE = 'ANT.Users';

	public function __construct(EntityManager $em, Nette\Caching\IStorage $cacheStorage)
	{
		$this->em = $em;
		$this->cache = new Nette\Caching\Cache($cacheStorage, self::CACHE_NAMESPACE);
		$this->acl = new Permission;

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
			$this->acl->addResource($resource->getName());
		}

		$this->acl->allow(Role::SUPERADMIN, Permission::ALL, Permission::ALL);
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
