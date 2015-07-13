<?php

namespace Files\Query;

use Kdyby;
use Kdyby\Persistence\Queryable;

class FileQuery extends Kdyby\Doctrine\QueryObject
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
	 * @param Queryable $repository
	 *
	 * @return \Doctrine\ORM\Query|\Doctrine\ORM\QueryBuilder
	 */
	protected function doCreateQuery(Queryable $repository)
	{
		$qb = $this->createBasicDql($repository); //FIXME
		foreach ($this->select as $modifier) {
			$modifier($qb);
		}

		return $qb;
	}

}
