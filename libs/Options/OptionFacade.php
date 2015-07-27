<?php

namespace Options;

use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Caching\IStorage;
use Nette\Object;
use Nette\Utils\ArrayHash;

class OptionFacade extends Object
{

	/** @var EntityManager */
	private $em;

	/** @var Nette\Caching\Cache */
	private $cache;

	const CACHE_NAMESPACE = 'ANT.Option';

	public function __construct(EntityManager $em, IStorage $cacheStorage)
	{
		$this->em = $em;
		$this->cache = new Nette\Caching\Cache($cacheStorage, self::CACHE_NAMESPACE);
	}

	/**
	 * It's able to save options even if the form contains nested containers (nested ArrayHashes).
	 *
	 * @param ArrayHash $values
	 *
	 * @throws \Exception
	 */
	public function setOptions(ArrayHash $values)
	{
		foreach ($values as $key => $value) {
			if ($value instanceof ArrayHash) {
				$this->setOptions($value);
			} else {
				$this->setOption($key, $value);
			}
		}
		$this->em->flush();
	}

	/**
	 * @param $optionName
	 *
	 * @return string|array|NULL
	 */
	public function getOption($optionName)
	{
		$option = $this->cache->load($optionName, function (& $dependencies) use ($optionName) {
			/** @var Option $option */
			$option = $this->em->getRepository(Option::class)->findOneBy(['key eq' => $optionName]);
			if (!$option) {
				return NULL;
			}
			$dependencies = [Nette\Caching\Cache::TAGS => [$optionName]];
			$value = $option->getValue();
			if ($this->isSerialized($value)) {
				return unserialize($value);
			}
			return $value;
		});
		return $option;
	}

	private function setOption($optionName, $optionValue)
	{
		$optionValue = is_array($optionValue) ? serialize($optionValue) : $optionValue;
		$optionRepository = $this->em->getRepository(Option::class);
		/** @var Option $option */
		$option = $optionRepository->findOneBy(['key eq' => $optionName]);
		if (!$option) {
			$option = new Option($optionName, $optionValue);
			$this->em->persist($option);
			$this->em->flush($option);
			return;
		}
		$option->setValue($optionValue);
		$this->em->persist($option);
		$this->cache->clean([Nette\Caching\Cache::TAGS => [$optionName]]);
	}

	private function isSerialized($string)
	{
		return ($string == serialize(FALSE) || @unserialize($string) !== FALSE);
	}

}
