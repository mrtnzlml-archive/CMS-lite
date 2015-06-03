<?php

namespace Users;

use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Security\AuthenticationException;
use Nette\Security\Passwords;

class Manager extends Nette\Object implements Nette\Security\IAuthenticator
{

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	/**
	 * Performs an authentication against database. and returns IIdentity on success or throws AuthenticationException
	 *
	 * @param array $credentials
	 *
	 * @return Nette\Security\Identity
	 * @throws AuthenticationException
	 */
	function authenticate(array $credentials)
	{
		$username = $credentials[self::USERNAME];
		$password = $credentials[self::PASSWORD];

		/** @var User $user */
		$user = $this->em->getRepository(User::class)->findOneBy(['email eq' => $username]);

		if (!$user) {
			throw new Nette\Security\AuthenticationException('Uživatelské jméno není správné.', self::IDENTITY_NOT_FOUND);
		} elseif (!Passwords::verify($password, $user->password)) {
			throw new Nette\Security\AuthenticationException('Zadané heslo není správné.', self::INVALID_CREDENTIAL);
		} elseif (Passwords::needsRehash($user->password)) {
			$user->password = Passwords::hash($password);
			$this->em->persist($user);
			$this->em->flush($user);
		}

		$roles = [];
		foreach ($user->roles as $role) {
			$roles[] = $role->getName();
		}
		return new Nette\Security\Identity($user->getId(), $roles, Nette\Utils\ArrayHash::from([
			'email' => $user->getEmail()
		]));
	}

}
