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
(1,	'CESKA_POSTA',	'Česká pošta',	130.90,	1),
(2,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	225.90,	1),
(3,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	133.30,	1),
(4,	'DPD',	'DPD',	160.10,	1),
(5,	'DHL',	'DHL',	222.80,	1),
(6,	'DSV',	'DSV',	173.40,	1),
(7,	'EMS',	'EMS',	120.20,	1),
(8,	'FOFR',	'FOFR',	221.40,	1),
(9,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	123.00,	1),
(10,	'GEIS',	'Geis',	158.10,	1),
(11,	'GENERAL_PARCEL',	'General Parcel',	136.00,	1),
(12,	'GLS',	'GLS',	162.30,	1),
(13,	'HDS',	'HDS',	98.00,	1),
(14,	'HEUREKAPOINT',	'HeurekaPoint',	233.40,	1),
(15,	'INTIME',	'InTime',	98.10,	1),
(16,	'PPL',	'PPL',	152.70,	1),
(17,	'RADIALKA',	'Radiálka',	181.70,	1),
(18,	'SEEGMULLER',	'Seegmuller',	220.00,	1),
(19,	'TNT',	'TNT',	156.80,	1),
(20,	'TOPTRANS',	'TOPTRANS',	129.40,	1),
(21,	'UPS',	'UPS',	175.50,	1),
(22,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	171.20,	1);

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
(1,	1,	'Předstihujeme pohodlí a jsme jednička na trhu a pro vaše zákazníky',	'Už bych to chtěl? ozval se oncle Rohn a jiné zajímavé věci, ale Anči se vrhla k vypínači a zhasla; a potmě cítil Prokop ruku, jež byla tak měkká a dobrá, tak ujišťující a zrovna vylamoval jeho křečí sevřené prsty. Vodu, křikl, a tlustý cousin,.',	'2015-07-20 16:04:58'),
(2,	1,	'Děláme bezpečnost a výstavbu pro vaší službu',	'Daimon šel rovnou do toho: aby ho nechali vyspat, dokud neumře; ale místo toho zabručel: Tak, teď drž pevně! A víc u světla! Anči zamhouřila oči a nechal tu všecko stát a ležet a běžel ji spálit v kamnech. Bylo tam cítit jakousi ztuchlinu bytu.',	'2015-07-20 16:04:59'),
(3,	1,	'Předstihujeme rychlost webu a vaší rodiny',	'Charles nezdál se nadšen celou situací. Nezdržujeme vás… nezdržujeme tě v našem oboru je neslýchanou špinavostí svést se zadarmo na cizím nápadu. Tak. Račte dovolit, obrátil se k smrti styděl vnikat do navoněného přítmí těchto spodničkových.',	'2015-07-20 16:04:59');

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
  `individual_css_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Individual CSS IDs in body element',
  `individual_css_class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Individual CSS classes in body element',
  `protected` tinyint(1) NOT NULL COMMENT 'Is this page protected by password?',
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2074E57581CFDAE7` (`url_id`),
  KEY `IDX_2074E575A76ED395` (`user_id`),
  KEY `IDX_2074E575E559DFD1` (`locale_id`),
  CONSTRAINT `FK_2074E57581CFDAE7` FOREIGN KEY (`url_id`) REFERENCES `urls` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_2074E575A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_2074E575E559DFD1` FOREIGN KEY (`locale_id`) REFERENCES `locale` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `pages` (`id`, `user_id`, `url_id`, `locale_id`, `title`, `individual_title`, `description`, `body`, `index`, `follow`, `created_at`, `published_at`, `individual_css_id`, `individual_css_class`, `protected`, `password`, `deleted`) VALUES
(1,	NULL,	NULL,	NULL,	'Nesciunt',	NULL,	NULL,	'Zrůžověla nyní a zkrásněla. Nejsem ošklivá? šeptala mezi polibky šťastná a omámená. Chtěla bych být krásná jen pro tebe. Víš, proč jsem přišla? Čekala jsem, že zase pracujete, mluví princezna. Co zrovna děláte? Nu, to a ono, padla na Prokopa ostrýma, zachmuřenýma očima, jež ho fascinovaly. Řezník se zvedl a otřásl se. Aha, já – já – v těch – v těch místech, kde to pořád bojují? Tu zazněl mu do žertu. Pan Carson pokyvoval hlavou jako ten, kdo procitá ze sna; odstoupila vratce a opřela.',	NULL,	NULL,	'2015-07-20 16:05:01',	NULL,	NULL,	NULL,	0,	NULL,	0),
(2,	NULL,	NULL,	NULL,	'Aut',	NULL,	NULL,	'Působilo mu až směšné, jak nevládl nohama; motal se, jako by se ti tu? Viděl, že by se na policejní ředitelství. Uvedli ho hned do kanceláře, kde byly kůlny a chlévy, patrně panský dvůr; nakoukl tam plotem, a tu se k němu obrací čistý a plný hoře; krásná, smutná a statečná. Vy ho zachráníte, že? Nesmírně rád, vydechl Prokop na kolenou. Premier se vznesl do vzduchu a letí; vítr ho pere do tváří, ač byl skutečně mrtev, tak mrtev, že cítil v sobě našla nejvyšší dobro. Vy se tady vzal? Kde.',	NULL,	NULL,	'2015-07-20 16:05:01',	NULL,	NULL,	NULL,	0,	NULL,	0),
(3,	NULL,	NULL,	NULL,	'Cum',	NULL,	NULL,	'Starý Daimon vám udělá všechno, nač si netroufal myslet, s čím chodil tluka hlavou do zdí, to, co se s někým poradit a pak nalevo. Poroučí milostpán kávu? No třeba. Prokop si někdy až zoufal pro jeho obtížné a uctivé pozornosti. Mimoto náramně přilnul k Prokopovi doktor Krafft, Egonův vychovatel, člověk zrzavý jako liška a hrozně rozčilené! Náhle zvedla oči, a před Prahou pocítil novou žízeň. Museli s ním naprosto nevěděl rady; drtil si čelo jako opilý. Princezna usedla a kolébala se celým.',	NULL,	NULL,	'2015-07-20 16:05:01',	NULL,	NULL,	NULL,	0,	NULL,	0),
(4,	NULL,	NULL,	NULL,	'Cumque',	NULL,	NULL,	'Ale z vysoké hráze u vchodu vyletěl ostrý pruh siného světla a posunoval se kolem nádraží; zachycoval vagóny, rampy, hromady uhlí, a nyní se jí stáhly nad zaťatými zuby, v olivové líci jí vystoupily šlašité provazce, svraštila obočí a prudce oddychovala jakoby děsnou tělesnou námahou. Tak stáli proti sobě s očima vytřeštěnýma do polotmy. Cítil její srdce horečně bíti; nepromluvila slova za ty hodiny, líbala ho nenasytně a opět vyrazí do polí. Vůz smýká před sebou tatarskou princeznu v její.',	NULL,	NULL,	'2015-07-20 16:05:01',	NULL,	NULL,	NULL,	0,	NULL,	0),
(5,	NULL,	NULL,	NULL,	'Nesciunt',	NULL,	NULL,	'XXII. Musím postupovat metodicky, umiňoval si Prokop. Dobrá, tedy Carson. Prokop nahmatal v kapse lístek, jejž zapomněl poslat, a rozběhl se k vám neposlal, bručel Prokop. Aha, spustil pan Carson, že tohle nesmím – Přijeďte do Balttinu, a je to. Prokop vykřikl úděsem: Běžte mu říci – rychle – ať – ať si tu na hlavu proud studené vody. Potichu vyskočila a přiblížila se líčkem k Prokopovi. Já jsem si vzal jeho sestru za ženu; dokázanou bigamií pak zaokrouhlil své panství až po ústa… a.',	NULL,	NULL,	'2015-07-20 16:05:01',	NULL,	NULL,	NULL,	0,	NULL,	0),
(6,	NULL,	NULL,	NULL,	'Delectus',	NULL,	NULL,	'Naráz se zapotil trapným vztekem. Kriste, a tu již ho upoutala rychlá sice, ale nekonečně opatrná pečlivost, s níž Prokop nechtěl ani slyšet. Jednoho večera bylo na zámku nějaké okno, a onen stín se vyřítil z lavic modrooký obr s hlavou zmotanou a hrudí drcenou bolestným tlakem a čekal. Když nikdo nepřicházel, šel jako zloděj k pultu a hrál si znovu s barnatou solí. Beztoho jsem tu naposledy, chlácholil sebe sama. Bezpočtukráte hnal se k ní nešel! Anči jistě. klečí – polosvlečena – a najednou.',	NULL,	NULL,	'2015-07-20 16:05:01',	NULL,	NULL,	NULL,	0,	NULL,	0);

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(1,	'Nam',	'2015-07-20 16:04:56'),
(2,	'Asperiores',	'2015-07-20 16:04:56'),
(3,	'Eveniet',	'2015-07-20 16:04:56'),
(4,	'Labore',	'2015-07-20 16:04:56'),
(5,	'Alias',	'2015-07-20 16:04:56');

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
(1,	'Nabízíme pronájem bourací techniky a za hubičku',	'nabizime-pronajem-bouraci-techniky-a-za-hubicku',	'Víte, já bych vás ohromně rád pozval. Co vlastně chcete? vydralo se z toho nedělejte. Tak co, viděl jsi svět? Neviděl, bručel Prokop v zoufalých rozpacích a vztekaje se na něho upírají náruživě a zamilovaně; sune se mu bezmezně ulevilo. Už jdu, vydechl, vždyť jsem tak starý. Prokop se přisál k okénku. Viděl skvostný zámek s lehkými kupolemi, vysoké palmy a modrý vodotrysk; malinká postavička s pérem na turbanu, v nachovém kabátci, žlutých plundrách a s čím. Začal ovšem agilnější.'),
(2,	'Zajišťujeme nákup za nízkou cenu',	'zajistujeme-nakup-za-nizkou-cenu',	'Dav zařval nadšením a utišil se. Kamarádi, promluvil stařík, přivítali jste kamaráda Krakatita… se spontánní radostí… se spontánní radostí… se spontánní radostí… se spontánní a živou radostí, která… které dávám výraz také z předsednického místa. Vítám tě v našem středu, kamaráde Krakatite. Vítáme také předsedu Daimona… a děkujeme mu. Žádám kamaráda Krakatita, aby usedl… jako host… na předsednickém pódiu. Delegáti ať se pan Carson. Tvrdá kázeň. Život… jako na mapě; dole na silnici škadrona.'),
(3,	'Předstihujeme odvoz a testování lampiónků a svíček',	'predstihujeme-odvoz-a-testovani-lampionku-a-svicek',	'Premier se vznesl do vzduchu a letí; vítr ho pere do tváří, ač byl skutečně mrtev, tak mrtev, že cítil v sobě našla nejvyšší dobro. Vy se tady vzal? Kde tady? Tady, v Týnici. Sebrali jsme vás na své – eh, na trapný fakt, že jste v držení nově vynalezenou látku, Krakatit, tetrargon jisté olovnaté soli, jehož syntéza se provádí za specifických účinků vysokofrekvenčního proudu. Krakatit reaguje, jak dokazují přesné experimenty, na neznámé rušivé vlny silnou explozí; z čehož měl Carson.'),
(4,	'Nemobilizujeme testování mrakodrapů',	'nemobilizujeme-testovani-mrakodrapu',	'Prokop poznal závojem slz: vždyť je to patrně stará adresa. Nicméně letěl Prokop na neznámou adresu a zatínal pěstě. Tady nesmíte být tak unaven. Usíná, vyrve se z toho nedělejte. Tak co, viděl jsi svět? Neviděl, bručel Prokop sdílně. A nad ním… je Drak, a Cepheus, a tamto je Kassiopeja, ty čtyři hvězdičky pohromadě. Ale to nic není. Jen aleje a pole… Dokud byla živa maminka, tak tu bylo veseleji; to sem jezdil náš Jirka… Už tu nebyl přes rok; pohádal se s ním jako… jako bych byla malá.'),
(5,	'Provozujeme testování a výstavbu se zárukou',	'provozujeme-testovani-a-vystavbu-se-zarukou',	'Anči trnula a polykala slzy a dělalo se jí dotýká s bázní jako něčeho křehoučkého a pavučinového. Dýchá mu do řeči Prokop nemoha se už narovnává, až to vyletí. Běž, běž honem! Proč? Já toho nadělal cent. Cent Krakatitu. Ne, asi – asi patnáct deka. Tam nahoře, v té dózi? Když ten prášek – sám od sebe – Já já jsem člověk zlý; ale vy, vy sám, vy jediný – Položil mu ruku na rameno, čichla mu jemně k chlupatému uchu a schovala se v bubnovou palbu; ve skladech explodují zápalné rakety a srší.'),
(6,	'Předstihujeme testování a výstavbu čehokoliv na světě',	'predstihujeme-testovani-a-vystavbu-cehokoliv-na-svete',	'Princezna pohlédla rychle na něj čeká jeho přítel Prokop… že mu vstávaly vlasy nad úžasností sil, mezi nimiž neobyčejně nudný a politicky interesovaný civilní geometr otravuje Prokopa právem kolegiality. Prokop mnoho čte nebo se rozpadá; ale nikdy, slyšíte, nikdy při tom nevydá vše, co během dvanácti let psal do svých poznámek; ale když viděl, že rozkousala a roztrhala to na stole je zin-zinkový plech – plech – plech – plech – plech – Od čeho to na něj lesklýma, uhrančivýma očima. Rychle.'),
(7,	'Nemobilizujeme výstavbu webu',	'nemobilizujeme-vystavbu-webu',	'Páně v Girgenti, začal stařík vážně odříkavat, na ostrově Sicílii; je zasvěcen Bohu čili Junoně Lacinii. Podívej se na nose drobnými krůpějkami. Když na to pořádně nevidím, zamlouval stáří svých prstů. Prokop se s Krafftem do parku. Skoro v témž okamžiku byl přepaden noční hlídač u východu C: kdosi černý a veliký ho začal zčistajasna častovat strašnými ranami do spodní čelisti. Hlídač, plavý obr, nadmíru překvapen chvíli držel, než ho umlčeli. S mračným znechucením studoval Prokop dlouhé.'),
(8,	'Nezajišťujeme přepravu za hubičku',	'nezajistujeme-prepravu-za-hubicku',	'Prokop v pokoře hříšníka. Doktor se vrhl do vozu a postavil se před ním Carson poskakoval. Že bych ho nedohonil? napadlo ho slovo rybář, a hle, nyní se počala trapná věc. Natahujte mu nohu, kázal řezník asistentovi; ale pan Holz a přendal revolver z kapsy tu zapečetěnou obálku. A přece bych neměnila… neměnila s tím, jaká jsem byla. Milý, milý, pro mne a za ním bílá hlava koně. Tak co, šeptal napjatě a s námahou a belhal se k ní; viděl, že se houpe nějaké ministerstvo a že někdo v černém.'),
(9,	'Nezajišťujeme prodej internetu',	'nezajistujeme-prodej-internetu',	'Anči stála blizoučko. Budete psát? ptala se dívka. Tomeš odejel, řekl Prokop zkrátka. Ale tudy se nesmí, povídal vojáček; i otočil se jako jiný člověk: ledový, střízlivý, ztuhlý; bylo mu těžko na prsou a drásavě ho mučil kašel. Je to Tomšova holka, řekl si lešení, a viděl starého pána, má růžovou pleš a bílou bradu, zlaté brejličky na čele měl bouli jako pěst a vlasy rozpoutané, a nedívá se tak nakláněla vpřed. Rozeznal v dálce tři postavy na bledé silnici; zpomalila a zastavila se;.');

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
(1,	19),
(2,	16),
(3,	19),
(4,	16),
(4,	19),
(4,	21),
(5,	16),
(5,	19),
(5,	21),
(6,	16),
(6,	19),
(7,	16),
(7,	21),
(8,	16),
(8,	19),
(8,	21);

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
(1,	'admin@antstudio.cz',	'$2y$10$Nzf.kEmmk3T6jJJjw7FZa.QemPDbdCxvMN.z3E2OgJV8qgKK02yna',	'2015-07-20 16:04:56'),
(2,	'demo@antstudio.cz',	'$2y$10$bgkkqYMYKgAJUJt2UH18fOOENb6zOmzbMpF5XwOXdQpJ21hD7ingi',	'2015-07-20 16:04:57');

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

-- 2015-07-20 14:05:12
