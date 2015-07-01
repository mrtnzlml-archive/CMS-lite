<?php

namespace App\AdminModule\Presenters;

use App;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;

/**
 * Description of FilesPresenter
 *
 * @author Miroslav Filipec
 */

final class FilesPresenter extends BasePresenter
{
        /** @var EntityManager */
	private $em;
        
        public function __construct(EntityManager $em)
        {
                $this->em = $em;
        }
}
