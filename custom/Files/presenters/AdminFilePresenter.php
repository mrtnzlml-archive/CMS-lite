<?php
namespace Files\Presenters;

use Nette;
use App;
use App\Components\Flashes\Flashes;
use App\AdminModule\Presenters\BasePresenter;
use Kdyby\Doctrine\EntityManager;
use Tracy\OutputDebugger;

class AdminFilePresenter extends BasePresenter
{
    /** @var EntityManager */
    private $em;

    public function __construct(EntityManager $em)
    {
        $this->em = $em;
    }

    public function renderDefault()
    {

    }
} 