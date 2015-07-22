/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50616
Source Host           : localhost:3306
Source Database       : ant_cms

Target Server Type    : MYSQL
Target Server Version : 50616
File Encoding         : 65001

Date: 2015-07-23 01:19:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `deliveries`
-- ----------------------------
DROP TABLE IF EXISTS `deliveries`;
CREATE TABLE `deliveries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the delivery',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Human readable name of the delivery',
  `delivery_price` decimal(10,2) NOT NULL COMMENT 'Delivery price including VAT!',
  `heureka` tinyint(1) NOT NULL COMMENT 'Heureka acceptable?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_6F07856812136921` (`delivery_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of deliveries
-- ----------------------------
INSERT INTO `deliveries` VALUES ('1', 'CESKA_POSTA', 'Česká pošta', '228.50', '1');
INSERT INTO `deliveries` VALUES ('2', 'CESKA_POSTA_NA_POSTU', 'Česká pošta - Balík Na poštu', '140.90', '1');
INSERT INTO `deliveries` VALUES ('3', 'CSAD_LOGISTIK_OSTRAVA', 'ČSAD Logistik Ostrava', '239.60', '1');
INSERT INTO `deliveries` VALUES ('4', 'DPD', 'DPD', '102.10', '1');
INSERT INTO `deliveries` VALUES ('5', 'DHL', 'DHL', '165.90', '1');
INSERT INTO `deliveries` VALUES ('6', 'DSV', 'DSV', '154.50', '1');
INSERT INTO `deliveries` VALUES ('7', 'EMS', 'EMS', '135.10', '1');
INSERT INTO `deliveries` VALUES ('8', 'FOFR', 'FOFR', '117.90', '1');
INSERT INTO `deliveries` VALUES ('9', 'GEBRUDER_WEISS', 'Gebrüder Weiss', '231.50', '1');
INSERT INTO `deliveries` VALUES ('10', 'GEIS', 'Geis', '176.20', '1');
INSERT INTO `deliveries` VALUES ('11', 'GENERAL_PARCEL', 'General Parcel', '146.60', '1');
INSERT INTO `deliveries` VALUES ('12', 'GLS', 'GLS', '217.10', '1');
INSERT INTO `deliveries` VALUES ('13', 'HDS', 'HDS', '226.50', '1');
INSERT INTO `deliveries` VALUES ('14', 'HEUREKAPOINT', 'HeurekaPoint', '104.30', '1');
INSERT INTO `deliveries` VALUES ('15', 'INTIME', 'InTime', '191.70', '1');
INSERT INTO `deliveries` VALUES ('16', 'PPL', 'PPL', '103.80', '1');
INSERT INTO `deliveries` VALUES ('17', 'RADIALKA', 'Radiálka', '184.80', '1');
INSERT INTO `deliveries` VALUES ('18', 'SEEGMULLER', 'Seegmuller', '224.80', '1');
INSERT INTO `deliveries` VALUES ('19', 'TNT', 'TNT', '110.50', '1');
INSERT INTO `deliveries` VALUES ('20', 'TOPTRANS', 'TOPTRANS', '180.50', '1');
INSERT INTO `deliveries` VALUES ('21', 'UPS', 'UPS', '217.90', '1');
INSERT INTO `deliveries` VALUES ('22', 'VLASTNI_PREPRAVA', 'Vlastní přeprava', '125.60', '1');

-- ----------------------------
-- Table structure for `domain`
-- ----------------------------
DROP TABLE IF EXISTS `domain`;
CREATE TABLE `domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A7A91E0BCF2713FD` (`host`),
  UNIQUE KEY `UNIQ_A7A91E0B4180C698` (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of domain
-- ----------------------------

-- ----------------------------
-- Table structure for `extension`
-- ----------------------------
DROP TABLE IF EXISTS `extension`;
CREATE TABLE `extension` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `template` tinyint(1) NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of extension
-- ----------------------------

-- ----------------------------
-- Table structure for `files`
-- ----------------------------
DROP TABLE IF EXISTS `files`;
CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sanitized_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `uuid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `size` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `extension` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6354059A76ED395` (`user_id`),
  CONSTRAINT `FK_6354059A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of files
-- ----------------------------

-- ----------------------------
-- Table structure for `locale`
-- ----------------------------
DROP TABLE IF EXISTS `locale`;
CREATE TABLE `locale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Code of the language',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the language',
  `default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of locale
-- ----------------------------
INSERT INTO `locale` VALUES ('1', 'cz', 'Čeština', '1');
INSERT INTO `locale` VALUES ('2', 'en', 'English', '0');

-- ----------------------------
-- Table structure for `navigation`
-- ----------------------------
DROP TABLE IF EXISTS `navigation`;
CREATE TABLE `navigation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of navigation
-- ----------------------------
INSERT INTO `navigation` VALUES ('1', 'Administrace - Hlavní menu');
INSERT INTO `navigation` VALUES ('2', 'Front - Hlavní menu');

-- ----------------------------
-- Table structure for `navigation_item`
-- ----------------------------
DROP TABLE IF EXISTS `navigation_item`;
CREATE TABLE `navigation_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url_id` int(11) DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `root` tinyint(1) NOT NULL,
  `external_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_289BF06C81CFDAE7` (`url_id`),
  CONSTRAINT `FK_289BF06C81CFDAE7` FOREIGN KEY (`url_id`) REFERENCES `urls` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of navigation_item
-- ----------------------------
INSERT INTO `navigation_item` VALUES ('1', '14', 'ai-home60', 'Nástěnka', '0', null);
INSERT INTO `navigation_item` VALUES ('2', null, null, '91c58f4b806d3994175332260c2fed5b', '1', null);
INSERT INTO `navigation_item` VALUES ('3', null, 'flaticon-document236', 'Obsah', '0', null);
INSERT INTO `navigation_item` VALUES ('4', '15', null, 'Stránky', '0', null);
INSERT INTO `navigation_item` VALUES ('5', '16', null, 'Nová stránka', '0', null);
INSERT INTO `navigation_item` VALUES ('6', '17', null, 'Navigace', '0', null);
INSERT INTO `navigation_item` VALUES ('7', '18', 'flaticon-user8', 'Uživatelé', '0', null);
INSERT INTO `navigation_item` VALUES ('8', '19', 'flaticon-gear39', 'Nastavení', '0', null);
INSERT INTO `navigation_item` VALUES ('9', '20', null, 'Home', '0', null);
INSERT INTO `navigation_item` VALUES ('10', null, null, '03722e499d85e46eb6e084b2c1b7dd81', '1', null);
INSERT INTO `navigation_item` VALUES ('11', '21', null, 'Kontakt', '0', null);
INSERT INTO `navigation_item` VALUES ('12', '3', null, 'Soubory', '0', null);

-- ----------------------------
-- Table structure for `navigation_item_navigation`
-- ----------------------------
DROP TABLE IF EXISTS `navigation_item_navigation`;
CREATE TABLE `navigation_item_navigation` (
  `item_id` int(11) NOT NULL,
  `navigation_id` int(11) NOT NULL,
  PRIMARY KEY (`item_id`,`navigation_id`),
  KEY `IDX_2A01821126F525E` (`item_id`),
  KEY `IDX_2A0182139F79D6D` (`navigation_id`),
  CONSTRAINT `FK_2A0182139F79D6D` FOREIGN KEY (`navigation_id`) REFERENCES `navigation` (`id`),
  CONSTRAINT `FK_2A01821126F525E` FOREIGN KEY (`item_id`) REFERENCES `navigation_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of navigation_item_navigation
-- ----------------------------
INSERT INTO `navigation_item_navigation` VALUES ('1', '1');
INSERT INTO `navigation_item_navigation` VALUES ('2', '1');
INSERT INTO `navigation_item_navigation` VALUES ('3', '1');
INSERT INTO `navigation_item_navigation` VALUES ('4', '1');
INSERT INTO `navigation_item_navigation` VALUES ('5', '1');
INSERT INTO `navigation_item_navigation` VALUES ('6', '1');
INSERT INTO `navigation_item_navigation` VALUES ('7', '1');
INSERT INTO `navigation_item_navigation` VALUES ('8', '1');
INSERT INTO `navigation_item_navigation` VALUES ('9', '2');
INSERT INTO `navigation_item_navigation` VALUES ('10', '2');
INSERT INTO `navigation_item_navigation` VALUES ('11', '2');

-- ----------------------------
-- Table structure for `navigation_tree_path`
-- ----------------------------
DROP TABLE IF EXISTS `navigation_tree_path`;
CREATE TABLE `navigation_tree_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ancestor_id` int(11) DEFAULT NULL,
  `descendant_id` int(11) DEFAULT NULL,
  `depth` int(11) NOT NULL,
  `item_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_577DA088C671CEA1` (`ancestor_id`),
  KEY `IDX_577DA0881844467D` (`descendant_id`),
  CONSTRAINT `FK_577DA0881844467D` FOREIGN KEY (`descendant_id`) REFERENCES `navigation_item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_577DA088C671CEA1` FOREIGN KEY (`ancestor_id`) REFERENCES `navigation_item` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of navigation_tree_path
-- ----------------------------
INSERT INTO `navigation_tree_path` VALUES ('1', '1', '1', '0', '0');
INSERT INTO `navigation_tree_path` VALUES ('2', '2', '2', '0', '0');
INSERT INTO `navigation_tree_path` VALUES ('3', '2', '1', '1', '0');
INSERT INTO `navigation_tree_path` VALUES ('4', '3', '3', '0', '0');
INSERT INTO `navigation_tree_path` VALUES ('5', '2', '3', '1', '0');
INSERT INTO `navigation_tree_path` VALUES ('6', '4', '4', '0', '0');
INSERT INTO `navigation_tree_path` VALUES ('7', '3', '4', '1', '0');
INSERT INTO `navigation_tree_path` VALUES ('8', '2', '4', '2', '0');
INSERT INTO `navigation_tree_path` VALUES ('10', '5', '5', '0', '0');
INSERT INTO `navigation_tree_path` VALUES ('11', '3', '5', '1', '0');
INSERT INTO `navigation_tree_path` VALUES ('12', '2', '5', '2', '0');
INSERT INTO `navigation_tree_path` VALUES ('14', '6', '6', '0', '0');
INSERT INTO `navigation_tree_path` VALUES ('15', '2', '6', '1', '0');
INSERT INTO `navigation_tree_path` VALUES ('16', '7', '7', '0', '0');
INSERT INTO `navigation_tree_path` VALUES ('17', '2', '7', '1', '0');
INSERT INTO `navigation_tree_path` VALUES ('18', '8', '8', '0', '0');
INSERT INTO `navigation_tree_path` VALUES ('19', '2', '8', '1', '0');
INSERT INTO `navigation_tree_path` VALUES ('20', '9', '9', '0', '0');
INSERT INTO `navigation_tree_path` VALUES ('21', '10', '10', '0', '0');
INSERT INTO `navigation_tree_path` VALUES ('22', '10', '9', '1', '0');
INSERT INTO `navigation_tree_path` VALUES ('23', '11', '11', '0', '0');
INSERT INTO `navigation_tree_path` VALUES ('24', '10', '11', '1', '0');

-- ----------------------------
-- Table structure for `note`
-- ----------------------------
DROP TABLE IF EXISTS `note`;
CREATE TABLE `note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the note',
  `body` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Full text of the note',
  `created_at` datetime NOT NULL COMMENT 'Date of the note creation',
  PRIMARY KEY (`id`),
  KEY `IDX_CFBDFA14A76ED395` (`user_id`),
  CONSTRAINT `FK_CFBDFA14A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of note
-- ----------------------------

-- ----------------------------
-- Table structure for `options`
-- ----------------------------
DROP TABLE IF EXISTS `options`;
CREATE TABLE `options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Key of the option',
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Description of the option (form label)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D035FA874E645A7E` (`key`),
  KEY `IDX_D035FA8712469DE2` (`category_id`),
  CONSTRAINT `FK_D035FA8712469DE2` FOREIGN KEY (`category_id`) REFERENCES `option_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of options
-- ----------------------------
INSERT INTO `options` VALUES ('1', '1', 'site_title', 'Název webu');
INSERT INTO `options` VALUES ('2', '1', 'site_title_separator', 'Oddělovač titulku');
INSERT INTO `options` VALUES ('3', '2', 'index', 'Indexovat web');
INSERT INTO `options` VALUES ('4', '2', 'page_url_end', 'Koncovka URL stránek');
INSERT INTO `options` VALUES ('5', '2', 'category_url_end', 'Koncovka URL kategorií');

-- ----------------------------
-- Table structure for `option_categories`
-- ----------------------------
DROP TABLE IF EXISTS `option_categories`;
CREATE TABLE `option_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the option category',
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nice name of the option category',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D79A5E585E237E06` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of option_categories
-- ----------------------------
INSERT INTO `option_categories` VALUES ('1', 'general', 'Obecné');
INSERT INTO `option_categories` VALUES ('2', 'seo', 'SEO');

-- ----------------------------
-- Table structure for `option_value`
-- ----------------------------
DROP TABLE IF EXISTS `option_value`;
CREATE TABLE `option_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option_id` int(11) DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Value of the option',
  `selected` tinyint(1) NOT NULL COMMENT 'Should be this value used as selected?',
  PRIMARY KEY (`id`),
  KEY `IDX_249CE55CA7C41D6F` (`option_id`),
  CONSTRAINT `FK_249CE55CA7C41D6F` FOREIGN KEY (`option_id`) REFERENCES `options` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of option_value
-- ----------------------------
INSERT INTO `option_value` VALUES ('1', '1', 'ANTstudio CMS', '0');
INSERT INTO `option_value` VALUES ('2', '2', '|', '0');
INSERT INTO `option_value` VALUES ('3', '3', '1', '0');
INSERT INTO `option_value` VALUES ('4', '4', null, '0');
INSERT INTO `option_value` VALUES ('5', '4', '/', '0');
INSERT INTO `option_value` VALUES ('6', '4', '.htm', '0');
INSERT INTO `option_value` VALUES ('7', '4', '.html', '0');
INSERT INTO `option_value` VALUES ('8', '5', null, '0');
INSERT INTO `option_value` VALUES ('9', '5', '/', '0');
INSERT INTO `option_value` VALUES ('10', '5', '.htm', '0');
INSERT INTO `option_value` VALUES ('11', '5', '.html', '0');

-- ----------------------------
-- Table structure for `orders`
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for `pages`
-- ----------------------------
DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `url_id` int(11) DEFAULT NULL,
  `locale_id` int(11) DEFAULT NULL,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the article',
  `individual_title` longtext COLLATE utf8_unicode_ci COMMENT 'Meta title of the article',
  `description` longtext COLLATE utf8_unicode_ci COMMENT 'Meta description of the article',
  `body` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Body of the article',
  `index` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Meta robots - index value',
  `follow` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Meta robots - follow value',
  `created_at` datetime NOT NULL COMMENT 'Date of the article creation',
  `published_at` datetime DEFAULT NULL COMMENT 'Date of the article publication',
  `individual_css_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Individual CSS IDs in body element',
  `individual_css_class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Individual CSS classes in body element',
  `protected` tinyint(1) NOT NULL COMMENT 'Is this page protected by password?',
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2074E57581CFDAE7` (`url_id`),
  KEY `IDX_2074E575A76ED395` (`user_id`),
  KEY `IDX_2074E575E559DFD1` (`locale_id`),
  CONSTRAINT `FK_2074E575E559DFD1` FOREIGN KEY (`locale_id`) REFERENCES `locale` (`id`),
  CONSTRAINT `FK_2074E57581CFDAE7` FOREIGN KEY (`url_id`) REFERENCES `urls` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_2074E575A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of pages
-- ----------------------------

-- ----------------------------
-- Table structure for `page_categories`
-- ----------------------------
DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of page_categories
-- ----------------------------

-- ----------------------------
-- Table structure for `page_category_tree_path`
-- ----------------------------
DROP TABLE IF EXISTS `page_category_tree_path`;
CREATE TABLE `page_category_tree_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ancestor_id` int(11) DEFAULT NULL,
  `descendant_id` int(11) DEFAULT NULL,
  `depth` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_263D11BEC671CEA1` (`ancestor_id`),
  KEY `IDX_263D11BE1844467D` (`descendant_id`),
  CONSTRAINT `FK_263D11BE1844467D` FOREIGN KEY (`descendant_id`) REFERENCES `page_categories` (`id`),
  CONSTRAINT `FK_263D11BEC671CEA1` FOREIGN KEY (`ancestor_id`) REFERENCES `page_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of page_category_tree_path
-- ----------------------------

-- ----------------------------
-- Table structure for `page_page_category`
-- ----------------------------
DROP TABLE IF EXISTS `page_page_category`;
CREATE TABLE `page_page_category` (
  `page_id` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  PRIMARY KEY (`page_id`,`category`),
  KEY `IDX_17096EDAC4663E4` (`page_id`),
  KEY `IDX_17096EDA64C19C1` (`category`),
  CONSTRAINT `FK_17096EDA64C19C1` FOREIGN KEY (`category`) REFERENCES `page_categories` (`id`),
  CONSTRAINT `FK_17096EDAC4663E4` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of page_page_category
-- ----------------------------

-- ----------------------------
-- Table structure for `page_tag`
-- ----------------------------
DROP TABLE IF EXISTS `page_tag`;
CREATE TABLE `page_tag` (
  `page_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`page_id`,`tag_id`),
  KEY `IDX_CF36BF12C4663E4` (`page_id`),
  KEY `IDX_CF36BF12BAD26311` (`tag_id`),
  CONSTRAINT `FK_CF36BF12BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`),
  CONSTRAINT `FK_CF36BF12C4663E4` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of page_tag
-- ----------------------------

-- ----------------------------
-- Table structure for `page_user`
-- ----------------------------
DROP TABLE IF EXISTS `page_user`;
CREATE TABLE `page_user` (
  `page_id` int(11) NOT NULL,
  `author` int(11) NOT NULL,
  PRIMARY KEY (`page_id`,`author`),
  KEY `IDX_A57CA93C4663E4` (`page_id`),
  KEY `IDX_A57CA93BDAFD8C8` (`author`),
  CONSTRAINT `FK_A57CA93BDAFD8C8` FOREIGN KEY (`author`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_A57CA93C4663E4` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of page_user
-- ----------------------------

-- ----------------------------
-- Table structure for `products`
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the product',
  `slug` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Webalized title (slug) of the product',
  `description` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Long description of the product',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of products
-- ----------------------------

-- ----------------------------
-- Table structure for `product_delivery`
-- ----------------------------
DROP TABLE IF EXISTS `product_delivery`;
CREATE TABLE `product_delivery` (
  `product_id` int(11) NOT NULL,
  `delivery` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`delivery`),
  KEY `IDX_FC3186874584665A` (`product_id`),
  KEY `IDX_FC3186873781EC10` (`delivery`),
  CONSTRAINT `FK_FC3186873781EC10` FOREIGN KEY (`delivery`) REFERENCES `deliveries` (`id`),
  CONSTRAINT `FK_FC3186874584665A` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of product_delivery
-- ----------------------------

-- ----------------------------
-- Table structure for `product_variants`
-- ----------------------------
DROP TABLE IF EXISTS `product_variants`;
CREATE TABLE `product_variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `variant_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the product variant (e.g. red-wool).',
  `sku` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'SKU – Stock Keeping Unit',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_78283976F9038C4` (`sku`),
  KEY `IDX_782839764584665A` (`product_id`),
  CONSTRAINT `FK_782839764584665A` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of product_variants
-- ----------------------------

-- ----------------------------
-- Table structure for `product_variant_variant_value`
-- ----------------------------
DROP TABLE IF EXISTS `product_variant_variant_value`;
CREATE TABLE `product_variant_variant_value` (
  `productVariant_id` int(11) NOT NULL,
  `variantValue` int(11) NOT NULL,
  PRIMARY KEY (`productVariant_id`,`variantValue`),
  KEY `IDX_303C2AAE5708BDEF` (`productVariant_id`),
  KEY `IDX_303C2AAE6E6B91BE` (`variantValue`),
  CONSTRAINT `FK_303C2AAE6E6B91BE` FOREIGN KEY (`variantValue`) REFERENCES `variant_values` (`id`),
  CONSTRAINT `FK_303C2AAE5708BDEF` FOREIGN KEY (`productVariant_id`) REFERENCES `product_variants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of product_variant_variant_value
-- ----------------------------

-- ----------------------------
-- Table structure for `resources`
-- ----------------------------
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of resources
-- ----------------------------
INSERT INTO `resources` VALUES ('1', 'Admin:Dashboard');
INSERT INTO `resources` VALUES ('2', 'Options:Options');
INSERT INTO `resources` VALUES ('3', 'Pages:AdminPage');
INSERT INTO `resources` VALUES ('4', 'Files:AdminFile');
INSERT INTO `resources` VALUES ('5', 'Users:Users');
INSERT INTO `resources` VALUES ('6', 'Navigation:Navigation');

-- ----------------------------
-- Table structure for `roles`
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B63E2EC7727ACA70` (`parent_id`),
  CONSTRAINT `FK_B63E2EC7727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('1', null, 'guest');
INSERT INTO `roles` VALUES ('2', '1', 'user');
INSERT INTO `roles` VALUES ('3', '2', 'admin');
INSERT INTO `roles` VALUES ('4', '3', 'superadmin');

-- ----------------------------
-- Table structure for `tag`
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tag
-- ----------------------------

-- ----------------------------
-- Table structure for `urls`
-- ----------------------------
DROP TABLE IF EXISTS `urls`;
CREATE TABLE `urls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `redirect_to_id` int(11) DEFAULT NULL,
  `fake_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Fake path of the URL',
  `presenter` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Internal link presenter (Module:Presenter)',
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Internal link action',
  `internal_id` int(11) DEFAULT NULL COMMENT 'Internal ID passed to the action (optional)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2A9437A194EAC65A` (`fake_path`),
  KEY `IDX_2A9437A1606F5DDC` (`redirect_to_id`),
  KEY `IDX_2A9437A194EAC65A` (`fake_path`),
  CONSTRAINT `FK_2A9437A1606F5DDC` FOREIGN KEY (`redirect_to_id`) REFERENCES `urls` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of urls
-- ----------------------------
INSERT INTO `urls` VALUES ('1', null, 'auth', 'Auth:Sign', 'in', null);
INSERT INTO `urls` VALUES ('2', null, 'odhlasit', 'Auth:Sign', 'out', null);
INSERT INTO `urls` VALUES ('3', null, 'administrace/soubory', 'Files:AdminFile', 'default', null);
INSERT INTO `urls` VALUES ('4', null, 'administrace/nastaveni/general', 'Options:Options', 'general', null);
INSERT INTO `urls` VALUES ('5', null, 'administrace/editovat-stranku', 'Pages:AdminPage', 'edit', null);
INSERT INTO `urls` VALUES ('6', null, 'administrace/editovat-stranky', 'Pages:AdminPage', 'multiEdit', null);
INSERT INTO `urls` VALUES ('7', null, 'administrace/nastaveni/seo', 'Options:Options', 'seo', null);
INSERT INTO `urls` VALUES ('8', null, 'nahled-stranky', 'Pages:Page', 'preview', null);
INSERT INTO `urls` VALUES ('9', null, 'administrace/nahrat-soubory', 'Files:AdminFile', 'upload', null);
INSERT INTO `urls` VALUES ('10', null, 'administrace/editovat-soubor', 'Files:AdminFile', 'edit', null);
INSERT INTO `urls` VALUES ('11', null, 'administrace/novy-uzivatel', 'Users:Users', 'new', null);
INSERT INTO `urls` VALUES ('12', null, 'administrace/editovat-uzivatele', 'Users:Users', 'edit', null);
INSERT INTO `urls` VALUES ('13', null, 'protected-page', 'Pages:Page', 'protected', null);
INSERT INTO `urls` VALUES ('14', null, 'administrace', 'Admin:Dashboard', 'default', null);
INSERT INTO `urls` VALUES ('15', null, 'administrace/stranky', 'Pages:AdminPage', 'default', null);
INSERT INTO `urls` VALUES ('16', null, 'administrace/nova-stranka', 'Pages:AdminPage', 'new', null);
INSERT INTO `urls` VALUES ('17', null, 'administrace/navigace', 'Navigation:Navigation', 'default', null);
INSERT INTO `urls` VALUES ('18', null, 'administrace/uzivatele', 'Users:Users', 'default', null);
INSERT INTO `urls` VALUES ('19', null, 'administrace/nastaveni', 'Options:Options', 'default', null);
INSERT INTO `urls` VALUES ('20', null, '', 'Front:Homepage', 'default', null);
INSERT INTO `urls` VALUES ('21', null, 'kontakt', 'Front:Contact', 'default', null);

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'admin@antstudio.cz', '$2y$10$P/1So0F3ZaithYg7yNyfuu5QzRXQFD5bb/cuPK6vqGNJKUfAlVUP.', '2015-07-22 17:18:57');
INSERT INTO `users` VALUES ('2', 'demo@antstudio.cz', '$2y$10$cx3S/OlTwjkIkVyAz/fPZO1g.kZ3fqqT/8nXnUGSe6zx3MoKezoR2', '2015-07-22 17:18:57');

-- ----------------------------
-- Table structure for `user_role`
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role`),
  KEY `IDX_2DE8C6A3A76ED395` (`user_id`),
  KEY `IDX_2DE8C6A357698A6A` (`role`),
  CONSTRAINT `FK_2DE8C6A357698A6A` FOREIGN KEY (`role`) REFERENCES `roles` (`id`),
  CONSTRAINT `FK_2DE8C6A3A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '4');
INSERT INTO `user_role` VALUES ('2', '2');

-- ----------------------------
-- Table structure for `variants`
-- ----------------------------
DROP TABLE IF EXISTS `variants`;
CREATE TABLE `variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the variant (e.g. color, size, material).',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B39853E15E237E06` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of variants
-- ----------------------------
INSERT INTO `variants` VALUES ('1', 'barva');
INSERT INTO `variants` VALUES ('3', 'materiál');
INSERT INTO `variants` VALUES ('2', 'velikost');

-- ----------------------------
-- Table structure for `variant_values`
-- ----------------------------
DROP TABLE IF EXISTS `variant_values`;
CREATE TABLE `variant_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variant_id` int(11) DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Value of the variant (e.g. red, medium, wool).',
  PRIMARY KEY (`id`),
  KEY `IDX_2FFDEB303B69A9AF` (`variant_id`),
  CONSTRAINT `FK_2FFDEB303B69A9AF` FOREIGN KEY (`variant_id`) REFERENCES `variants` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of variant_values
-- ----------------------------
INSERT INTO `variant_values` VALUES ('1', '1', 'modrá');
INSERT INTO `variant_values` VALUES ('2', '1', 'červená');
INSERT INTO `variant_values` VALUES ('3', '1', 'žlutá');
INSERT INTO `variant_values` VALUES ('4', '2', 'S');
INSERT INTO `variant_values` VALUES ('5', '2', 'M');
INSERT INTO `variant_values` VALUES ('6', '2', 'L');
INSERT INTO `variant_values` VALUES ('7', '3', 'bavlna');
INSERT INTO `variant_values` VALUES ('8', '3', 'dřevo');
INSERT INTO `variant_values` VALUES ('9', '3', 'polyester');
