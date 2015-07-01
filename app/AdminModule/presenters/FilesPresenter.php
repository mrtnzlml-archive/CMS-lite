<?php

namespace App\AdminModule\Presenters;

use App;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Nette\Application\Responses\JsonResponse;
use Files\FineUploader;        

/**
 * Description of FilesPresenter
 *
 * @author Miroslav Filipec
 */

final class FilesPresenter extends BasePresenter
{
        /** @var EntityManager */
	private $em;
        /** @var FineUploader */
        private $fineUploader;
        
        public function __construct(EntityManager $em, FineUploader $uploader)
        {
                $this->em = $em;
                $this->fineUploader = $uploader;
        }
        
        public function handleUpload()
        {
                $dir = $this->getContext()->parameters['wwwDir'] . '/upload/files';
                $result = $this->fineUploader->handleUpload($dir);
                $this->sendResponse(new JsonResponse($result));
        }
}
