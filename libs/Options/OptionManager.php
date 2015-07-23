<?php

namespace Options;

use Kdyby\Doctrine\EntityManager;
use Nette\Object;
use Pages\Query\OptionsQuery;


class OptionManager extends Object
{
    /** @var EntityManager */
    private $em;

    public function __construct(EntityManager $em)
    {
        $this->em = $em;
    }

    public function getFileOptions()
    {
        $query = (new OptionsQuery())->withOptions([
            Option::KEY_FILE_MAXFILESIZE,
            Option::KEY_FILE_DOWNLOAD_PROTECTED,
            Option::KEY_FILE_ALLOWED_EXTENSIONS
        ]);

        return $this->em->getRepository(Option::class)
            ->fetch($query)
            ->toArray();
    }
} 