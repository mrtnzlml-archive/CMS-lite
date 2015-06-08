<?php

namespace Pages\Query;

use Doctrine\ORM\NativeQuery;
use Kdyby;

class OptionsQuery extends Kdyby\Doctrine\QueryObject
{

	/**
	 * @var array|\Closure[]
	 */
	private $filter = [];

	/**
	 * @var array|\Closure[]
	 */
	private $select = [];

	public function withOptions($optionKeys)
	{
		$this->filter[] = function (Kdyby\Doctrine\QueryBuilder $qb) use ($optionKeys) {
			if (is_array($optionKeys) && count($optionKeys) > 1) {
				$qb->andWhere('option.key IN (:keys)')->setParameter('keys', $optionKeys);
			} else {
				$qb->andWhere('option.key = :key')->setParameter('key', $optionKeys);
			}
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
			->select('COUNT(option.id) AS total_count');
		return $qb;
	}

	/**
	 * @param Kdyby\Persistence\Queryable|Kdyby\Doctrine\EntityDao $repository
	 *
	 * @return Kdyby\Doctrine\NativeQueryBuilder
	 */
	private function createBasicDql(Kdyby\Persistence\Queryable $repository)
	{
		$qb = $repository->createQueryBuilder('option', 'option.key');
		foreach ($this->filter as $modifier) {
			$modifier($qb);
		}
		return $qb;
	}

}
