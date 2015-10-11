<?php

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;

class PageCategoryFixture extends AbstractFixture implements DependentFixtureInterface
{

	public function load(ObjectManager $manager)
	{
		for ($iterator = 0; $iterator <= 50; $iterator++) {
			/** @var \Pages\Page $page */
			$page = $this->getReference('page-' . rand(0, 50));
			/** @var \Pages\Category $category */
			$category = $this->getReference('category-' . rand(0, 10));

			$pageCategory = new \Pages\PageCategory;
			$pageCategory->setPageOrder(rand(0, 10));

			$page->addPageCategory($pageCategory);
			$category->addPageCategory($pageCategory);

			$duplication = $manager->getRepository(\Pages\PageCategory::class)->findBy([
				'page' => $page,
				'category' => $category,
			]);
			if ($duplication) {
				$iterator--;
				$manager->clear();
				continue;
			}

			$manager->flush();
		}
	}

	public function getDependencies()
	{
		return [
			\PagesFixture::class,
			\CategoryFixture::class,
		];
	}

}
