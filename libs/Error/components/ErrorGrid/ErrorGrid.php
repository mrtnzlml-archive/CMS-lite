<?php

namespace Error\Components\ErrorGrid;

use App\Components\AControl;
use Error\Error;
use Kdyby\Doctrine\EntityManager;

class ErrorGrid extends AControl
{

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function render(array $parameters = NULL)
	{
		$this->template->errors = $this->em->getRepository(Error::class)->findBy(
			['code eq' => 404], //criteria
			['createdAt' => 'DESC'], //orderBy
			10 //limit
		);
		$this->template->render(__DIR__ . '/ErrorGrid.latte');
	}

}

interface IErrorGridFactory
{
	/** @return ErrorGrid */
	function create();
}
