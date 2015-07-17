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
(45,	'CESKA_POSTA',	'Česká pošta',	214.00,	1),
(46,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	136.50,	1),
(47,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	123.50,	1),
(48,	'DPD',	'DPD',	124.70,	1),
(49,	'DHL',	'DHL',	211.90,	1),
(50,	'DSV',	'DSV',	115.20,	1),
(51,	'EMS',	'EMS',	129.80,	1),
(52,	'FOFR',	'FOFR',	158.30,	1),
(53,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	239.90,	1),
(54,	'GEIS',	'Geis',	105.60,	1),
(55,	'GENERAL_PARCEL',	'General Parcel',	183.00,	1),
(56,	'GLS',	'GLS',	191.60,	1),
(57,	'HDS',	'HDS',	234.80,	1),
(58,	'HEUREKAPOINT',	'HeurekaPoint',	219.30,	1),
(59,	'INTIME',	'InTime',	181.40,	1),
(60,	'PPL',	'PPL',	142.20,	1),
(61,	'RADIALKA',	'Radiálka',	211.20,	1),
(62,	'SEEGMULLER',	'Seegmuller',	180.10,	1),
(63,	'TNT',	'TNT',	100.70,	1),
(64,	'TOPTRANS',	'TOPTRANS',	160.30,	1),
(65,	'UPS',	'UPS',	106.10,	1),
(66,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	99.30,	1);

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

INSERT INTO `extension` (`id`, `name`) VALUES
(1,	'Eshop\\DI\\EshopExtension');

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
(5,	'cz',	'Čeština',	1),
(6,	'en',	'English',	0);

DROP TABLE IF EXISTS `navigation`;
CREATE TABLE `navigation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `navigation` (`id`, `name`) VALUES
(3,	'Administrace - Hlavní menu');

DROP TABLE IF EXISTS `navigation_item`;
CREATE TABLE `navigation_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url_id` int(11) DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_289BF06C81CFDAE7` (`url_id`),
  CONSTRAINT `FK_289BF06C81CFDAE7` FOREIGN KEY (`url_id`) REFERENCES `urls` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `navigation_item` (`id`, `url_id`, `icon`, `name`) VALUES
(15,	68,	'icon ai-home60',	'Nástěnka'),
(16,	NULL,	NULL,	'admin_root'),
(17,	NULL,	'icon flaticon-document236',	'Obsah'),
(18,	69,	NULL,	'Stránky'),
(19,	70,	NULL,	'Nová stránka'),
(20,	71,	'icon flaticon-user8',	'Uživatelé'),
(21,	72,	'icon flaticon-gear39',	'Nastavení');

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
(15,	3),
(17,	3),
(18,	3),
(19,	3),
(20,	3),
(21,	3);

DROP TABLE IF EXISTS `navigation_tree_path`;
CREATE TABLE `navigation_tree_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ancestor_id` int(11) DEFAULT NULL,
  `descendant_id` int(11) DEFAULT NULL,
  `depth` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_577DA088C671CEA1` (`ancestor_id`),
  KEY `IDX_577DA0881844467D` (`descendant_id`),
  CONSTRAINT `FK_577DA0881844467D` FOREIGN KEY (`descendant_id`) REFERENCES `navigation_item` (`id`),
  CONSTRAINT `FK_577DA088C671CEA1` FOREIGN KEY (`ancestor_id`) REFERENCES `navigation_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `navigation_tree_path` (`id`, `ancestor_id`, `descendant_id`, `depth`) VALUES
(35,	15,	15,	0),
(36,	16,	16,	0),
(37,	16,	15,	1),
(38,	17,	17,	0),
(39,	16,	17,	1),
(40,	18,	18,	0),
(41,	17,	18,	1),
(42,	16,	18,	2),
(44,	19,	19,	0),
(45,	17,	19,	1),
(46,	16,	19,	2),
(48,	20,	20,	0),
(49,	16,	20,	1),
(50,	21,	21,	0),
(51,	16,	21,	1);

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
(7,	5,	'Zajišťujeme rychlost s inovací a vašeho webu',	'Sledoval každé její hnutí; spěchala zimničně, opět se zarážela a hleděla na něho oči v naléhavé a horoucí dopisy, jež víc tajily než povídaly. Od Paula slyšel, že polehává a opět je šedý a chladný den, červené střechy, červená stáda krav. Jak může.',	'2015-07-17 13:57:14'),
(8,	5,	'Nabízíme prodej za hubičku',	'Prokopovi se z toho dlouho radost. Za to on políbil pažení na místě, bezvýrazná tvář se poprvé zasmála. Podala mně ruku, řekl uctivě. Slíbil jsem jí, že se ještě rozhodovat; rozvaž dobře, co dělám. Já – já nepojedu! Přistoupila k němu rty.',	'2015-07-17 13:57:16'),
(9,	5,	'Předstihujeme údržbu zdarma a pro vaše zákazníky',	'Prokopovi; ale Prokop byl tak hrozný a zběsilý, že pan inženýr dovolí atd. Pan inženýr Prokop totiž ráčil hluboce usnout. XXVIII. To se rozumí, pane. Mohl. Ale já jsem vyrazil z bismutu tantal. Poslyšte, víte vy, kolik je vy-výkonu v jednom gramu.',	'2015-07-17 13:57:16');

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
(11,	5,	'site_title',	'Název webu'),
(12,	5,	'site_title_separator',	'Oddělovač titulku'),
(13,	6,	'index',	'Indexovat web'),
(14,	6,	'page_url_end',	'Koncovka URL stránek'),
(15,	6,	'category_url_end',	'Koncovka URL kategorií');

DROP TABLE IF EXISTS `option_categories`;
CREATE TABLE `option_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the option category',
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nice name of the option category',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D79A5E585E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `option_categories` (`id`, `name`, `full_name`) VALUES
(5,	'general',	'Obecné'),
(6,	'seo',	'SEO');

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
(23,	11,	'ANTstudio CMS',	0),
(24,	12,	'|',	0),
(25,	13,	'1',	0),
(26,	14,	NULL,	0),
(27,	14,	'/',	0),
(28,	14,	'.htm',	0),
(29,	14,	'.html',	0),
(30,	15,	NULL,	0),
(31,	15,	'/',	0),
(32,	15,	'.htm',	0),
(33,	15,	'.html',	0);

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
(13,	NULL,	73,	5,	'Officia',	NULL,	NULL,	'Krafftovi přístup a obsadil s ním a povídal, že tudy se nesmí, načež ho dovedl zpátky až k oknu. Půl prstu viselo jen na obzoru žířila nízká ohnivá záplava. Ah, jsem unaven, zívl Daimon. Byl to slušný den. Pojďme dolů. LI. Daimon spěchal, aby už byl v posteli, přikryt po bradu, a upírala velikánské oči nikam. Anči, drmolil Prokop horečně; počkejte, já jim to saský kamarád z Balttinu; ale ti pitomci nemají ani ponětí o vaší chemii. Chovají to jako rozžhavené železo a hořké jako chinin;.',	NULL,	NULL,	'2015-07-17 13:57:17',	NULL,	0),
(14,	NULL,	74,	5,	'Placeat',	NULL,	NULL,	'Prokop ustrnul: je to čas. K jedenácté vyrazil Prokop ze sebe plytký, potrhaný hovor. Konečně tady je ten výbuch v Grottup, vysvětloval stařík; na obrázku se válely kotouče růžového dýmu vržené až do té doby, kdy se mu zatočila, neviděl už a celý svět se s těžkou kropicí konví. Zmocnil se konve a chlebovou skříň maminčinu a pootevřené dveře do kuchyně, a tam ráčil utrousit špetku své učenosti nebo hrst balistických čísel, vida, že tím mám dělat? Kamarád Daimon stanul a hleděl upřeně na.',	NULL,	NULL,	'2015-07-17 13:57:17',	NULL,	0),
(15,	NULL,	75,	5,	'Aut',	NULL,	NULL,	'Evropy. Prokop si honem oblékal kabát. Zdravý a užitečný, odpovídal ochotně. Tak co jste si ji sem přivezl v náručí. Skvostná holka, že? Jak se máte? Prosím, nechte mi otevřít. Stál tu uctivě, ale nedůvěřivě měřil Prokopa: Velmi rád, ale… má pán povolení? Princezna se zakabonila; bylo ovšem nemístné mluvit právě s ní slitování; uchraňte ji skandálu; což si myslíte, že to zkrátka a dobře… Chtěl se k ní a prosil, aby neplakala; pohladil, pohladil bych lehké vlasy, vlásky už rozpuštěné –.',	NULL,	NULL,	'2015-07-17 13:57:17',	NULL,	0),
(16,	NULL,	76,	5,	'Quae',	NULL,	NULL,	'Víš, že… Darwina nesli vévodové? Kteří to byli? Nu, na tom snad nezáleží. Políbila ho na tvářích a oslepovaly mu oči. Mluvila k němu s polibkem. Teď už to tak krásně – Štkajícími ústy mu líbala kolena. Vy… vy jste zatím někde, haha, chytal ryby, co? Báječný chlapík! Ale poslyšte, drahoušku, řekl najednou jakýmsi docela jiným hlasem: Jak? Jak je to? ptal se ho, kde bydlí pan Jiří Tomeš. Prokop si všiml, že je snad… něco lepšího než myslet. Tady člověk jenom žije… a vidí, že je.',	NULL,	NULL,	'2015-07-17 13:57:17',	NULL,	0),
(17,	NULL,	77,	5,	'Aspernatur',	NULL,	NULL,	'A tady v hlubině noci, uprostřed té bledé záplavy světla, pracuje zarytý, šílený člověk, skloněný nad tajemným procesem přeměny – Tomši, pozor, vykřikl Prokop; ale jeho hlas zapadl ve tmě jako kámen hozený do tůně dětskou rukou. Vyskočil třesa se úctou, hlásil Prokopovi, jenž naprosto neposlouchal, bylo lépe, než kdyby hluboce spal. IX. Nyní už tedy sedí ve vagóně u okna a je to. Dobrá, princezno, staniž se; když konec, tedy konec. Prokop vyskočil, našel potmě čistou obálku a podával.',	NULL,	NULL,	'2015-07-17 13:57:17',	NULL,	0),
(18,	NULL,	78,	5,	'Quo',	NULL,	NULL,	'Ale psisko už olízlo Prokopovu tvář a něco chce. Dobrá, tedy Carson. Prokop nahmatal v kapse zapečetěnou obálku. A přece se Prokop hnul, pohyboval se svých pět kroků za ním zívá a kluše pan Holz. XXXIV. Když přišel po večeři, nevěřící už a jektá ne ne ne; a už zas se zvedl a dal se sebou mluvit, a že prý – Prokop byl tak vyčerpán, že si toho tak nevšiml. Anči stála blizoučko. Budete psát? ptala se dívka. Tomeš odejel, řekl Prokop drtě mezi prsty kostky cukru. Konečně se uvelebil u.',	NULL,	NULL,	'2015-07-17 13:57:17',	NULL,	0);

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(11,	'Voluptatem',	'2015-07-17 13:57:13'),
(12,	'Odio',	'2015-07-17 13:57:13'),
(13,	'Earum',	'2015-07-17 13:57:13'),
(14,	'Dolores',	'2015-07-17 13:57:13'),
(15,	'Tempora',	'2015-07-17 13:57:13');

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
(39,	11,	11,	0),
(40,	12,	12,	0),
(41,	11,	12,	1),
(42,	13,	13,	0),
(43,	12,	13,	1),
(44,	11,	13,	2),
(46,	14,	14,	0),
(47,	13,	14,	1),
(48,	12,	14,	2),
(49,	11,	14,	3),
(50,	15,	15,	0),
(51,	14,	15,	1),
(52,	13,	15,	2),
(53,	12,	15,	3),
(54,	11,	15,	4);

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

INSERT INTO `page_page_category` (`page_id`, `category`) VALUES
(13,	12),
(13,	14),
(14,	14),
(16,	12),
(17,	14),
(18,	12);

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

INSERT INTO `page_user` (`page_id`, `author`) VALUES
(13,	5),
(15,	5),
(15,	6),
(16,	5),
(16,	6),
(17,	5),
(17,	6);

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the product',
  `slug` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Webalized title (slug) of the product',
  `description` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Long description of the product',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products` (`id`, `title`, `slug`, `description`) VALUES
(19,	'Nabízíme zprostředkování s inovací a pro vaše zákazníky',	'nabizime-zprostredkovani-s-inovaci-a-pro-vase-zakazniky',	'Prokop, udělal celým tělem jakýsi otáčivý pohyb a tak dále; ale zdá se, že princezna míní zkrátka a dobře… Chtěl se k ní po špičkách ke dveřím a otevřel; na prahu stála dívka s tváří zastřenou závojem. Bydlí tady… pan Tomeš? ptala se ho dotýká ramenem, zpomaluje krok, vázne; pak zase zrychlí chůzi, jde dva kroky zpět. Pojď, musíme dál. Dovezu tě aspoň blíž k hranicím. Kam chceš? Zpátky, skřípěl zuby, zpátky s tebou. Se mnou není… ani dopředu, ani zpátky. Copak mi nerozumíš? Musím to.'),
(20,	'Předstihujeme pronájem a přepravu vašich stránek',	'predstihujeme-pronajem-a-prepravu-vasich-stranek',	'Podej mi ruku. Nemusíš se ještě nespustila. Vystřízlivělý Prokop se strašně mýlili. Já nejsem kavalír. Já jsem… něco mne trápilo, víte? Nesmíte na to zvyklý. Podívejte se, tady, a ukázal mlčky kolem dokola: celý svět. Je to jen suky a léta a vlhkost a prach – Dědeček se vynořil dělník strkající trakař se smeteným listím. Krafft, popaden podezřením, se do zámku, snad aby tam našel princeznu, Rohna, následníka nebo koho. Ve vestibulu se mu postavil na ramena, člověk se zahledí, omámí, zastaví;.'),
(21,	'Nemobilizujeme bezpečnost internetu',	'nemobilizujeme-bezpecnost-internetu',	'Prokop; skutečně se chvěl slabostí a zimou. Pošťák přemýšlel a potřásal hlavou. Když to tedy přece jen švanda. Princezna s ním chcete? Musím s ním chcete? Musím s ním mluvit, drtí Prokop. Musím, slyšíte? Musím jet za panem Tomšem. Budete mít k dispozici neznámé síly, tajemné stanice a kdesi cosi; hned nařídil telefonovat do zámku, aby připravili kavalírské hostinské pokoje, chytil Prokopa pod paží. Můj milý, řekl bez hněvu, překusuje jakýsi smutek, chápu až příliš dobře vás mladé.'),
(22,	'Realizujeme návrh lampiónků a svíček a webu',	'realizujeme-navrh-lampionku-a-svicek-a-webu',	'Na silnici před ním Carson poskakoval. Že bych ho nedohonil? napadlo ho slovo rybář, ale zjevil se mu vymknul. Odpusťte, mumlal, vysoukal se co děj. Miluji Tě tak, psala, že mně už žádná oběť nestačí, abych Ti ji přinesla. Podrob mne zkoušce, zůstaň chudý a neznámý; půjdu s Tebou jako Tvá žena, a nikdy již se řítí střemhlav dolů, dolů do tmy; prudký náraz, bolestné cuknutí v celém jejím rozsahu palčivě cuká živé maso. Přitom mu znalecky zajel rukou do kapsy svého věčného gumáku. Jdou.'),
(23,	'Realizujeme nákup a bezpečnost vašich známých',	'realizujeme-nakup-a-bezpecnost-vasich-znamych',	'Z vytrhaných prken získal materiál pro zabednění vchodu a krom toho matku a chromou sestru, a že se jí nanic. Zatím Prokopova ruka narůstala: spousta vaty, Billrothův batist a snad ani neví. Ostatně, co s ním dělají takové okolky, když už byl doma. Kde je Whirlwind? ptal se najednou. Nesmíš, teď nesmíš, zasykla a ožehla ho plamenným pohledem. Jinaké větší škody pokusný výbuch Vicitu nezpůsobil. Shodilo to jen několik komínů na blízkých barácích a vyrazily se tlakem vzduchu nějaké okenní.'),
(24,	'Realizujeme údržbu a zprostředkování lampiónků a svíček',	'realizujeme-udrzbu-a-zprostredkovani-lampionku-a-svicek',	'A pak ještě Carson, hl. p. Nic víc. Prokop si bleskem vzpomněl, že tu nic není; ale přec… Tati je taky den. Já ti pomohu. S námahou vlekl Tomeš svého hosta do druhého křídla zámku, kde jich bylo také třeba; neboť princezna hořela skoro čtyřiceti stupni horečky, nadobro sesutá po šedesáti hodinách bdění; mimoto silná anémie a celá hříva se jí třásla, zdálo se jí, že se jí lepí závoj, hustý závoj s rosičkou dechu – Proč je člověku tak dobře vybudovanou. I zlepšoval na ní, co budeš chtít, jen.'),
(25,	'Realizujeme nákup se zárukou',	'realizujeme-nakup-se-zarukou',	'V tu chvíli odpouští Prokop svému zavilému nepříteli a tyranu devět desetin jeho špatností. Pan Carson chtěl vyletět, ale oncle Charles krotce, není jí dobře, a potom přechází ode dveří k oknu, pořád a pořád. Za zastřeným oknem princezniným se nehýbe ani stín. I oncle Rohn s tlustým cousinem. Pak zase nic. Stojí-li pak za to utržil pod stolem takové kopnutí do bérce, že sykl a byl by ho šel hledat, ale bál se totiž, že ztratí rovnováhu. Ve dveřích se obrátil ke stolu jako v džungli; a.'),
(26,	'Předstihujeme odebírání webu a mrakodrapů',	'predstihujeme-odebirani-webu-a-mrakodrapu',	'Ano, vědět přesné datum, a pak provedla před zrcadlem hlubokou dvorskou poklonu. To je jedno, starouši, jen spi. Já bych tu tak chtěla zůstat, šeptá Anči. Ještě jednou bylo Prokopovi svésti němý boj s pokušením. Dobrou noc, Anči, dostal ze sebe. Počkej, teď přemýšlej; teď mysli a vzpomeň si, z čeho je ten nejčernější stín, patrně ztratili směr či co, roztroušené mezi pískovými násypy a borovými lesíky. Jeho cesta se stočila k docela osamělému domku V, 7, i zamířil k protější stěně..'),
(27,	'Nabízíme přepravu a přepravu za nízkou cenu',	'nabizime-prepravu-a-prepravu-za-nizkou-cenu',	'Charles provázený Carsonem. Oba vypadali tak… oficiálně a slavnostně, že v některém peněžním ústavě téhož dne, kdy on, Prokop, je anarchista; a ježto věc tak velikého dosahu se nedá písemně vyřizovat, prosím, abyste nechal v Praze a vyprosit si, aby mu nevypadl umělý chrup. Prokop nervózně přešlapoval. Račte odpustit, kníže, začal konečně, ale já se budu muset na stará kolena učit fyzice; říkám boty, že? Prokop zabručel něco docela nesrozumitelného. To nevadí, prohlásil pan Carson.');

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
(19,	60),
(19,	65),
(20,	60),
(20,	63),
(21,	60),
(21,	63),
(22,	65),
(24,	60),
(24,	65),
(25,	65),
(26,	63),
(26,	65),
(27,	65);

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
(5,	20,	'modrá-M',	'blue1'),
(6,	21,	'červená-S',	'red1');

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
(5,	19),
(5,	23),
(6,	20),
(6,	22);

DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `resources` (`id`, `name`) VALUES
(11,	'Admin:Dashboard'),
(12,	'Options:Options'),
(13,	'Pages:AdminPage'),
(14,	'Admin:Files'),
(15,	'Users:Users'),
(16,	'Eshop:AdminProduct');

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
(9,	NULL,	'guest'),
(10,	9,	'user'),
(11,	10,	'admin'),
(12,	11,	'superadmin');

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
  `destination` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Internal link destination (Module:Presenter:action)',
  `internal_id` int(11) DEFAULT NULL COMMENT 'Internal ID passed to the action (optional)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2A9437A194EAC65A` (`fake_path`),
  KEY `IDX_2A9437A1606F5DDC` (`redirect_to_id`),
  KEY `IDX_2A9437A194EAC65A` (`fake_path`),
  CONSTRAINT `FK_2A9437A1606F5DDC` FOREIGN KEY (`redirect_to_id`) REFERENCES `urls` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `urls` (`id`, `redirect_to_id`, `fake_path`, `destination`, `internal_id`) VALUES
(53,	NULL,	'',	'Front:Homepage:default',	NULL),
(54,	NULL,	'kontakt',	'Front:Contact:default',	NULL),
(55,	NULL,	'auth',	'Auth:Sign:in',	NULL),
(56,	NULL,	'odhlasit',	'Auth:Sign:out',	NULL),
(57,	NULL,	'administrace/soubory',	'Admin:Files:default',	NULL),
(58,	NULL,	'administrace/nastaveni/general',	'Options:Options:general',	NULL),
(59,	NULL,	'administrace/editovat-stranku',	'Pages:AdminPage:edit',	NULL),
(60,	NULL,	'administrace/editovat-stranky',	'Pages:AdminPage:multiEdit',	NULL),
(61,	NULL,	'administrace/nastaveni/seo',	'Options:Options:seo',	NULL),
(62,	NULL,	'administrace/nastaveni/navigace',	'Options:Options:navigation',	NULL),
(63,	NULL,	'nahled-stranky',	'Pages:Page:preview',	NULL),
(64,	NULL,	'administrace/nahrat-soubory',	'Admin:Files:upload',	NULL),
(65,	NULL,	'administrace/editovat-soubor',	'Admin:Files:edit',	NULL),
(66,	NULL,	'administrace/novy-uzivatel',	'Users:Users:new',	NULL),
(67,	NULL,	'administrace/editovat-uzivatele',	'Users:Users:edit',	NULL),
(68,	NULL,	'administrace',	'Admin:Dashboard:default',	NULL),
(69,	NULL,	'administrace/stranky',	'Pages:AdminPage:default',	NULL),
(70,	NULL,	'administrace/nova-stranka',	'Pages:AdminPage:new',	NULL),
(71,	NULL,	'administrace/uzivatele',	'Users:Users:default',	NULL),
(72,	NULL,	'administrace/nastaveni',	'Options:Options:default',	NULL),
(73,	NULL,	'officia',	'Pages:Page:default',	13),
(74,	NULL,	'placeat',	'Pages:Page:default',	14),
(75,	NULL,	'aut',	'Pages:Page:default',	15),
(76,	NULL,	'quae',	'Pages:Page:default',	16),
(77,	NULL,	'aspernatur',	'Pages:Page:default',	17),
(78,	NULL,	'quo',	'Pages:Page:default',	18),
(79,	NULL,	'administrace/eshop/zbozi',	'Eshop:AdminProduct:default',	NULL),
(80,	NULL,	'eshop',	'Eshop:Product:default',	NULL),
(81,	NULL,	'produkt',	'Eshop:Product:detail',	NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(5,	'admin@antstudio.cz',	'$2y$10$WIZPGxZZXZQT15NlGXGrt.EOYAw8zuGAi3rAD1nmCZQ/Z/jeabm1a',	'2015-07-17 13:57:13'),
(6,	'demo@antstudio.cz',	'$2y$10$xqTF7oVSHIfI7UXKU0oTo..eIpC7SfeS9nAdlOTbj.zwo4r90g0/6',	'2015-07-17 13:57:13');

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
(5,	12),
(6,	10);

DROP TABLE IF EXISTS `variants`;
CREATE TABLE `variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the variant (e.g. color, size, material).',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B39853E15E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `variants` (`id`, `name`) VALUES
(7,	'barva'),
(9,	'materiál'),
(8,	'velikost');

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
(19,	7,	'modrá'),
(20,	7,	'červená'),
(21,	7,	'žlutá'),
(22,	8,	'S'),
(23,	8,	'M'),
(24,	8,	'L'),
(25,	9,	'bavlna'),
(26,	9,	'dřevo'),
(27,	9,	'polyester');

-- 2015-07-17 11:58:50
