<?php

namespace Url;

use Kdyby\Doctrine\EntityManager;
use Nette;

class RouteGenerator extends Nette\Object
{

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	//TODO: potom generovat na základě nějakých představených pravidel
	public function add($defaultPath, $destination, $parameters = [])
	{
		$url = new Url;
		$url->setFakePath($defaultPath);
		$url->setDestination($destination);

		foreach ($parameters as $key => $value) {
			$param = new UrlParameter;
			$param->setName($key);
			$param->setValue($value);
			$url->addParameter($param);
		}

		$this->em->safePersist($url); //NonLockingUniqueInserter
	}

}
