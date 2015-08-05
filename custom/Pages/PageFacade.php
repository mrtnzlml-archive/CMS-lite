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

	public function __construct(
		EntityManager $em,
		Nette\Security\IUserStorage $user,
		RedirectFacade $redirectFacade,
		Logger $monolog
	) {
		$this->em = $em;
		$this->user = $user;
		$this->redirectFacade = $redirectFacade;
		$this->monolog = $monolog;
	}

	/**
	 * @param Page $page
	 * @param ArrayHash $values
	 *
	 * @throws DuplicateRouteException
	 * @throws \Exception
	 */
	public function publish(Page $page, ArrayHash $values)
	{
		$page->setPublishedAt(new \DateTime);
		$this->completePageEntity($page, $values);
		$this->em->persist($page);
		$this->em->flush();
		$this->setUrl($page, $values);
		$this->onPublish($this, $page);
	}

	/**
	 * @param Page $page
	 * @param ArrayHash $values
	 *
	 * @throws DuplicateRouteException
	 * @throws \Exception
	 */
	public function save(Page $page, ArrayHash $values)
	{
		$this->completePageEntity($page, $values);
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
				$this->onRemove($this, $pid);
			}
			return;
		}
		$this->removePage($page_id);
		$this->onRemove($this, $page_id);
		// don't forget to call $em->flush() in your control
	}


	///// HELPERS /////


	private function removePage($page_id)
	{
		//TODO: should set delete flag instead of actually deleting (?)
		/** @var Page $page */
		$page = $this->em->find(Page::class, (int)$page_id);
		$this->em->remove($page->getUrl());
		$this->em->remove($page);
	}

	private function completePageEntity(Page $page, ArrayHash $values)
	{
		$page->setTitle($values->title);
		$page->setBody($values->editor);
		$page->setIndividualTitle($values->individualTitle);
		$page->setDescription($values->description);
		$page->setIndex($values->index);
		$page->setFollow($values->follow);
		$page->setIndividualCss($values->individual_css);
		$page->setProtected($values->password, $values->protected);

		/** @var User $realAuthorReference */
		$realAuthorReference = $this->em->getPartialReference(User::class, $this->user->getIdentity()->getId());
		$page->setRealAuthor($realAuthorReference);

		///// AUTHORS /////
		if (in_array(NULL, $values->authors)) { //without author
			$page->clearAuthors();
		} else {
			foreach ($values->authors as $authorId) { //set new authors
				/** @var User $authorReference */
				$authorReference = $this->em->getPartialReference(User::class, $authorId);
				$page->setAuthor($authorReference);
			}
			foreach (array_diff($page->getAuthorIds(), $values->authors) as $oldAuthorId) { //remove old associations
				$authorReference = $this->em->getPartialReference(User::class, $oldAuthorId);
				$page->removeAuthor($authorReference);
			}
		}

		///// CATEGORIES /////
		if (in_array(NULL, $values->categories)) { //without category
			$page->clearCategories();
		} else {
			foreach ($values->categories as $categoryId) { //set new categories
				$category = $this->em->find(Category::class, $categoryId);
				$pageCategory = $this->em->getRepository(PageCategory::class)->findOneBy([
					'page' => $page,
					'category' => $category,
				]);
				if (!$pageCategory) {
					$pageCategory = new PageCategory;
				}
				$page->addPageCategory($pageCategory);
				$category->addPageCategory($pageCategory);
			}
			foreach (array_diff($page->getCategoryIds(), $values->categories) as $oldCategoryId) { //remove old associations
				$pageCategory = $this->em->getRepository(PageCategory::class)->findOneBy([
					'page' => $page,
					'category' => $oldCategoryId,
				]);
				$page->removePageCategory($pageCategory);
			}
		}

		///// TAGS /////
		$knownTags = [];
		/** @var Tag $tag */
		foreach ($this->em->getRepository(Tag::class)->findAll() as $tag) {
			$knownTags[$tag->getName()] = $tag;
		}
		$newTags = array_filter(array_unique(preg_split('~\s*,\s*~', $values->tags)));
		/** @var string $tag */
		foreach ($newTags as $tag) {
			if (array_key_exists($tag, $knownTags)) {
				$page->addTag($knownTags[$tag]);
			} else {
				$tagEntity = (new Tag)->setName($tag);
				$page->addTag($tagEntity);
			}
		}
		/** @var Tag $tag */
		foreach ($knownTags as $key => $tag) {
			if (!in_array($key, $newTags)) {
				$page->removeTag($tag);
			}
		}

		///// OPEN GRAPH /////
		$ogs = $page->getOpenGraphs();
		$mapping = ['og:title' => 'fcbk_title', 'og:description' => 'fcbk_description'];
		foreach ($mapping as $key => $value) {
			if (array_key_exists($key, $ogs)) {
				$ogs[$key]->content = $values[$value];
				$page->setOpenGraph($ogs[$key]);
			} else { //new entry
				$og = new OpenGraph($key, $values[$value]);
				$page->setOpenGraph($og);
			}
		}
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
				empty($values->fakePath) ? Strings::webalize($values->title) : Strings::webalize($values->fakePath),
				'Pages:Front:Page:default', $page->getId()
			));
			try {
				$this->em->flush($page);
				$this->monolog->addInfo(sprintf('New URL %s for page "%s" has been generated.',
					$page->getUrl()->getFakePath(), $page->getTitle()));
			} catch (UniqueConstraintViolationException $exc) {
				throw new DuplicateRouteException;
			}
		} else { //URL does exist, check if it's needed to create redirect
			/** @var Url $oldUrl */
			$oldUrl = $page->getUrl();
			if ($values->fakePath !== $oldUrl->getFakePath()) {
				//We got new URL so we should create it and redirect the old one
				$newUrl = RouteGenerator::generate(
					empty($values->fakePath) ? Strings::webalize($values->title) : Strings::webalize($values->fakePath),
					'Pages:Front:Page:default', $page->getId()
				);
				$page->setUrl($newUrl);
				try {
					$this->em->flush($page);
					$this->redirectFacade->createRedirect($oldUrl->getId(), $newUrl->getId());
					$this->monolog->addInfo(
						sprintf('Page URL changed. Redirecting from %s to %s.', $oldUrl->getFakePath(), $newUrl->getFakePath())
					);
				} catch (UniqueConstraintViolationException $exc) {
					throw new DuplicateRouteException;
				}
			}
		}
	}

}
