<?php

namespace Pages\Presenters;

use App\Components\Flashes\Flashes;
use App\FrontModule\Presenters\BasePresenter;
use Kdyby\Doctrine\EntityManager;
use Latte;
use Nette;
use Nette\Application\UI;
use Nette\Application\UI\ITemplateFactory;
use Pages\OpenGraph;
use Pages\Page;
use Pages\Query\PagesQuery;
use Pages\Query\PagesQueryAdmin;


class PagePresenter extends BasePresenter
{

	/** @var EntityManager */
	private $em;

	/** @var ITemplateFactory */
	private $templateFactory;

	/** @var integer */
	private $protected_page_id;

	public function __construct(EntityManager $em, ITemplateFactory $templateFactory)
	{
		$this->em = $em;
		$this->templateFactory = $templateFactory;
	}

	public function actionDefault($id)
	{
		$pageQuery = (new PagesQuery)->byId($id);
		/** @var Page $page */
		$page = $this->em->getRepository(Page::class)->fetchOne($pageQuery);
		if ($page === NULL) {
			$this->error('Page not found.');
		}

		$id = $this->getParameterId('page_authorized');
		if ($page->protected && !$this->getSession(__CLASS__)->$id) {
			$this->redirect('protected', $page->getId());
		} else {
			$this['meta']->setRobots([
				$page->getIndex(), $page->getFollow(),
			]);
			$this->setTitle($page->getIndividualTitle() ?: $page->getTitle());
			$this->setMeta('description', $page->getDescription());
			/** @var OpenGraph $og */
			foreach ($page->getOpenGraphs() as $og) {
				//TODO: pokud není nějaký og:meta vyplněn, je nutné nastavit jinak
				$this->setMeta($og->getProperty(), $og->getContent());
			}

//		    $latte = $this->getTemplate()->getLatte(); //Latte\Engine
//		    $latte->setLoader(new Latte\Loaders\StringLoader);
//		    $rendered = $latte->renderToString($page->getBody(), $this->getTemplate()->getParameters());
//		    $this->template->body = Nette\Utils\Html::el()->setHtml($rendered);

			$this->template->page = $page;
		}
	}

	public function actionProtected($id = NULL)
	{
		if ($id === NULL) {
			$this->redirect('default');
		}
		$this->getComponent('meta')->setRobots('noindex');
		$this->protected_page_id = $id;
	}

	public function actionPreview($id)
	{
		if (!$this->user->isLoggedIn()) {
			$this->error('Page not found.');
		}
		$pageQuery = (new PagesQueryAdmin)->preview($id, $this->getUser()->getId());
		$page = $this->em->getRepository(Page::class)->fetchOne($pageQuery);
		if ($page === NULL) {
			$this->error('Page not found.');
		}
		$this->setTitle($page->title);
		$this->setMeta('robots', 'noindex');
		$this->template->page = $page;
		$this->setView('default');
	}

	protected function createComponentProtected()
	{
		$form = new UI\Form;
		$form->addPassword('password', 'Heslo:')
			->setRequired('Vyplňte prosím heslo k této stránce.');
		$form->addSubmit('check', 'Ověřit heslo');
		$form->onSuccess[] = function ($_, Nette\Utils\ArrayHash $values) {
			/** @var Page $page */
			$page = $this->em->find(Page::class, $this->protected_page_id);
			if (Nette\Security\Passwords::verify($values->password, $page->getPassword())) {
				$id = $this->getParameterId('page_authorized');
				$section = $this->getSession(__CLASS__)->setExpiration('14 days', $id);
				$section->$id = TRUE;
			} else {
				$this->flashMessage('Zadané heslo není správné', Flashes::FLASH_DANGER);
			}
			$this->redirect('default', $this->protected_page_id);
		};
		return $form;
	}

}
