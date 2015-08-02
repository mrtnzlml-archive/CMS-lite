<?php

namespace Users\Query;

use Doctrine\ORM\NativeQuery;
use Kdyby;

class UsersQuery extends Kdyby\Doctrine\QueryObject
{

	/**
	 * @var array|\Closure[]
	 */
	private $filter = [];

	/**
	 * @var array|\Closure[]
	 */
	private $select = [];

	/**
	 * @param \Kdyby\Persistence\Queryable $repository
	 *
	 * @return \Doctrine\ORM\Query|\Doctrine\ORM\QueryBuilder
	 */
	protected function doCreateQuery(Kdyby\Persistence\Queryable $repository)
	{
		$qb = $this->createBasicDql($repository);
		foreach ($this->select as $modifier) {
			$modifier($qb);
		}
		$qb->addOrderBy('user.email', 'DESC');
		return $qb;
	}

	/**
	 * @param Kdyby\Persistence\Queryable $repository
	 *
	 * @return NativeQuery
	 */
	protected function doCreateCountQuery(Kdyby\Persistence\Queryable $repository)
	{
		$qb = $this->createBasicDql($repository)
			->select('COUNT(user.id) AS total_count');
		return $qb;
	}

	/**
	 * @param Kdyby\Persistence\Queryable|Kdyby\Doctrine\EntityDao $repository
	 *
	 * @return Kdyby\Doctrine\NativeQueryBuilder
	 */
	private function createBasicDql(Kdyby\Persistence\Queryable $repository)
	{
		$qb = $repository->createQueryBuilder('user', 'user.id');
		foreach ($this->filter as $modifier) {
			$modifier($qb);
		}
		return $qb;
	}

}
