<?php

namespace Search;

use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Utils\Strings;

class SearchFacade extends Nette\Object
{

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

		$qb = $this->em->createQueryBuilder();
		$qb->select('p')
			->from('Pages\Page', 'p')
			->andWhere('MATCH (p.title, p.body) AGAINST (:search BOOLEAN) > 0')//FIXME: >0 jen kvůli DQL
			->orderBy('MATCH(p.title) AGAINST (:search)')//FIXME: ORDER BY 5 * MATCH(nadpis) AGAINST ('$search') + MATCH(clanek) AGAINST ('$search') DESC
			->setParameter('search', $string . '*');
		return $qb->getQuery()->getResult();
	}

}
