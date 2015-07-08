<?php

namespace Url\Components\RedirectForm;

use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Nette\Utils\ArrayHash;
use Nette\Utils\Strings;
use Nextras\Application\UI\SecuredLinksControlTrait;
use Pages\Page;
use Url;
use Url\RedirectFacade;

class RedirectForm extends UI\Control
{

	use SecuredLinksControlTrait;

	private $pageId;

	/** @var Url\Url */
	private $currentUrl;

	/** @var EntityManager */
	private $em;

	/** @var RedirectFacade */
	private $redirectFacade;

	/** @var Nette\Caching\Cache */
	private $cache;

	public function __construct($pageId = NULL, EntityManager $em, RedirectFacade $redirectFacade, Nette\Caching\IStorage $cacheStorage)
	{
		$this->pageId = $pageId;
		$this->em = $em;
		$this->redirectFacade = $redirectFacade;
		$this->cache = new Nette\Caching\Cache($cacheStorage, Url\AntRoute::CACHE_NAMESPACE);

		if ($this->pageId !== NULL) {
			/** @var Page $page */
			$page = $this->em->find(Page::class, $this->pageId);
			$this->currentUrl = $page->getUrl();
		}
	}

	public function render()
	{
		if ($this->pageId !== NULL) {
			$this->template->redirects = $this->em->getRepository(Url\Url::class)->findBy(['redirectTo' => $this->currentUrl->getId()]);
		}

		$this->template->render(__DIR__ . '/templates/RedirectForm.latte');
	}

	protected function createComponentRedirectForm()
	{
		$form = new UI\Form;
		$form->addText('url', 'Přidat libovolnou adresu pro přesměrování na tuto stránku:');
		$form->addSubmit('add', 'Přidat');
		$form->onSuccess[] = function (UI\Form $form, ArrayHash $values) {
			if (!Strings::compare(Strings::webalize($values->url, '/'), $values->url)) {
				$form->addError(
					'Tato adresa není ve správném formátu.'
					. ' Adresa může obsahovat pouze alfanumerické znaky, pomlčku a lomítko.'
				);
				return;
			}
			/** @var Url\Url $url */
			$url = (new Url\Url)->setFakePath($values->url);
			$this->em->persist($url);
			$this->em->flush($url);
			//FIXME: nebude fungovat při nové stránce
			$this->redirectFacade->createRedirect($url->getId(), $this->currentUrl->getId());
			$this->getPresenter()->flashMessage('Přesměrování bylo úspěšně vytvořeno.', Flashes::FLASH_SUCCESS);
		};
		return $form;
	}

	/**
	 * @secured
	 */
	public function handleDeleteRedirect($url_id)
	{
		/** @var Url\Url $url */
		$url = $this->em->find(Url\Url::class, $url_id);
		$url->setRedirectTo(NULL);
		$this->em->persist($url);
		$this->em->flush($url);
		$this->cache->clean([Nette\Caching\Cache::TAGS => ['route/' . $url_id]]);
		$this->redirect('this');
	}

}

interface IRedirectFormFactory
{
	/** @return RedirectForm */
	function create($pageId = NULL);
}
