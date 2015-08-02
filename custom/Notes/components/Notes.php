<?php

namespace Notes\Components;

use App\Components\AControl;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Notes\Note;
use Notes\Query\NotesQuery;

/**
 * @method onDelete(Notes $notes, integer $note_id)
 */
class Notes extends AControl
{

	/** @var \Closure[] */
	public $onDelete = [];

	/** @var EntityManager */
	private $em;

	/** @var integer */
	private $user_id;

	public function __construct($user_id, EntityManager $em)
	{
		$this->user_id = $user_id;
		$this->em = $em;
	}

	public function render(array $parameters = NULL)
	{
		$query = new NotesQuery($this->user_id);
		$notes = $this->em->getRepository(Note::class)->fetch($query);
		$this->template->notes = $notes;
		$this->template->render(__DIR__ . '/Notes.latte');
	}

	/**
	 * @secured
	 */
	public function handleDelete($note_id)
	{
		//TODO: Is user allowed to do so?
		$partialNote = $this->em->getPartialReference(Note::class, $note_id);
		$this->em->remove($partialNote);
		$this->em->flush($partialNote);
		$this->onDelete($this, $note_id);
	}

}

interface INotesFactory
{
	/** @return Notes */
	function create($user_id);
}
