<?php

namespace Navigation;

use Kdyby\Doctrine\EntityManager;
use Nette;

class NavigationFacade extends Nette\Object
{

	const ROOT_ADMIN = 'admin_root';

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
		//TODO: cache
	}

	public function getItemTreeBelow($itemId)
	{
		if (!is_numeric($itemId)) {
			throw new Nette\InvalidArgumentException(sprintf('Category ID should be numeric, %s given.', gettype($itemId)));
		}
		$query = $this->em->getRepository(NavigationItem::class)->createQuery('
			SELECT n, tree.depth FROM Navigation\NavigationItem n
				LEFT JOIN Navigation\NavigationTreePath tree
					WITH (n.id = tree.descendant)
				WHERE tree.ancestor = ?1 AND tree.depth > 0
		');
		$query->setParameter(1, $itemId);
		$menuItems = $query->getResult();

		$items = [];
		//TODO: to je na mě dnes moc
//		$iterator = 0;
//		foreach ($menuItems as $menuItem) {
//			if ($menuItem['depth'] > 1) {
//				unset($menuItem['depth']);
//				$items[$iterator - 1]['submenu'][] = $menuItem;
//			} else {
//				unset($menuItem['depth']);
//				$items[$iterator] = $menuItem;
//			}
//			$iterator++;
//		}
//
//		\Tracy\Debugger::$maxDepth = 10;
//		dump($items);
//		exit;

		return $items;
	}

	public function createItem(NavigationItem $item, $parent_id = NULL)
	{
		return $this->em->transactional(function () use ($item, $parent_id) {
			// 1) save new item
			$this->em->persist($item);
			$this->em->flush($item);

			// 2) create not connected leaf
			$leaf = new NavigationTreePath($item, $item, 0);
			$this->em->persist($leaf);
			$this->em->flush($leaf);

			//create admin root if doesn't exist
			$root = $this->em->getRepository(NavigationItem::class)->findOneBy(['name' => self::ROOT_ADMIN]);
			if (!$root) {
				$root = (new NavigationItem())->setName(self::ROOT_ADMIN);
				$rootPath = (new NavigationTreePath($root, $root, 0));
				$this->em->persist($rootPath);
				$this->em->flush($rootPath);
			}
			if ($parent_id === NULL) {
				$parent_id = $root->getId();
			}

			// 3) generate graph
			$table = $this->em->getClassMetadata(NavigationTreePath::class)->getTableName();
			$connection = $this->em->getConnection();
			$stmt = $connection->prepare("
					INSERT INTO $table (ancestor_id, descendant_id, depth)
						SELECT ancestor_id, :descSelect, depth+1 FROM $table
							WHERE descendant_id = :desc;
				");
			$stmt->bindValue('descSelect', $item->getId(), \Doctrine\DBAL\Types\Type::INTEGER);
			$stmt->bindValue('desc', $parent_id);
			$stmt->execute();

			return $item;
		});
	}

}
