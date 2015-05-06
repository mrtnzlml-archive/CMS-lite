<?php

namespace Eshop\Cli;

use Kdyby\Doctrine\EntityManager;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Helper\QuestionHelper;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Question\ConfirmationQuestion;

class HeurekaExport extends Command
{

	/** @var EntityManager @inject */
	public $em;

	protected function configure()
	{
		$this->setName('eshop:heureka:export');
	}

	protected function execute(InputInterface $input, OutputInterface $output)
	{
		try {
			/** @var QuestionHelper $helper */
			$helper = $this->getHelper('question');
			$question = new ConfirmationQuestion('Continue with this action (N/y)? ', FALSE);
			if (!$helper->ask($input, $output, $question)) {
				return 0; // zero return code means everything is ok
			}

			$output->writeln('<comment>Not implemented!</comment>');
			return 0; // zero return code means everything is ok
		} catch (\Exception $exc) {
			$output->writeLn("<error>{$exc->getMessage()}</error>");
			return 1; // non-zero return code means error
		}
	}

}
