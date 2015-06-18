<?php

namespace Eshop\Query;

use Doctrine\ORM\NativeQuery;
use Kdyby;

class ProductQuery extends Kdyby\Doctrine\QueryObject
{

	/**
	 * @var array|\Closure[]
	 */
	private $filter = [];

	/**
	 * @var array|\Closure[]
	 */
	private $select = [];

	public function withAllDeliveries()
	{
		$this->select[] = function (Kdyby\Doctrine\QueryBuilder $qb) {
			$qb->leftJoin('product.deliveries', 'delivery')->addSelect('delivery');
		};
		return $this;
	}

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
			->select('COUNT(product.id) AS total_count');
		return $qb;
	}

	/**
	 * @param Kdyby\Persistence\Queryable|Kdyby\Doctrine\EntityDao $repository
	 *
	 * @return Kdyby\Doctrine\NativeQueryBuilder
	 */
	private function createBasicDql(Kdyby\Persistence\Queryable $repository)
	{
		$qb = $repository->createQueryBuilder('product', 'product.id');
		foreach ($this->filter as $modifier) {
			$modifier($qb);
		}
		return $qb;
	}

	/**
	 * @param Kdyby\Persistence\Queryable $repository
	 * @param \Iterator $iterator
	 *
	 * @see https://github.com/Kdyby/Doctrine/blob/master/docs/en/optimizing-query-objects.md
	 */
	public function postFetch(Kdyby\Persistence\Queryable $repository, \Iterator $iterator)
	{
//		$ids = array_keys(iterator_to_array($iterator, TRUE));
	}

}
