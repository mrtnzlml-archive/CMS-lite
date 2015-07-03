<?php

require __DIR__ . '/../bootstrap.php';

/**
 * @testCase
 */
class PagePresenter extends \PresenterTestCase
{

	/** @var Kdyby\Doctrine\EntityManager */
	private $em;

	public function __construct()
	{
		$this->openPresenter('Front:Page:');
		$this->em = $this->getContainer()->getByType(Kdyby\Doctrine\EntityManager::class);
	}

//	public function testRenderDefault()
//	{ //TODO: Nefunguje, protože se používá nový styp routování. Nutno opravit.
//		/** @var \Pages\Page $page */
//		$page = $this->em->getRepository(\Pages\Page::class)->findOneBy([]);
//		$this->checkAction('default', [
//			'id' => $page->getId(),
//		]);
//	}

	public function testRenderDefaultEmpty()
	{
		Tester\Assert::exception(function () {
			$this->checkAction('default');
		}, Nette\Application\BadRequestException::class, 'Page not found.');
	}

	public function testRenderDefaultNonExist()
	{
		Tester\Assert::exception(function () {
			$this->checkAction('default', [
				'slug' => md5('this-slug-probably-does-not-exist'),
			]);
		}, Nette\Application\BadRequestException::class, 'Page not found.');
	}

}

(new PagePresenter())->run();
