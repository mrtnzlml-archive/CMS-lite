<?php

require __DIR__ . '/../bootstrap.php';

/**
 * TODO: každá komponenta by si měla nést testy sama
 * @testCase
 */
class PagePresenter extends \PresenterTestCase
{

	/** @var Kdyby\Doctrine\EntityManager */
	private $em;

	public function __construct()
	{
		$this->openPresenter('Pages:Page:');
		$this->em = $this->getContainer()->getByType(Kdyby\Doctrine\EntityManager::class);
	}

	public function testRenderDefault()
	{
		/** @var \Pages\Page $page */
		$pageQuery = (new \Pages\Query\PagesQuery());
		$page = $this->em->getRepository(\Pages\Page::class)->fetchOne($pageQuery);
		if ($page === NULL) {
			Tester\Environment::skip('You don\'t have any public page.');
		}
		$this->checkAction('default', [
			'id' => $page->getId(),
		]);
	}

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
