<?php

namespace Pages;

use Kdyby\Doctrine\EntityManager;
use Nette;

class PageProcess extends Nette\Object
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
		$this->articles = $em->getRepository(Page::class);
	}

	public function publish(Page $page)
	{
		if ($page->getTitle() === NULL) {
			throw new Nette\InvalidArgumentException;
		}
		if ($page->getBody() === NULL) {
			throw new Nette\InvalidArgumentException;
		}
		if ($page->getSlug() === NULL) {
			$page->setSlug(Nette\Utils\Strings::webalize($page->getTitle()));
		}
		// $page->published = TRUE;
		$this->em->persist($page);
		$this->onPersist($this, $page);
		// don't forget to call $em->flush() in your presenter
	}

}
