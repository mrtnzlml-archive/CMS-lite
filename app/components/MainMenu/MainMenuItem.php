<?php

class MainMenuItem extends \Nette\Object
{

	private $title;

	private $link;

	public function getTitle()
	{
		return $this->title;
	}

	public function setTitle($title)
	{
		$this->title = $title;
		return $this;
	}

	public function getLink()
	{
		return $this->link;
	}

	public function setLink($link)
	{
		$this->link = $link;
		return $this;
	}

}
