<?php

namespace Articles\Query;

use Kdyby;

class ArticlesQuery extends ArticlesQueryAdmin
{

	protected function createBasicDql(Kdyby\Persistence\Queryable $repository)
	{
		$basicDql = parent::createBasicDql($repository);
		$basicDql->andWhere('article.publishedAt <= CURRENT_TIMESTAMP()');
		return $basicDql;
	}

}
