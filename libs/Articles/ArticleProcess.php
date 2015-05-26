<?php

namespace Articles;

use Kdyby\Doctrine\EntityManager;
use Nette;

class ArticleProcess extends Nette\Object
{

	/** @var \Closure[] */
	public $onPersist = [];

	/** @var EntityManager */
	private $em;
	/** @var \Kdyby\Doctrine\EntityRepository */
	private $articles;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
		$this->articles = $em->getRepository(Article::class);
	}

	public function publish(Article $article)
	{
		if ($article->getTitle() === NULL) {
			throw new Nette\InvalidArgumentException;
		}
		if ($article->getBody() === NULL) {
			throw new Nette\InvalidArgumentException;
		}
		if ($article->getSlug() === NULL) {
			$article->setSlug(Nette\Utils\Strings::webalize($article->getTitle()));
		}
		// $article->published = TRUE;
		$this->em->persist($article);
		$this->onPersist($this, $article);
		// don't forget to call $em->flush() in your presenter
	}

}
