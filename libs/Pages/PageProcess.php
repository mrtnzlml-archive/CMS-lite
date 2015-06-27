<?php

namespace Pages;

use Kdyby\Doctrine\EntityManager;
use Nette;

/**
 * @method onSave(PageProcess $control, Page $entity)
 * @method onPublish(PageProcess $control, Page $entity)
 */
class PageProcess extends Nette\Object
{

	/** @var \Closure[] */
	public $onPublish = [];

	/** @var \Closure[] */
	public $onSave = [];

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
		$page->publishedAt = new \DateTime();
		$this->completePageEntity($page);
		$this->em->persist($page);
		$this->onPublish($this, $page);
		// don't forget to call $em->flush() in your control
	}

	public function save(Page $page)
	{
		$this->completePageEntity($page);
		$this->em->persist($page);
		$this->onSave($this, $page);
		// don't forget to call $em->flush() in your control
	}

	//TODO: delete (přijímá i pole a iteruje jej)

	private function completePageEntity(Page $page)
	{
		if ($page->getTitle() === NULL) {
			throw new Nette\InvalidArgumentException('You must set title of the page.');
		}
		if ($page->getBody() === NULL) {
			throw new Nette\InvalidArgumentException('You must set body of the page.');
		}
		if ($page->getSlug() === NULL) {
			$page->setSlug(Nette\Utils\Strings::webalize($page->getTitle()));
		}
	}

}
