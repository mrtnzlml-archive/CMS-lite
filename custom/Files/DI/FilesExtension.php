<?php

namespace Files\DI;

use App\Extensions\CompilerExtension;
use App\Extensions\Extension;
use App\Extensions\ICustomExtension;
use Kdyby;
use Kdyby\Doctrine\DI\IEntityProvider;
use Nette;

class FilesExtension extends CompilerExtension implements IEntityProvider, ICustomExtension
{

    public function getExtensionInfo()
    {
        return (new Extension)->setName(self::class);
    }

    public function loadConfiguration()
    {
        $builder = $this->getContainerBuilder();
        $this->parseConfig($builder, __DIR__ . '/services.neon');
    }

    public function beforeCompile()
    {
        $builder = $this->getContainerBuilder();
        $this->setPresenterMapping($builder, ['Files' => 'Files\\*Module\\Presenters\\*Presenter']);
    }

    /**
     * Returns associative array of Namespace => mapping definition
     *
     * @return array
     */
    public function getEntityMappings()
    {
        return [
            'Files' => __DIR__ . '/..',
        ];
    }
}
