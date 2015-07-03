<?php

namespace Pages;

use Kdyby\Doctrine\EntityManager;
use Nette;
use Url\RouteGenerator;
use Users\User;

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
	/** @var Nette\Security\IUserStorage */
	private $user;
	/** @var RouteGenerator */
	private $routeGenerator;

	public function __construct(EntityManager $em, Nette\Security\IUserStorage $user, RouteGenerator $routeGenerator)
	{
		$this->em = $em;
		$this->articles = $em->getRepository(Page::class);
		$this->user = $user;
		$this->routeGenerator = $routeGenerator;
	}

	public function publish(Page $page)
	{
		$page->publishedAt = new \DateTime();
		$this->completePageEntity($page);
		$this->em->persist($page);
		$this->routeGenerator->add($page->slug, 'Front:Page:default', [
			'slug' => $page->slug,
		]);
		$this->onPublish($this, $page);
		// don't forget to call $em->flush() in your control
	}

	public function save(Page $page)
	{
		$this->completePageEntity($page);
		$this->em->persist($page);
		$this->routeGenerator->add($page->slug, 'Front:Page:default', [
			'slug' => $page->slug,
		]);
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
		$realAuthorReference = $this->em->getPartialReference(User::class, $this->user->getIdentity()->getId());
		$page->setRealAuthor($realAuthorReference);
	}

}
