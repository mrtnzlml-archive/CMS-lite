<?php

namespace Pages;

use Doctrine\DBAL\Types\Type;
use Kdyby\Doctrine\EntityManager;
use Nette;

/**
 * @see http://blog.voracek.net/databaze/closure-table-stromy-v-mysql-trochu-jinak/
 */
class CategoryProcess extends Nette\Object
{

	/** @var EntityManager */
	private $em;

	public function __construct(EntityManager $em)
	{
		$this->em = $em;
	}

	/**
	 * @param $name
	 * @param null $parent_id
	 *
	 * @return bool|Category
	 * @throws \Exception
	 */
	public function createCategory($name, $parent_id = NULL)
	{
		return $this->em->transactional(function () use ($name, $parent_id) {

			/** @var Category $category */
			$category = (new Category)->setName($name);
			$this->em->persist($category);
			$this->em->flush($category);
			$id = $category->getId();

			$leaf = new CategoryTreePath($category, $category, 0);
			$this->em->persist($leaf);
			$this->em->flush($leaf);

			if ($parent_id !== NULL) {
				$table = $this->em->getClassMetadata(CategoryTreePath::class)->getTableName();
				$connection = $this->em->getConnection();

				$sql = <<<SQL
INSERT INTO $table (ancestor_id, descendant_id, depth)
SELECT ancestor_id, :descSelect, depth+1 FROM $table
WHERE descendant_id = :desc;
SQL;

				$connection->executeUpdate($sql, [
					'descSelect' => $id,
					'desc' => $parent_id,
				], ['descSelect' => Type::INTEGER]);
			}

			return $category;
		});
	}

}
