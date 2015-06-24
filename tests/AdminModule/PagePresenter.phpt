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
		/** @var \Nette\Application\Responses\RedirectResponse $response */
		$response = $this->checkRedirect('default');
		Tester\Assert::same(302, $response->getCode());
		Tester\Assert::match('~https://fake.url/auth\?backlink=[a-z0-9]{5}&_fid=[a-z0-9]{4}~', $response->getUrl());
	}

	public function testRenderNew()
	{
		$this->checkAction('new');
	}

	public function testRenderNewLoggedOut()
	{
		$this->logOut();
		/** @var \Nette\Application\Responses\RedirectResponse $response */
		$response = $this->checkRedirect('new');
		Tester\Assert::same(302, $response->getCode());
		Tester\Assert::match('~https://fake.url/auth\?backlink=[a-z0-9]{5}&_fid=[a-z0-9]{4}~', $response->getUrl());
	}

	public function testRenderEmptyEditRedirect()
	{
		/** @var \Nette\Application\Responses\RedirectResponse $response */
		$response = $this->checkRedirect('edit');
		Tester\Assert::same(302, $response->getCode());
		Tester\Assert::same('https://fake.url/administrace/page/new', $response->getUrl());
	}

	public function testRenderEdit()
	{
		/** @var \Pages\Page $page */
		$page = $this->em->getRepository(\Pages\Page::class)->findOneBy([]);
		$this->checkAction('edit', 'GET', [
			'id' => $page->getId(),
		]);
	}

	public function testRenderEditMissingId()
	{
		/** @var \Nette\Application\Responses\RedirectResponse $response */
		$response = $this->checkRedirect('edit', 'GET', [
			'id' => 'missing'
		]);
		Tester\Assert::same(302, $response->getCode());
		Tester\Assert::same('https://fake.url/administrace/page/new', $response->getUrl());
	}

}

(new PagePresenter())->run();
