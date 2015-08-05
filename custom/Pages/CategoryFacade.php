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

/**
 * @method onSave(CategoryFacade $control, Category $entity)
 */
class CategoryFacade extends Nette\Object
{

	/** @var \Closure[] */
	public $onSave = [];

	/** @var EntityManager */
	private $em;

	/** @var Logger */
	private $monolog;

	/** @var RedirectFacade */
	private $redirectFacade;

	public function __construct(EntityManager $em, Logger $monolog, RedirectFacade $redirectFacade)
	{
		$this->em = $em;
		$this->monolog = $monolog;
		$this->redirectFacade = $redirectFacade;
	}

	/**
	 * @param Category $category
	 * @param ArrayHash $values
	 *
	 * @throws DuplicateRouteException
	 * @throws \Exception
	 */
	public function saveCategory(Category $category, ArrayHash $values)
	{
		$category->setName($values->name);
		$category->setTextBefore($values->before);
		$category->setTextAfter($values->after);

		//TODO: rodičovská kategorie

		$this->em->persist($category);
		$this->em->flush();
		$this->setUrl($category, $values);
		$this->onSave($this, $category);
	}


	///// HELPERS /////


	/**
	 * @param Category $category
	 * @param ArrayHash $values
	 *
	 * @throws DuplicateRouteException
	 * @throws \Exception
	 */
	private function setUrl(Category $category, ArrayHash $values)
	{
		if ($category->getUrl() === NULL) { //URL doesn't exist
			$category->setUrl(RouteGenerator::generate(
				empty($values->fakePath) ? Strings::webalize($values->title) : Strings::webalize($values->fakePath),
				'Pages:Front:Category:default',
				$category->getId()
			));
			try {
				$this->em->flush($category);
				$this->monolog->addInfo(
					sprintf('New URL %s for category "%s" has been generated.', $category->getUrl()->getFakePath(), $category->getName())
				);
			} catch (UniqueConstraintViolationException $exc) {
				throw new DuplicateRouteException;
			}
		} else { //URL does exist, check if it's needed to create redirect
			/** @var Url $oldUrl */
			$oldUrl = $category->getUrl();
			if ($values->fakePath !== $oldUrl->getFakePath()) {
				//We got new URL so we should create it and redirect the old one
				$newUrl = RouteGenerator::generate(
					empty($values->fakePath) ? Strings::webalize($values->title) : Strings::webalize($values->fakePath),
					'Pages:Front:Category:default',
					$category->getId()
				);
				$category->setUrl($newUrl);
				try {
					$this->em->flush($category);
					$this->redirectFacade->createRedirect($oldUrl->getId(), $newUrl->getId());
					$this->monolog->addInfo(
						sprintf('Category URL changed. Redirecting from %s to %s.', $oldUrl->getFakePath(), $newUrl->getFakePath())
					);
				} catch (UniqueConstraintViolationException $exc) {
					throw new DuplicateRouteException;
				}
			}
		}
	}

}
