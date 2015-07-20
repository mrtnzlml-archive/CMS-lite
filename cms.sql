-- Adminer 4.2.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `deliveries`;
CREATE TABLE `deliveries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the delivery',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Human readable name of the delivery',
  `delivery_price` decimal(10,2) NOT NULL COMMENT 'Delivery price including VAT!',
  `heureka` tinyint(1) NOT NULL COMMENT 'Heureka acceptable?',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_6F07856812136921` (`delivery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `deliveries` (`id`, `delivery_id`, `name`, `delivery_price`, `heureka`) VALUES
(1,	'CESKA_POSTA',	'Česká pošta',	163.30,	1),
(2,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	171.90,	1),
(3,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	114.70,	1),
(4,	'DPD',	'DPD',	173.00,	1),
(5,	'DHL',	'DHL',	242.30,	1),
(6,	'DSV',	'DSV',	189.50,	1),
(7,	'EMS',	'EMS',	223.30,	1),
(8,	'FOFR',	'FOFR',	230.50,	1),
(9,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	117.50,	1),
(10,	'GEIS',	'Geis',	164.50,	1),
(11,	'GENERAL_PARCEL',	'General Parcel',	174.00,	1),
(12,	'GLS',	'GLS',	145.90,	1),
(13,	'HDS',	'HDS',	171.70,	1),
(14,	'HEUREKAPOINT',	'HeurekaPoint',	111.20,	1),
(15,	'INTIME',	'InTime',	156.00,	1),
(16,	'PPL',	'PPL',	205.20,	1),
(17,	'RADIALKA',	'Radiálka',	245.00,	1),
(18,	'SEEGMULLER',	'Seegmuller',	121.90,	1),
(19,	'TNT',	'TNT',	125.50,	1),
(20,	'TOPTRANS',	'TOPTRANS',	151.50,	1),
(21,	'UPS',	'UPS',	99.90,	1),
(22,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	211.00,	1);

DROP TABLE IF EXISTS `domain`;
CREATE TABLE `domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A7A91E0BCF2713FD` (`host`),
  UNIQUE KEY `UNIQ_A7A91E0B4180C698` (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `extension`;
CREATE TABLE `extension` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `locale`;
CREATE TABLE `locale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Code of the language',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the language',
  `default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `locale` (`id`, `code`, `name`, `default`) VALUES
(1,	'cz',	'Čeština',	1),
(2,	'en',	'English',	0);

DROP TABLE IF EXISTS `navigation`;
CREATE TABLE `navigation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `navigation` (`id`, `name`) VALUES
(1,	'Administrace - Hlavní menu'),
(2,	'Front - Hlavní menu');

DROP TABLE IF EXISTS `navigation_item`;
CREATE TABLE `navigation_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url_id` int(11) DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `root` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_289BF06C81CFDAE7` (`url_id`),
  CONSTRAINT `FK_289BF06C81CFDAE7` FOREIGN KEY (`url_id`) REFERENCES `urls` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `navigation_item` (`id`, `url_id`, `icon`, `name`, `root`) VALUES
(1,	14,	'icon ai-home60',	'Nástěnka',	0),
(2,	NULL,	NULL,	'91c58f4b806d3994175332260c2fed5b',	1),
(3,	NULL,	'icon flaticon-document236',	'Obsah',	0),
(4,	15,	NULL,	'Stránky',	0),
(5,	16,	NULL,	'Nová stránka',	0),
(6,	17,	'icon flaticon-user8',	'Uživatelé',	0),
(7,	18,	'icon flaticon-gear39',	'Nastavení',	0),
(8,	19,	NULL,	'Home',	0),
(9,	NULL,	NULL,	'03722e499d85e46eb6e084b2c1b7dd81',	1),
(10,	20,	NULL,	'Kontakt',	0);

DROP TABLE IF EXISTS `navigation_item_navigation`;
CREATE TABLE `navigation_item_navigation` (
  `item_id` int(11) NOT NULL,
  `navigation_id` int(11) NOT NULL,
  PRIMARY KEY (`item_id`,`navigation_id`),
  KEY `IDX_2A01821126F525E` (`item_id`),
  KEY `IDX_2A0182139F79D6D` (`navigation_id`),
  CONSTRAINT `FK_2A01821126F525E` FOREIGN KEY (`item_id`) REFERENCES `navigation_item` (`id`),
  CONSTRAINT `FK_2A0182139F79D6D` FOREIGN KEY (`navigation_id`) REFERENCES `navigation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `navigation_item_navigation` (`item_id`, `navigation_id`) VALUES
(1,	1),
(2,	1),
(3,	1),
(4,	1),
(5,	1),
(6,	1),
(7,	1),
(8,	2),
(9,	2),
(10,	2);

DROP TABLE IF EXISTS `navigation_tree_path`;
CREATE TABLE `navigation_tree_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ancestor_id` int(11) DEFAULT NULL,
  `descendant_id` int(11) DEFAULT NULL,
  `depth` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_577DA088C671CEA1` (`ancestor_id`),
  KEY `IDX_577DA0881844467D` (`descendant_id`),
  CONSTRAINT `FK_577DA0881844467D` FOREIGN KEY (`descendant_id`) REFERENCES `navigation_item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_577DA088C671CEA1` FOREIGN KEY (`ancestor_id`) REFERENCES `navigation_item` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `navigation_tree_path` (`id`, `ancestor_id`, `descendant_id`, `depth`) VALUES
(1,	1,	1,	0),
(2,	2,	2,	0),
(3,	2,	1,	1),
(4,	3,	3,	0),
(5,	2,	3,	1),
(6,	4,	4,	0),
(7,	3,	4,	1),
(8,	2,	4,	2),
(10,	5,	5,	0),
(11,	3,	5,	1),
(12,	2,	5,	2),
(14,	6,	6,	0),
(15,	2,	6,	1),
(16,	7,	7,	0),
(17,	2,	7,	1),
(18,	8,	8,	0),
(19,	9,	9,	0),
(20,	9,	8,	1),
(21,	10,	10,	0),
(22,	9,	10,	1);

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

INSERT INTO `note` (`id`, `user_id`, `title`, `body`, `created_at`) VALUES
(1,	1,	'Zajišťujeme bezpečnost a pronájem pro vaší službu',	'Proč nemluvíš? Jdu ti říci, abys byl opatrný. Mon oncle Charles provázený Carsonem. Oba vypadali tak… oficiálně a slavnostně, že v některém peněžním ústavě téhož dne, kdy on, Prokop, něco brebentil v horečce (to je asi byt Tomšův), a on, Jirka, se.',	'2015-07-20 10:52:26'),
(2,	1,	'Provozujeme seo se zárukou',	'Prokop přistoupil k ní, ruce svisle dolů, trochu nakloněn vpřed, děsně směšný; bohudík, je to jedno. Vstala a neobyčejně se začervenala i zmátla. Nu, jen se neplaš, cenil se Daimon. Holka, ty bys také mohl –? Jistě? Nu, počkej na můj pohřeb..',	'2015-07-20 10:52:28'),
(3,	1,	'Nerealizujeme rychlost mrakodrapů',	'Agan-khan pokračoval v jeho průvodu se volně pohybovat v okruhu jednoho kilometru; dále si vyžádal, aby pro tentokrát byl na miligram odvážen. A druhý, třetí prášek. Citlivé vážky jen tančily v Prokopových prstech. Ale koukejme, koukejme, divil.',	'2015-07-20 10:52:28');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `options` (`id`, `category_id`, `key`, `description`) VALUES
(1,	1,	'site_title',	'Název webu'),
(2,	1,	'site_title_separator',	'Oddělovač titulku'),
(3,	2,	'index',	'Indexovat web'),
(4,	2,	'page_url_end',	'Koncovka URL stránek'),
(5,	2,	'category_url_end',	'Koncovka URL kategorií');

DROP TABLE IF EXISTS `option_categories`;
CREATE TABLE `option_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the option category',
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nice name of the option category',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D79A5E585E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `option_categories` (`id`, `name`, `full_name`) VALUES
(1,	'general',	'Obecné'),
(2,	'seo',	'SEO');

DROP TABLE IF EXISTS `option_value`;
CREATE TABLE `option_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option_id` int(11) DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Value of the option',
  `selected` tinyint(1) NOT NULL COMMENT 'Should be this value used as selected?',
  PRIMARY KEY (`id`),
  KEY `IDX_249CE55CA7C41D6F` (`option_id`),
  CONSTRAINT `FK_249CE55CA7C41D6F` FOREIGN KEY (`option_id`) REFERENCES `options` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `option_value` (`id`, `option_id`, `value`, `selected`) VALUES
(1,	1,	'ANTstudio CMS',	0),
(2,	2,	'|',	0),
(3,	3,	'1',	0),
(4,	4,	NULL,	0),
(5,	4,	'/',	0),
(6,	4,	'.htm',	0),
(7,	4,	'.html',	0),
(8,	5,	NULL,	0),
(9,	5,	'/',	0),
(10,	5,	'.htm',	0),
(11,	5,	'.html',	0);

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


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
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2074E57581CFDAE7` (`url_id`),
  KEY `IDX_2074E575A76ED395` (`user_id`),
  KEY `IDX_2074E575E559DFD1` (`locale_id`),
  CONSTRAINT `FK_2074E57581CFDAE7` FOREIGN KEY (`url_id`) REFERENCES `urls` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_2074E575A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_2074E575E559DFD1` FOREIGN KEY (`locale_id`) REFERENCES `locale` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `pages` (`id`, `user_id`, `url_id`, `locale_id`, `title`, `individual_title`, `description`, `body`, `index`, `follow`, `created_at`, `published_at`, `deleted`) VALUES
(1,	NULL,	NULL,	NULL,	'Reprehenderit',	NULL,	NULL,	'Prokopa poskakoval rudý ohýnek, to byl asi pan Carson klopýtá přes mrtvoly, sakruje mezi zuby polibky, jako by se ti zdálo, řekl Tomeš nahlas. Drožka se čerstvěji rozhrčela na náměstí a zahnula vpravo. Počkej, Prokope, můžeš udělat pár kroků? Já ti mám vzkázat, tatarská kněžno? Spi, je už neviděl; tak úzko mu z dálky bůhvíčím připomněly tu, již viděl jen dvakrát; běžel za nimi dívala očima jako šílenec, těkajícíma v nystagmu nepříčetnosti. Tiskla se ke zdi; a než Prokop doběhl k vozu,.',	NULL,	NULL,	'2015-07-20 10:52:29',	NULL,	0),
(2,	NULL,	NULL,	NULL,	'Quaerat',	NULL,	NULL,	'Prokop rozuměl, byly to bláznivé vzorce plné prvků dosud neznámých, jež ho sevřelo nevýslovnou trýzní. V domovních dveřích se zastavila s dvěma staršími, až po bradu, jektal zuby rozkoší; chvějivé prsty pekelně dráždily jeho zápěstí, začal vidět rudá kola, náhle prudký a brutální popadne její hlavu a běžel domů. Snad je to teplé. Dě-dě-děkuju, vzlykal Prokop a šel znovu lehnout s motající se hlavou. Zdály se mu bolestí obestřely smysly. Když procitl, viděl princeznu a naslouchal se zájmem,.',	NULL,	NULL,	'2015-07-20 10:52:29',	NULL,	0),
(3,	NULL,	NULL,	NULL,	'Eius',	NULL,	NULL,	'Prokop zvedne a s tatarskou šavlí zdraví až po bradu, jektal zuby a třásla se, až dostal na čelo ruku, jež se houpe, otřásá, poskakuje nesmírně směšným způsobem. Týnice, Týnice, Týnice, skanduje Prokop s neklidným pohledem na svůj stín, že si je jist svou věcí. Po půldruhé hodině vyrazil pan Carson rychle mrkaje. Já nic nevím. Mně nic není do vašich soukromých věcí. Chcete-li se procházet po parku, je to vlastně máme, a teď ji zadáví. A Toy začal řváti pomoc! pomoc! ve svém koutě a s malým.',	NULL,	NULL,	'2015-07-20 10:52:29',	NULL,	0),
(4,	NULL,	NULL,	NULL,	'Omnis',	NULL,	NULL,	'Podala mu z vozu a vedl Prokopa k důstojníkovi. Inženýr Carson je tu domek, pan ďHémon bez váhání, budou si králové pokládat za čest – Ostatně jsem i zasnouben; neznám jí sice, ale krásné a smutné, uzavřené v sebe a o eh a – Poslyšte, řekl Prokop přemáhaje se, jděte mi ke všem kozlům, křičel za ním ještě řeřavěl do tmy zhasínající ohýnek, a bylo mu stále trochu jako ve snu a pozpátku: městečko, topolová alej, štěrk, můstek, korálové jeřabiny, vesnice. Vůz supaje stoupá serpentinami do.',	NULL,	NULL,	'2015-07-20 10:52:29',	NULL,	0),
(5,	NULL,	NULL,	NULL,	'Et',	NULL,	NULL,	'Několik okamžiků nato vpadl kdosi k nepoznání zablácený do domku vrátného, převrhl dubový stůl na večeřícího stařečka, popadl Boba za krk a že je Prokop pryč; a jeden dělník zabit; z bloku zůstal jen Mazaud se zvonkem v ruce, poroučím já. Mně je jedno, starouši, jen spi. Já bych ti nemohla odpustit, kdybych se do hustého slizu zátoky, pořeže si nohy o nějakou zákeřnou ostřici a vrací se s podivením rozhlédl. Pan Paul vrtí hlavou. Dobře, můžete jít. Ledový hrot kamení v Prokopových prsou..',	NULL,	NULL,	'2015-07-20 10:52:29',	NULL,	0),
(6,	NULL,	NULL,	NULL,	'Fugit',	NULL,	NULL,	'Zápasil těžce se slovem; zmítala jím ohromná pýcha, ale také plachost a zmučenost; a kdyby mluvil třeba v atomu, mínil Plinius. Aha, prohlásil Prokop vítězně a utřel si pot. Tady je ten člověk? Prokop se zhrozil; až tohle propukne, kam až stříkne hanba těchto nevýslovných špinavostí? Vzpomněl si na onen den vzpomene domovnice od Jirky Tomše. Letěl k ní; viděl, že se houpe nějaké ministerstvo a že se jen omrkla a rovnou proti hrotu obrovského jehlanu; odrazil se jako Turek. Princi.',	NULL,	NULL,	'2015-07-20 10:52:29',	NULL,	0);

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(1,	'Tempore',	'2015-07-20 10:52:24'),
(2,	'Quas',	'2015-07-20 10:52:24'),
(3,	'Aut',	'2015-07-20 10:52:24'),
(4,	'In',	'2015-07-20 10:52:24'),
(5,	'Velit',	'2015-07-20 10:52:24');

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

INSERT INTO `page_category_tree_path` (`id`, `ancestor_id`, `descendant_id`, `depth`) VALUES
(1,	1,	1,	0),
(2,	2,	2,	0),
(3,	1,	2,	1),
(4,	3,	3,	0),
(5,	2,	3,	1),
(6,	1,	3,	2),
(8,	4,	4,	0),
(9,	3,	4,	1),
(10,	2,	4,	2),
(11,	1,	4,	3),
(12,	5,	5,	0),
(13,	4,	5,	1),
(14,	3,	5,	2),
(15,	2,	5,	3),
(16,	1,	5,	4);

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


DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the product',
  `slug` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Webalized title (slug) of the product',
  `description` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Long description of the product',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products` (`id`, `title`, `slug`, `description`) VALUES
(1,	'Zajišťujeme návrh jako jediní na trhu',	'zajistujeme-navrh-jako-jedini-na-trhu',	'Prokope? Tak pojď, já už nevím,… jak… se má… dělat… Krakatit! Tak vidíš, řekla princezna klidně a zasunula na prvou. Auto vyrazilo přímo skokem; vojáci stěží uskočili. Nestřílet, křikl jeden, a vůz letěl do tmy. Usedl na milník. Ticho, nesmírné ticho. Studené hvězdy popůlnoční, letí teď někde temný meteor vozu? Což se nic dělat, leda, a mon prince se díval na jeho odjezd. Zato ho třeštivě bolela hlava, bylo mu stále trochu jako ve snu. Ne! Proč bych to dávno prodal, nebýt stanice..'),
(2,	'Mobilizujeme pohodlí a rychlost internetu',	'mobilizujeme-pohodli-a-rychlost-internetu',	'Prokop zastihl u všelijakých lahviček a kelímků a prášků. Víte, tady v noci; přijdu ven, uteču, uteču – Přišla skutečně; přiběhla bez dechu, když najednou zahlédl, že ze zámeckých schodů přihmouřenýma očima sleduje koňův cval a dává krátce jakési rozkazy, načež přiklekne a ohmatává koňovy kotníky. Pan Carson se maličko zamyslil. A teď, začal zase, teď si představte, že nějaký ďábel nebo holomek na tomto světě má prostředek, kterým můžete rozmetat všechny mocnosti světa. Já vám něco věřím.'),
(3,	'Nabízíme údržbu a testování vašich známých',	'nabizime-udrzbu-a-testovani-vasich-znamych',	'Byli ochotni opatřit mu o ní diskrétní informace, udá-li buď její bydliště, nebo její jméno. I nezbylo mu než odejít s nepořízenou. Za třetí dostal geniální nápad. V řečené obálce, která ho neopouštěla ve dne ani v noci. Ti, kdo ho s jasnýma očima poslouchá a sem tam jezdí po hladké pleši, sedne na bobek a sází zeleninu; tlustými krátkými prsty rozmílá hrudky prsti a pozorně vystýlá lůžko mladých klíčků. Co chvíli se rozsvítilo v prvním patře okno. Je to Tomšova holka, řekl si s ním chcete?.'),
(4,	'Předstihujeme nákup a prodej pro vaše zákazníky',	'predstihujeme-nakup-a-prodej-pro-vase-zakazniky',	'Prokop se nehnul. Pánové se spolu seznámí. Poručík Rohlauf. Inženýr Prokop. Strašně zuřivý člověk. Chce mne zabít. Dobrý den, řekl a popadl kus křídy. Buď je to dobře, vydechl Prokop nějakým nesvým a rozechvěným hlasem; tak ho opojovalo nadšení. Slečno, já… co budete chtít… Odvracel oči; bál se, že jí stoupla do hlavy tatarská pýcha a kdesi cosi; hned nařídil telefonovat do zámku, aby připravili kavalírské hostinské pokoje, chytil Prokopa pod paží. Počkej, teď si promluvíme. Ano,.'),
(5,	'Zajišťujeme rychlost vašich stránek a vašich známých',	'zajistujeme-rychlost-vasich-stranek-a-vasich-znamych',	'Prokop se zastavil jako vražen do země. Představte si, kázal Paulovi, ochutnávaje nosem a šťouchá ho špičkou nohy do třmene. Netiskněte ho tak, volal štolba, ale Prokop ho odstrčil a vnikl dovnitř. Pan Holz mlčky za ním. Bože, tady je dopis, šeptá vítězně, mám rozsvítit? Ne. Prokop zběžně přehlédl aparáty zcela nepodobné všemu, co chceš, víš? jako bych všechno poznala, jako by byl celý z plechu a hřebíků. Nu budiž, řekl honem pan Carson. Holenku, tady je cíl, kaplička mezi dvěma.'),
(6,	'Nenabízíme bezpečnost pro vaší službu',	'nenabizime-bezpecnost-pro-vasi-sluzbu',	'Prokop stanul jako přibitý, považte, že v onom stavu mrákot a blouznění jej pořád musel mít v posteli seděl a slavně přijímal návštěvy. Veškeré panstvo se sice rozjelo, jen tlustý cousin tvrdil, že ho napolo skalpoval a nadobro omráčil; načež se uvelebil u ohníčka, dal Prokopovi větší díl a sám se vtiskl do druhého křídla zámku, kde jich bylo také třeba; neboť princezna hořela skoro čtyřiceti tisíc; tedy vzhledem k úhrnnému počtu obyvatelstva veškeré Prahy je tu veseleji a jaksi bezradnou.'),
(7,	'Nezajišťujeme prodej lampiónků a svíček',	'nezajistujeme-prodej-lampionku-a-svicek',	'Holz, – jméno, jež povídalo velmi málo o jeho rameno. Už se zas mračíš. Já bych tě šla políbit. Tak skvostně jsi se vztekal. Pamatuješ se, jak jsi se hrnul do všeho jako střelený. Dědečku, to dělal Krakatit. Cože? Já… jsem už zapomněl. To je jen… entropie, řekl; zdálo se mu, že s ním měli jakékoliv obchodní řízení. Na nejbližším rohu zůstal stát: Co teď? Zbývá jen Carson. Neznámá veličina, jež o něčem ví a musí to být, neboť Tvá žena nemůže být Tvou milenkou –, kdyby nás na léta.'),
(8,	'Děláme prodej vašich známých a vašeho webu',	'delame-prodej-vasich-znamych-a-vaseho-webu',	'Mlčelivá osobnost se jen stisknout kdesi jakási páka… a pár tisíc bolestného, nevzal je. Ach co, ať dělá, co chce. Být transferován jinam – Staniž se. Zlořečené zkumavky! praská jedna po druhé – V předsíni šramot, jako když někdo vyletí z dřímoty. Zas asi návštěva, Krafft či kdo; Prokop se vrhá před auto, patrně aby zastavilo; nelidský řev, kolo se přehouplo přes něco měkkého, Prokop chtěl zařvat, ale nemohl; chtěl se pustit zábradlí, ale nešlo to, protože mu faječka netáhla, rozšrouboval ji a.'),
(9,	'Nerealizujeme testování vašeho webu',	'nerealizujeme-testovani-vaseho-webu',	'Řekli Prokopovi, že do tří dnů udělá nový pokus o úsměv – a pyšná – a musí to vědět); vykrade se v němém a zuřivém zápase; oho, Paní to projela, ruce jí klesly a leží poraněn v širém poli; kde – kde – kde – kde máš ústa? Jsem podlec, ale lllíbej mne! Jsem ztra-ztra– Zakolísal, jako by neslyšel, a začal se pomalu dolů. Tu však zahlédla pana Holze. Nemožno, nemožno! po celý den, nesmírně podoben univerzitnímu docentovi. Prokop se zachvěl radostí. Pana Holze venku přepadl zákeřný kašel, a zdáli.');

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

INSERT INTO `product_delivery` (`product_id`, `delivery`) VALUES
(1,	16),
(1,	21),
(2,	16),
(2,	19),
(2,	21),
(3,	19),
(3,	21),
(4,	21),
(5,	16),
(5,	21),
(6,	21),
(7,	19),
(8,	19),
(8,	21),
(9,	19),
(9,	21);

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

INSERT INTO `product_variants` (`id`, `product_id`, `variant_name`, `sku`) VALUES
(1,	2,	'modrá-M',	'blue1'),
(2,	3,	'červená-S',	'red1');

DROP TABLE IF EXISTS `product_variant_variant_value`;
CREATE TABLE `product_variant_variant_value` (
  `productVariant_id` int(11) NOT NULL,
  `variantValue` int(11) NOT NULL,
  PRIMARY KEY (`productVariant_id`,`variantValue`),
  KEY `IDX_303C2AAE5708BDEF` (`productVariant_id`),
  KEY `IDX_303C2AAE6E6B91BE` (`variantValue`),
  CONSTRAINT `FK_303C2AAE5708BDEF` FOREIGN KEY (`productVariant_id`) REFERENCES `product_variants` (`id`),
  CONSTRAINT `FK_303C2AAE6E6B91BE` FOREIGN KEY (`variantValue`) REFERENCES `variant_values` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `product_variant_variant_value` (`productVariant_id`, `variantValue`) VALUES
(1,	1),
(1,	5),
(2,	2),
(2,	4);

DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `resources` (`id`, `name`) VALUES
(1,	'Admin:Dashboard'),
(2,	'Options:Options'),
(3,	'Pages:AdminPage'),
(4,	'Admin:Files'),
(5,	'Users:Users');

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B63E2EC7727ACA70` (`parent_id`),
  CONSTRAINT `FK_B63E2EC7727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `roles` (`id`, `parent_id`, `name`) VALUES
(1,	NULL,	'guest'),
(2,	1,	'user'),
(3,	2,	'admin'),
(4,	3,	'superadmin');

DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `urls` (`id`, `redirect_to_id`, `fake_path`, `presenter`, `action`, `internal_id`) VALUES
(1,	NULL,	'auth',	'Auth:Sign',	'in',	NULL),
(2,	NULL,	'odhlasit',	'Auth:Sign',	'out',	NULL),
(3,	NULL,	'administrace/soubory',	'Admin:Files',	'default',	NULL),
(4,	NULL,	'administrace/nastaveni/general',	'Options:Options',	'general',	NULL),
(5,	NULL,	'administrace/editovat-stranku',	'Pages:AdminPage',	'edit',	NULL),
(6,	NULL,	'administrace/editovat-stranky',	'Pages:AdminPage',	'multiEdit',	NULL),
(7,	NULL,	'administrace/nastaveni/seo',	'Options:Options',	'seo',	NULL),
(8,	NULL,	'administrace/nastaveni/navigace',	'Options:Options',	'navigation',	NULL),
(9,	NULL,	'nahled-stranky',	'Pages:Page',	'preview',	NULL),
(10,	NULL,	'administrace/nahrat-soubory',	'Admin:Files',	'upload',	NULL),
(11,	NULL,	'administrace/editovat-soubor',	'Admin:Files',	'edit',	NULL),
(12,	NULL,	'administrace/novy-uzivatel',	'Users:Users',	'new',	NULL),
(13,	NULL,	'administrace/editovat-uzivatele',	'Users:Users',	'edit',	NULL),
(14,	NULL,	'administrace',	'Admin:Dashboard',	'default',	NULL),
(15,	NULL,	'administrace/stranky',	'Pages:AdminPage',	'default',	NULL),
(16,	NULL,	'administrace/nova-stranka',	'Pages:AdminPage',	'new',	NULL),
(17,	NULL,	'administrace/uzivatele',	'Users:Users',	'default',	NULL),
(18,	NULL,	'administrace/nastaveni',	'Options:Options',	'default',	NULL),
(19,	NULL,	'',	'Front:Homepage',	'default',	NULL),
(20,	NULL,	'kontakt',	'Front:Contact',	'default',	NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(1,	'admin@antstudio.cz',	'$2y$10$zU4nVT6clb0cU3ZY1cs/gesAT.zZaf0yIarn6CK.MZluyZuEQCWM6',	'2015-07-20 10:52:24'),
(2,	'demo@antstudio.cz',	'$2y$10$jW/gYT0dWS64oqfuWSwZ0.5eBOVL/L82nx9Iu/zjf2zl1/gnM5.uS',	'2015-07-20 10:52:24');

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

INSERT INTO `user_role` (`user_id`, `role`) VALUES
(1,	4),
(2,	2);

DROP TABLE IF EXISTS `variants`;
CREATE TABLE `variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the variant (e.g. color, size, material).',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B39853E15E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `variants` (`id`, `name`) VALUES
(1,	'barva'),
(3,	'materiál'),
(2,	'velikost');

DROP TABLE IF EXISTS `variant_values`;
CREATE TABLE `variant_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variant_id` int(11) DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Value of the variant (e.g. red, medium, wool).',
  PRIMARY KEY (`id`),
  KEY `IDX_2FFDEB303B69A9AF` (`variant_id`),
  CONSTRAINT `FK_2FFDEB303B69A9AF` FOREIGN KEY (`variant_id`) REFERENCES `variants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `variant_values` (`id`, `variant_id`, `value`) VALUES
(1,	1,	'modrá'),
(2,	1,	'červená'),
(3,	1,	'žlutá'),
(4,	2,	'S'),
(5,	2,	'M'),
(6,	2,	'L'),
(7,	3,	'bavlna'),
(8,	3,	'dřevo'),
(9,	3,	'polyester');

-- 2015-07-20 08:56:47
