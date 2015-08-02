<?php

namespace Files\Cli;

use Files\File;
use Files\FileProcess;
use Kdyby\Doctrine\EntityManager;
use Nette\Utils\FileSystem;
use Options\OptionFacade;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class RecalculateImages extends Command
{

	/** @var EntityManager @inject */
	public $em;

	/** @var OptionFacade @inject */
	public $optionFacade;

	/** @var FileProcess @inject */
	public $fileProcess;

	private $directory;

	public function __construct($name = NULL)
	{
		parent::__construct($name);
		$this->directory = __DIR__ . '/../../../upload/pictures'; //FIXME: jak si to předat lépe?
	}

	protected function configure()
	{
		$this->setName('cms:images:recalculate')
			->setDescription('Recalculate image dimensions.');
	}

	protected function execute(InputInterface $input, OutputInterface $output)
	{
		try {
			$filesRepository = $this->em->getRepository(File::class);
			$matrix = $this->optionFacade->getOption('image_resize_matrix');
			/** @var File $picture */
			foreach ($filesRepository->findBy(['picture eq' => TRUE]) as $picture) {
				foreach ($matrix as $type => $dimensions) {
					FileSystem::delete($this->directory . DIRECTORY_SEPARATOR . $picture->getUuid() . DIRECTORY_SEPARATOR . $type);
				}
				$output->writeln("<comment>></comment> <info>Resizing {$picture->getName()}</info>");
				$this->fileProcess->resizeImage($this->directory . DIRECTORY_SEPARATOR . $picture->getUuid(), $picture->getName());
			}
			$output->writeln("<info>Every single image has been recalculated.</info>");
			return 0; // zero return code means everything is ok
		} catch (\Exception $exc) {
			$output->writeLn("<error>{$exc->getMessage()}</error>");
			return 1; // non-zero return code means error
		}
	}

}
