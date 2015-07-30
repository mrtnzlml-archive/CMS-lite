<?php

namespace Pages\Query;

use Doctrine\ORM\NativeQuery;
use Kdyby;
use Users\User;

class PagesQueryAdmin extends Kdyby\Doctrine\QueryObject
{

	/**
	 * @var array|\Closure[]
	 */
	private $filter = [];

	/**
	 * @var array|\Closure[]
	 */
	private $select = [];

	public function byAuthor(User $user)
	{
		$this->filter[] = function (Kdyby\Doctrine\QueryBuilder $qb) use ($user) {
			$qb->andWhere('authors.id = :user')->setParameter('user', $user->getId());
		};
		return $this;
	}

	public function byId($id)
	{
		$this->filter[] = function (Kdyby\Doctrine\QueryBuilder $qb) use ($id) {
			$qb->andWhere('page.id = :id')->setParameter('id', $id);
		};
		return $this;
	}

	public function preview($pageId, $userId)
	{
		$this->filter[] = function (Kdyby\Doctrine\QueryBuilder $qb) use ($pageId, $userId) {
			$qb->andWhere('page.id = :pageId')->setParameter('pageId', $pageId);
			$qb->andWhere('page.realAuthor = :userId')->setParameter('userId', $userId);
		};
		return $this;
	}

	public function withAuthors($author_id = NULL)
	{
		$this->select[] = function (Kdyby\Doctrine\QueryBuilder $qb) use ($author_id) {
			$qb->leftJoin('page.authors', 'authors')->addSelect('authors');
			if ($author_id !== NULL) {
				$qb->leftJoin('page.authors', 'ax');
				$qb->andWhere('ax = :aid')->setParameter('aid', (int)$author_id);
			}
		};
		return $this;
	}

	public function withCategories($category_id = NULL)
	{
		$this->select[] = function (Kdyby\Doctrine\QueryBuilder $qb) use ($category_id) {
			$qb->leftJoin('page.categories', 'categories')->addSelect('categories');
			if ($category_id !== NULL) {
				$qb->leftJoin('page.categories', 'cx');
				$qb->andWhere('cx = :cid')->setParameter('cid', (int)$category_id);
			}
		};
		return $this;
	}

	public function withTags($tag_id = NULL)
	{
		$this->select[] = function (Kdyby\Doctrine\QueryBuilder $qb) use ($tag_id) {
			$qb->leftJoin('page.tags', 'tags')->addSelect('tags');
			if ($tag_id !== NULL) {
				$qb->leftJoin('page.tags', 'tx');
				$qb->andWhere('tx = :tid')->setParameter('tid', (int)$tag_id);
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
		$qb->addOrderBy('page.createdAt', 'DESC');
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
			->select('COUNT(page.id) AS total_count');
		return $qb;
	}

	/**
	 * @param Kdyby\Persistence\Queryable|Kdyby\Doctrine\EntityDao $repository
	 *
	 * @return Kdyby\Doctrine\NativeQueryBuilder
	 */
	protected function createBasicDql(Kdyby\Persistence\Queryable $repository)
	{
		$qb = $repository->createQueryBuilder('page', 'page.id');
		$qb->andWhere('page.deleted = FALSE');
		foreach ($this->filter as $modifier) {
			$modifier($qb);
		}
		return $qb;
	}

}
