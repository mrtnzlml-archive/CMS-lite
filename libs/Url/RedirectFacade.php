<?php

namespace Url;

use Kdyby\Doctrine\EntityManager;
use Nette;

class RedirectFacade extends Nette\Object
{

	/** @var EntityManager */
	private $em;

	/** @var Nette\Caching\Cache */
	private $cache;

	public function __construct(EntityManager $entityManager, Nette\Caching\IStorage $cacheStorage)
	{
		$this->em = $entityManager;
		$this->cache = new Nette\Caching\Cache($cacheStorage, AntRoute::CACHE_NAMESPACE);
	}

	/**
	 * Creates new redirect links and modify the old ones for better performance.
	 *
	 * @param $from
	 * @param $to
	 *
	 * @throws \Exception
	 */
	public function createRedirect($from, $to)
	{
		if (!is_numeric($from)) {
			throw new Nette\InvalidArgumentException(sprintf('From ID should be numeric, %s given.', gettype($from)));
		}
		if (!is_numeric($to)) {
			throw new Nette\InvalidArgumentException(sprintf('To ID should be numeric, %s given.', gettype($to)));
		}

		$this->em->transactional(function () use ($from, $to) {
			/** @var Url $oldLink */
			foreach ($this->em->getRepository(Url::class)->findBy([
				'redirectTo' => $from
			]) as $oldLink) {
				$oldLink->setRedirectTo($this->em->getPartialReference(Url::class, $to));
				$this->cache->clean([Nette\Caching\Cache::TAGS => ['route/' . $oldLink->getId()]]);
			}
			/** @var Url $from */
			$from = $this->em->find(Url::class, $from);
			$from->setRedirectTo($this->em->getPartialReference(Url::class, $to));

			$this->em->flush();
			$this->cache->clean([Nette\Caching\Cache::TAGS => ['route/' . $from->getId()]]);
		});
	}

}
