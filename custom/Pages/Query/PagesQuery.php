<?php

namespace Pages\Query;

use Kdyby;

class PagesQuery extends PagesQueryAdmin
{

	protected function createBasicDql(Kdyby\Persistence\Queryable $repository)
	{
		$basicDql = parent::createBasicDql($repository);
		$basicDql->andWhere('page.publishedAt <= CURRENT_TIMESTAMP()');
		return $basicDql;
	}

}
