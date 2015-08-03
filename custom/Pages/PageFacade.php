<?php

namespace Pages;

use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Kdyby\Doctrine\EntityManager;
use Monolog\Logger;
use Nette;
use Nette\Utils\ArrayHash;
use Nette\Utils\Strings;
use Url\DuplicateRouteException;
use Url\RedirectFacade;
use Url\RouteGenerator;
use Url\Url;
use Users\User;

/**
 * @method onSave(PageFacade $control, Page $entity)
 * @method onPublish(PageFacade $control, Page $entity)
 * @method onRemove(PageFacade $control, $page_id)
 */
class PageFacade extends Nette\Object
{

	/** @var \Closure[] */
	public $onPublish = [];

	/** @var \Closure[] */
	public $onSave = [];

	/** @var \Closure[] */
	public $onRemove = [];

	/** @var EntityManager */
	private $em;

	/** @var Nette\Security\IUserStorage */
	private $user;

	/** @var RedirectFacade */
	private $redirectFacade;

	/** @var Logger */
	private $monolog;

	public function __construct(EntityManager $em, Nette\Security\IUserStorage $user, RedirectFacade $redirectFacade, Logger $monolog)
	{
		$this->em = $em;
		$this->user = $user;
		$this->redirectFacade = $redirectFacade;
		$this->monolog = $monolog;
	}

	public function publish(Page $page, ArrayHash $values)
	{
		$page->publishedAt = new \DateTime();
		$this->completePageEntity($page);
		$this->em->persist($page);
		$this->em->flush();
		$this->setUrl($page, $values);
		$this->onPublish($this, $page);
	}

	public function save(Page $page, ArrayHash $values)
	{
		$this->completePageEntity($page);
		$this->em->persist($page);
		$this->em->flush();
		$this->setUrl($page, $values);
		$this->onSave($this, $page);
	}

	/**
	 * @param integer|array $page_id
	 *
	 * @throws \Doctrine\ORM\ORMException
	 * @throws \Doctrine\ORM\OptimisticLockException
	 * @throws \Doctrine\ORM\TransactionRequiredException
	 */
	public function remove($page_id)
	{
		if (is_array($page_id)) {
			foreach ($page_id as $pid) {
				$this->removePage($pid);
			}
			$this->onRemove($this);
			return;
		}
		$this->removePage($page_id);
		$this->onRemove($this, $page_id);
		// don't forget to call $em->flush() in your control
	}

	private function removePage($page_id)
	{
		//TODO: should set delete flag instead of actually deleting (?)
		/** @var Page $page */
		$page = $this->em->find(Page::class, (int)$page_id);
		$this->em->remove($page->getUrl());
		$this->em->remove($page);
	}

	private function completePageEntity(Page $page)
	{
		if ($page->getTitle() === NULL) {
			throw new Nette\InvalidArgumentException('You must set title of the page.');
		}
		if ($page->getBody() === NULL) {
			throw new Nette\InvalidArgumentException('You must set body of the page.');
		}
		/** @var User $realAuthorReference */
		$realAuthorReference = $this->em->getPartialReference(User::class, $this->user->getIdentity()->getId());
		$page->setRealAuthor($realAuthorReference);
	}

	/**
	 * @param Page $page
	 * @param ArrayHash $values
	 *
	 * @throws DuplicateRouteException
	 */
	private function setUrl(Page $page, ArrayHash $values)
	{
		if ($page->getUrl() === NULL) { //URL doesn't exist
			$page->setUrl(RouteGenerator::generate(
				empty($values->slug) ? Strings::webalize($values->title) : Strings::webalize($values->slug),
				'Pages:Front:Page:default', $page->getId()
			));
			try {
				$this->em->flush($page);
				$this->monolog->addInfo(sprintf('New URL %s for page "%s" has been generated.', $page->getUrl()->getFakePath(), $page->getTitle()));
			} catch (UniqueConstraintViolationException $exc) {
				throw new DuplicateRouteException;
			}
		} else { //URL does exist, check if it's needed to create redirect
			/** @var Url $oldUrl */
			$oldUrl = $page->getUrl();
			if ($values->slug !== $oldUrl->getFakePath()) {
				//We got new URL so we should create it and redirect the old one
				$newUrl = RouteGenerator::generate(
					empty($values->slug) ? Strings::webalize($values->title) : Strings::webalize($values->slug),
					'Pages:Front:Page:default', $page->getId()
				);
				$page->setUrl($newUrl);
				try {
					$this->em->flush($page);
					$this->redirectFacade->createRedirect($oldUrl->getId(), $newUrl->getId());
					$this->monolog->addInfo(sprintf('Page URL changed. Redirecting from %s to %s.', $oldUrl->getFakePath(), $newUrl->getFakePath()));
				} catch (UniqueConstraintViolationException $exc) {
					throw new DuplicateRouteException;
				}
			}
		}
	}

}
