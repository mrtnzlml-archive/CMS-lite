<?php

namespace Pages\Listeners;

use Kdyby;
use Nette;
use Pages\Components\PageForm\PageForm;
use Pages\Page;
use Pages\PageFacade;

class PageLoggerListener extends Nette\Object implements Kdyby\Events\Subscriber
{

	/** @var Kdyby\Monolog\Logger */
	private $logger;

	public function __construct(Kdyby\Monolog\Logger $logger)
	{
		$this->logger = $logger->channel('pages');
	}

	public function getSubscribedEvents()
	{
		return [
			'Pages\PageFacade::onPublish',
			'Pages\PageFacade::onSave',
			'Pages\PageFacade::onRemove', //FIXME: neloguje
			'Pages\Components\PageForm\PageForm::onException',
		];
	}

	public function onPublish(PageFacade $_, Page $page)
	{
		$this->logger->addInfo(sprintf('Page "%s" has been published.', $page->getTitle()));
	}

	public function onSave(PageFacade $_, Page $page)
	{
		if ($page->isPublished()) {
			$this->logger->addInfo(sprintf('Page "%s" has been saved, it\'s already published.', $page->getTitle()));
		} else {
			$this->logger->addInfo(sprintf('Page "%s" has been saved, it\'s NOT published yet.', $page->getTitle()));
		}
	}

	public function onRemove(PageFacade $_, Page $page)
	{
		$this->logger->addInfo(sprintf('Page "%s" has been deleted.', $page->getTitle()));
	}

	public function onException(PageForm $_, \Exception $exc)
	{
		$this->logger->addCritical($exc->getMessage(), ['exception' => $exc]);
	}

}
