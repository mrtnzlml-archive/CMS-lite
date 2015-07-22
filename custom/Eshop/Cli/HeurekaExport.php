<?php

namespace Eshop\Cli;

use Eshop\Delivery;
use Eshop\Product;
use Kdyby\Doctrine\EntityManager;
use Nette\DI\Container;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class HeurekaExport extends Command
{

	/** @var EntityManager @inject */
	public $em;

	/** @var Container @inject */
	public $dic;

	protected function configure()
	{
		$this->setName('cms:eshop:heureka:export');
	}

	protected function execute(InputInterface $input, OutputInterface $output)
	{
		try {
			$xml = fopen($this->dic->expand('nette.safe://%wwwDir%/sitemap.xml'), 'wb');
			$write = function ($content, $newline = "\n") use ($xml) {
				fwrite($xml, $content . $newline);
			};
			$write('<?xml version="1.0" encoding="utf-8"?>');
			$write('<SHOP>');
			$output->writeln("  <comment>></comment> <info>generating eshop items</info>");
			$products = $this->em->getRepository(Product::class)->findBy([]); //TODO: query object!
			/** @var Product $products */
			foreach ($products as $product) {
				$this->writeItem($product, $xml);
			}
			$write('</SHOP>');
			fclose($xml);
			$output->writeln("  <comment>></comment> <info>sitemap.xml sucessfully generated</info>");
			return 0; // zero return code means everything is ok
		} catch (\Exception $exc) {
			$output->writeLn("<error>{$exc->getMessage()}</error>");
			return 1; // non-zero return code means error
		}
	}

	/**
	 * @param Product $product
	 * @param $xml
	 * @param string $newline
	 *
	 * @see http://sluzby.heureka.cz/napoveda/xml-feed/
	 */
	private function writeItem(Product $product, $xml, $newline = "\n")
	{
		fwrite($xml, "\t<SHOPITEM>" . $newline);
		fwrite($xml, sprintf("\t\t<ITEM_ID>%s</ITEM_ID>", $product->id) . $newline);
		fwrite($xml, sprintf("\t\t<PRODUCTNAME>%s</PRODUCTNAME>", $product->getTitle()) . $newline);
		fwrite($xml, sprintf("\t\t<PRODUCT>%s</PRODUCT>", $product->getTitle()) . $newline);
		fwrite($xml, sprintf("\t\t<DESCRIPTION>%s</DESCRIPTION>", $product->getDescription()) . $newline);
		fwrite($xml, sprintf("\t\t<CATEGORYTEXT>%s</CATEGORYTEXT>", 'TODO') . $newline);
		fwrite($xml, sprintf("\t\t<DELIVERY_DATE>%s</DELIVERY_DATE>", 'TODO') . $newline);
		foreach ($product->getDeliveries() as $delivery) {
			$this->writeDelivery($delivery, $xml);
		}
		//TODO: IMGURL_ALTERNATIVE, VIDEO_URL, ACCESSORY
		fwrite($xml, sprintf("\t\t<ITEMGROUP_ID>%s</ITEMGROUP_ID>", 'TODO') . $newline);
		//TODO: a další...
		fwrite($xml, "\t</SHOPITEM>" . $newline);
	}

	/**
	 * @param Delivery $delivery
	 * @param $xml
	 * @param string $newline
	 *
	 * @see http://sluzby.heureka.cz/napoveda/xml-feed/#DELIVERY
	 */
	private function writeDelivery(Delivery $delivery, $xml, $newline = "\n")
	{
		fwrite($xml, "\t\t<DELIVERY>" . $newline);
		fwrite($xml, sprintf("\t\t\t<DELIVERY_ID>%s</DELIVERY_ID>", $delivery->getDeliveryId()) . $newline);
		fwrite($xml, sprintf("\t\t\t<DELIVERY_PRICE>%s</DELIVERY_PRICE>", $delivery->getDeliveryPrice()) . $newline);
		fwrite($xml, sprintf("\t\t\t<DELIVERY_PRICE_COD>%s</DELIVERY_PRICE_COD>", 'TODO') . $newline);
		fwrite($xml, "\t\t</DELIVERY>" . $newline);
	}

}
