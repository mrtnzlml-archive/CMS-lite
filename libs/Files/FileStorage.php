<?php

namespace Files;

use Nette\Object;
use Symfony\Component\Filesystem\Filesystem as IO;
use Symfony\Component\Filesystem\Exception\IOException;


class FileStorage extends Object
{
    /** @var IO */
    private $io;
    /** @var dir */
    private $dir;

    public function __construct($dir, IO $io)
    {
        $this->dir = $dir;
        $this->io = $io;
    }

    public function delete($uuid)
    {
        $destination = $this->dir . '/'. $uuid;
        if(!$this->io->exists($destination)) {
            return false;
        }

        try {
            $this->io->remove($destination);
            return true;
        } catch(IOException $e) {
            return false;
        }

    }
} 