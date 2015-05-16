<?php

namespace Users;

use Nette;
use Nette\Security\AuthenticationException;
use Nette\Security\Passwords;
use Nette\Utils\Strings;

class Manager extends Nette\Object implements Nette\Security\IAuthenticator
{

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
		$password = $password === Strings::upper($password) ? Strings::lower($password) : $password;

		$user = new \stdClass(); //TODO: find $username in database

		if (!$user) {
			throw new Nette\Security\AuthenticationException('Uživatelské jméno není správné.', self::IDENTITY_NOT_FOUND);
		} elseif (!Passwords::verify($password, $user->password)) {
			throw new Nette\Security\AuthenticationException('Zadané heslo není správné.', self::INVALID_CREDENTIAL);
//		} elseif (Passwords::needsRehash($user->password)) {
//			$user->password = Passwords::hash($password);
//			$this->users->save($user);
		} else {
			return new Nette\Security\Identity($user->getId(), $user->role);
		}
	}

}
