<?php

namespace Pages;

use Kdyby\Doctrine\EntityManager;
use Nette;

/**
 * @see http://blog.voracek.net/databaze/closure-table-stromy-v-mysql-trochu-jinak/
 */
class PageCategoryProcess extends Nette\Object
{

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	public function getCategoryTreeBelow($categoryId)
	{
		if (!is_numeric($categoryId)) {
			throw new Nette\InvalidArgumentException(sprintf('Category ID should be numeric, %s given.', gettype($categoryId)));
		}
		$query = $this->em->getRepository(PageCategory::class)->createQuery('
			SELECT NEW PageCategoryDTO(c.id, c.name, c.createdAt, tree.depth) FROM \Pages\PageCategory c
				LEFT JOIN \Pages\PageCategoryTreePath tree
					WITH (c.id = tree.descendant)
				WHERE tree.ancestor = ?1
		');
		$query->setParameter(1, $categoryId);
		return $query->getResult();
	}

	public function getCategoryTreeAbove($categoryId)
	{
		if (!is_numeric($categoryId)) {
			throw new Nette\InvalidArgumentException(sprintf('Category ID should be numeric, %s given.', gettype($categoryId)));
		}
		$query = $this->em->getRepository(PageCategory::class)->createQuery('
			SELECT NEW PageCategoryDTO(c.id, c.name, c.createdAt, tree.depth) FROM \Pages\PageCategory c
				LEFT JOIN \Pages\PageCategoryTreePath tree
					WITH (c.id = tree.ancestor)
				WHERE tree.descendant = ?1
		');
		$query->setParameter(1, $categoryId);
		return $query->getResult();
	}

	/**
	 * @param $name
	 * @param null $parent_id
	 *
	 * @return bool|PageCategory
	 * @throws \Exception
	 */
	public function createCategory($name, $parent_id = NULL)
	{
		return $this->em->transactional(function () use ($name, $parent_id) {

			/** @var PageCategory $category */
			$category = (new PageCategory)->setName($name);
			$this->em->persist($category);
			$this->em->flush($category);
			$id = $category->getId();

			$leaf = new PageCategoryTreePath($category, $category, 0);
			$this->em->persist($leaf);
			$this->em->flush($leaf);

			if ($parent_id !== NULL) {
				$table = $this->em->getClassMetadata(PageCategoryTreePath::class)->getTableName();
				$connection = $this->em->getConnection();
				$stmt = $connection->prepare("
					INSERT INTO $table (ancestor_id, descendant_id, depth)
						SELECT ancestor_id, :descSelect, depth+1 FROM $table
							WHERE descendant_id = :desc;
				");
				$stmt->bindValue('descSelect', $id, \Doctrine\DBAL\Types\Type::INTEGER);
				$stmt->bindValue('desc', $parent_id);
				$stmt->execute();
			}

			return $category;
		});
	}

	//TODO: Smazání celého podstromu

	//TODO: Smazání jednoho prvku a navázání jeho potomků na jeho rodiče

	//TODO: Přesunutí podstromu

	//TODO: Identifikace kořene a listu

}
