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

	public function getCategoryTreeBelow($categoryId)
	{
		if (!is_numeric($categoryId)) {
			throw new Nette\InvalidArgumentException(sprintf('Category ID should be numeric, %s given.', gettype($categoryId)));
		}
		$query = $this->em->getRepository(Category::class)->createQuery('
			SELECT NEW CategoryDTO(c.id, c.name, c.createdAt, tree.depth) FROM \Pages\Category c
			LEFT JOIN \Pages\PageCategoryTreePath tree WITH (c.id = tree.descendant)
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
		$query = $this->em->getRepository(Category::class)->createQuery('
			SELECT NEW CategoryDTO(c.id, c.name, c.createdAt, tree.depth) FROM \Pages\Category c
			LEFT JOIN \Pages\PageCategoryTreePath tree WITH (c.id = tree.ancestor)
			WHERE tree.descendant = ?1
		');
		$query->setParameter(1, $categoryId);
		return $query->getResult();
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

			$category->setUrl(\Url\RouteGenerator::generate( //FIXME: generovat pouze pokud neexistuje
				Nette\Utils\Strings::webalize($name), //fakePath
				'Pages:Front:Category:default', //destination
				$id //internalId
			));

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

	//TODO: Smazání celého podstromu

	//TODO: Smazání jednoho prvku a navázání jeho potomků na jeho rodiče

	//TODO: Přesunutí podstromu

	//TODO: Identifikace kořene a listu

}
