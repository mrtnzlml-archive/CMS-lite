<?php

use Doctrine\Common\Persistence\ObjectManager;

class NavigationFixture extends \Doctrine\Common\DataFixtures\AbstractFixture
{

	//TODO: pak i další, než jen admin menu

	public function load(ObjectManager $manager)
	{
		$items = \Nette\Neon\Neon::decode(file_get_contents(__DIR__ . '/AdminMenu.neon'));
		$this->resolveMenu($manager, $items);
	}

	private function resolveMenu($manager, array $items, $parent_id = NULL)
	{
		foreach ($items as $menuItem) {
			if (isset($menuItem['path']) && isset($menuItem['destination'])) {
				$url = new \Url\Url;
				$url->setFakePath(isset($menuItem['path']) ? $menuItem['path'] : NULL);
				$url->setDestination(isset($menuItem['destination']) ? $menuItem['destination'] : NULL);
			}

			$item = new \Navigation\NavigationItem;
			$item->setName($menuItem['name']);
			$item->setUrl(isset($url) ? $url : NULL);
			$item->setIcon(isset($menuItem['icon']) ? $menuItem['icon'] : NULL);
			unset($url);

			$process = new \Navigation\NavigationFacade($manager);
			$process->createItem($item, $parent_id);

			if (isset($menuItem['subitems'])) {
				$this->resolveMenu($manager, $menuItem['subitems'], $item->getId());
			}
		}
	}

}
