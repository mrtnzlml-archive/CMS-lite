<?php

namespace App\FrontModule\Presenters;

class ContactPresenter extends BasePresenter
{

	protected function beforeRender()
	{
		parent::beforeRender();
		$this->setTitle('Kontakt');
	}

}
