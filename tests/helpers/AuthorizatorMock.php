<?php

class AuthorizatorMock extends \Users\Authorizator
{

	public function isAllowed($role, $resource, $privilege)
	{
		return TRUE;
	}

}
