<?php

namespace Navigation;

use Kdyby\Doctrine\EntityManager;
use Nette;

/**
 * @see http://blog.voracek.net/databaze/closure-table-stromy-v-mysql-trochu-jinak/
 */
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
			SELECT n, IDENTITY(tree2.ancestor), IDENTITY(tree1.descendant) FROM Navigation\NavigationItem n
			LEFT JOIN Navigation\NavigationTreePath tree1 WITH (n.id = tree1.descendant)
			LEFT JOIN Navigation\NavigationTreePath tree2 WITH (tree2.descendant = tree1.descendant AND tree2.depth = 1)
		  	WHERE tree1.ancestor = ?1 AND tree1.depth > 0
		');
		$query->setParameter(1, $itemId);
		$menuItems = $query->getResult();

		// Compute graph
		$nodes = [];
		foreach ($menuItems as $menuItem) {
			$nodes[$menuItem[2]]['entity'] = $menuItem[0];
		}
		//TODO: další úrovně zanoření
		foreach ($menuItems as $menuItem) {
			if (array_key_exists($menuItem[1], $nodes)) {
				$nodes[$menuItem[1]]['descendants'][$menuItem[2]] = $menuItem[0];
				unset($nodes[$menuItem[2]]);
			}
		}

		return Nette\Utils\ArrayHash::from($nodes);
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
			$this->createPath($parent_id, $item->getId());

			return $item;
		});
	}

	public function recalculatePathsForNode($nodeId, $nodeIds)
	{
		//DELETE t1 FROM navigation_tree_path t1 JOIN navigation_tree_path t2 USING (descendant_id) WHERE (t2.ancestor_id = 50 AND t1.depth > 0);
		$connection = $this->em->getConnection();
		$stmt = $connection->prepare("
			DELETE t1 FROM navigation_tree_path t1
			JOIN navigation_tree_path t2 USING (descendant_id) WHERE (t2.ancestor_id = :ancestor AND t1.depth > 0);
		");
		$stmt->bindValue('ancestor', $nodeId, \Doctrine\DBAL\Types\Type::INTEGER);
		$stmt->execute();
		$this->calculatePaths($nodeId, $nodeIds);
	}

	private function calculatePaths($root, array $nodeIds)
	{
		foreach ($nodeIds as $key => $id) {
			if (!is_array($id)) {
				$this->createPath($root, $id);
			} else {
				$this->createPath($root, $key);
				$this->calculatePaths($key, $id);
			}
		}
	}

	private function createPath($parent_id, $item_id)
	{
		$connection = $this->em->getConnection();
		$stmt = $connection->prepare('
			INSERT INTO navigation_tree_path (ancestor_id, descendant_id, depth)
			SELECT ancestor_id, :descSelect, depth+1 FROM navigation_tree_path
			WHERE descendant_id = :desc;
		');
		$stmt->bindValue('descSelect', $item_id, \Doctrine\DBAL\Types\Type::INTEGER);
		$stmt->bindValue('desc', $parent_id);
		$stmt->execute();
	}

}
