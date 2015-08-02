<?php

namespace Options\Components\AclForm;

use App\Components\Flashes\Flashes;
use Kdyby\Doctrine\EntityManager;
use Nette;
use Nette\Application\UI;
use Nette\Caching\IStorage;
use Nextras\Application\UI\SecuredLinksControlTrait;
use Users\Authorizator;
use Users\Permission;

class Acl extends UI\Control
{

	use SecuredLinksControlTrait;

	/** @var EntityManager */
	private $em;

	/** @var Nette\Caching\Cache */
	private $cache;

	private $permissions;

	public function __construct(EntityManager $em, IStorage $cacheStorage)
	{
		$this->em = $em;
		$this->cache = new Nette\Caching\Cache($cacheStorage, Authorizator::CACHE_NAMESPACE);

		$qb = $em->getRepository(Permission::class)->createQueryBuilder('p', 'p.id');
		$qb->leftJoin('p.role', 'ro')->addSelect('ro');
		$qb->leftJoin('p.resource', 're')->addSelect('re');
		$qb->orderBy('p.role', 'DESC');

		$this->permissions = $qb->getQuery()->getResult();
	}

	public function render()
	{
		$this->template->permissions = $this->permissions;
		$this->template->render(__DIR__ . '/Acl.latte');
	}

	/**
	 * @return UI\Form
	 */
	protected function createComponentAclForm()
	{
		$form = new UI\Form();

		/** @var Permission $permission */
		foreach ($this->permissions as $permission) {
			$form->addSelect('method_' . $permission->getId(), NULL, [1 => 'allow', 0 => 'deny']);
			$form->addCheckbox('read_' . $permission->getId(), NULL)->setDefaultValue($permission->getRead());
			$form->addCheckbox('write_' . $permission->getId(), NULL)->setDefaultValue($permission->getWrite());
			$form->addCheckbox('create_' . $permission->getId(), NULL)->setDefaultValue($permission->getCreate());
			$form->addCheckbox('delete_' . $permission->getId(), NULL)->setDefaultValue($permission->getDelete());
		}

		$form->addSubmit('save', 'Uložit změny');
		$form->onSuccess[] = function ($_, Nette\Utils\ArrayHash $values) {
			/** @var Permission $permission */
			foreach ($this->permissions as $permission) {
				$permission->setAllow($values['method_' . $permission->getId()]);
				$permission->setRead($values['read_' . $permission->getId()]);
				$permission->setWrite($values['write_' . $permission->getId()]);
				$permission->setCreate($values['create_' . $permission->getId()]);
				$permission->setDelete($values['delete_' . $permission->getId()]);
				$this->em->persist($permission);
			}
			$this->em->flush();
			$this->cache->clean([Nette\Caching\Cache::TAGS => [Authorizator::CACHE_NAMESPACE . '/permissions']]);
			$this->presenter->flashMessage('Změny úspěšně uloženy', Flashes::FLASH_SUCCESS);
			$this->redirect('this');
		};

		return $form;
	}

	/**
	 * @secured
	 */
	public function handleDelete($id)
	{
		$partialEntity = $this->em->getPartialReference(Permission::class, $id);
		$this->em->remove($partialEntity);
		$this->em->flush($partialEntity);
		$this->presenter->flashMessage('Pravidlo bylo úspěšně smazáno', Flashes::FLASH_SUCCESS);
		$this->redirect('this');
	}

}

interface IAclFactory
{
	/** @return Acl */
	function create();
}
