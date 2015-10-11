<?php

namespace Search;

use Kdyby\Doctrine\EntityManager;
use Kdyby\Doctrine\Mapping\ResultSetMappingBuilder;
use Nette;
use Nette\Utils\Strings;
use Pages\Page;

class SearchFacade extends Nette\Object
{

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function fulltext($searchTerm)
	{
		$string = Strings::lower(Strings::normalize($searchTerm));
		$string = Strings::replace($string, '/[^\d\w]/u', ' ');
		$words = Strings::split(Strings::trim($string), '/\s+/u');
		$words = array_unique(array_filter($words, function ($word) {
			return Strings::length($word) > 1;
		}));
		$words = array_map(function ($word) {
			return Strings::toAscii($word);
		}, $words);
		$string = implode(' ', $words);

		$rsm = new ResultSetMappingBuilder($this->em);
		//FIXME - nefunfguje: $rsm->addRootEntityFromClassMetadata(Page::class, 'p');
		$rsm->addEntityResult(Page::class, 'p');
		$rsm->addFieldResult('p', 'id', 'id');
		$rsm->addFieldResult('p', 'title', 'title');
		$rsm->addFieldResult('p', 'body', 'body');

		$sql = <<<SQL
SELECT p.*, 5 * MATCH(p.title) AGAINST (:search IN BOOLEAN MODE) + MATCH(p.title) AGAINST (:search IN BOOLEAN MODE) AS score
FROM pages p
WHERE MATCH(p.title, p.body) AGAINST (:search IN BOOLEAN MODE)
ORDER BY score DESC
SQL;

		$query = $this->em->getRepository(Page::class)->createNativeQuery($sql, $rsm);
		$query->setParameter('search', $string . '*');
		return $query->getResult();
	}

}
