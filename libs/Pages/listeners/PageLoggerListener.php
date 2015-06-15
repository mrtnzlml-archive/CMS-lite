<?php

namespace Pages\Listeners;

use Kdyby;
use Nette;
use Pages\Components\PageForm\PageForm;
use Pages\Page;
use Pages\PageProcess;

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
			'Pages\PageProcess::onPublish',
			'Pages\PageProcess::onSave',
			'Pages\Components\PageForm\PageForm::onException',
		];
	}

	public function onPublish(PageProcess $process, Page $page)
	{
		$this->logger->addInfo(sprintf('Page "%s" has been published.', $page->getTitle()));
	}

	public function onSave(PageProcess $process, Page $page)
	{
		if ($page->isPublished()) {
			$this->logger->addInfo(sprintf('Page "%s" has been saved, it\'s already published.', $page->getTitle()));
		} else {
			$this->logger->addInfo(sprintf('Page "%s" has been saved, it\'s NOT published yet.', $page->getTitle()));
		}
	}

	public function onException(PageForm $control, \Exception $exc)
	{
		$this->logger->addCritical($exc->getMessage(), ['exception' => $exc]);
	}

}
