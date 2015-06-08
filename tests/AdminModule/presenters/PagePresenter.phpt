<?php

require __DIR__ . '/../../bootstrap.php';

/**
 * @testCase
 */
class PagePresenter extends \PresenterTestCase
{

	/** @var Kdyby\Doctrine\EntityManager */
	private $em;

	public function __construct()
	{
		$this->openPresenter('Admin:Page:');
		$container = $this->getContainer();
		$this->em = $container->getByType(Kdyby\Doctrine\EntityManager::class);
	}

	public function setUp()
	{
		$this->logIn(1, 'superadmin'); //TODO: lépe (?)
	}

	public function testRenderDefault()
	{
		$this->checkAction('default');
	}

	public function testRenderDefaultLoggedOut()
	{
		$this->logOut();
		$this->checkRedirect('default');
	}

	public function testRenderNew()
	{
		$this->checkAction('new');
	}

	public function testRenderNewLoggedOut()
	{
		$this->logOut();
		$this->checkRedirect('new');
	}

	public function testRenderEmptyEditRedirect()
	{
		//TODO: u redirectů testovat kam přesměrovávají
		$this->checkRedirect('edit');
	}

	public function testRenderEdit()
	{
		/** @var \Pages\Page $page */
		$page = $this->em->getRepository(\Pages\Page::class)->findOneBy([]);
		$this->checkAction('edit', 'GET', [
			'id' => $page->getId()
		]);
	}

}

(new PagePresenter())->run();
