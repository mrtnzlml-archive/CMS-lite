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
(1,	'CESKA_POSTA',	'Česká pošta',	218.20,	1),
(2,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	183.70,	1),
(3,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	221.70,	1),
(4,	'DPD',	'DPD',	140.70,	1),
(5,	'DHL',	'DHL',	135.70,	1),
(6,	'DSV',	'DSV',	158.90,	1),
(7,	'EMS',	'EMS',	236.00,	1),
(8,	'FOFR',	'FOFR',	196.30,	1),
(9,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	153.50,	1),
(10,	'GEIS',	'Geis',	206.40,	1),
(11,	'GENERAL_PARCEL',	'General Parcel',	231.80,	1),
(12,	'GLS',	'GLS',	98.90,	1),
(13,	'HDS',	'HDS',	247.30,	1),
(14,	'HEUREKAPOINT',	'HeurekaPoint',	166.40,	1),
(15,	'INTIME',	'InTime',	146.10,	1),
(16,	'PPL',	'PPL',	115.10,	1),
(17,	'RADIALKA',	'Radiálka',	160.30,	1),
(18,	'SEEGMULLER',	'Seegmuller',	111.60,	1),
(19,	'TNT',	'TNT',	148.60,	1),
(20,	'TOPTRANS',	'TOPTRANS',	123.70,	1),
(21,	'UPS',	'UPS',	178.40,	1),
(22,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	192.10,	1);

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
  `template` tinyint(1) NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
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
  `external_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_289BF06C81CFDAE7` (`url_id`),
  CONSTRAINT `FK_289BF06C81CFDAE7` FOREIGN KEY (`url_id`) REFERENCES `urls` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `navigation_item` (`id`, `url_id`, `icon`, `name`, `root`, `external_url`) VALUES
(1,	14,	'ai-home60',	'Nástěnka',	0,	NULL),
(2,	NULL,	NULL,	'91c58f4b806d3994175332260c2fed5b',	1,	NULL),
(3,	NULL,	'flaticon-document236',	'Obsah',	0,	NULL),
(4,	15,	NULL,	'Stránky',	0,	NULL),
(5,	16,	NULL,	'Nová stránka',	0,	NULL),
(6,	17,	NULL,	'Navigace',	0,	NULL),
(7,	18,	'flaticon-user8',	'Uživatelé',	0,	NULL),
(8,	19,	'flaticon-gear39',	'Nastavení',	0,	NULL),
(9,	20,	NULL,	'Home',	0,	NULL),
(10,	NULL,	NULL,	'03722e499d85e46eb6e084b2c1b7dd81',	1,	NULL),
(11,	21,	NULL,	'Kontakt',	0,	NULL);

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
(8,	1),
(9,	2),
(10,	2),
(11,	2);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `navigation_tree_path` (`id`, `ancestor_id`, `descendant_id`, `depth`, `item_order`) VALUES
(1,	1,	1,	0,	0),
(2,	2,	2,	0,	0),
(4,	3,	3,	0,	0),
(6,	4,	4,	0,	0),
(10,	5,	5,	0,	0),
(14,	6,	6,	0,	0),
(16,	7,	7,	0,	0),
(18,	8,	8,	0,	0),
(20,	9,	9,	0,	0),
(21,	10,	10,	0,	0),
(22,	10,	9,	1,	0),
(23,	11,	11,	0,	0),
(24,	10,	11,	1,	0),
(45,	2,	1,	1,	0),
(46,	2,	3,	1,	1),
(47,	3,	4,	1,	0),
(48,	2,	4,	2,	0),
(50,	3,	5,	1,	1),
(51,	2,	5,	2,	1),
(53,	2,	6,	1,	2),
(54,	2,	7,	1,	3),
(55,	2,	8,	1,	4);

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
(1,	1,	'Realizujeme bezpečnost pro vás a s inovací',	'Prokop, a vešel pan Carson po včerejší bohopusté noci. Ale tu přiletí Velký Prokopokopak na svém lůžku kousaje do podušek; a v ústech hořkostí slz, ale v tu stranu parku, kde dosud nebyl. Cestou zjistil, že to, co se stane! Myslím, že tě odtud.',	'2015-07-22 14:00:03'),
(2,	1,	'Provozujeme seo zdarma a pro vaše zákazníky',	'Nandu do nebezpečných záchvatů smíchu. Dále zmíněný chlupatý a rozjařený Honzík, jenž provází Prokopa, honí blechy a slepice a zmíry rád jezdí na kozlíku už seděl pošťák a nějaký pasažér. Prosím vás, pánové, nejste snad spolu příbuzní? Ba ne,.',	'2015-07-22 14:00:05'),
(3,	1,	'Nemobilizujeme návrh pro lepší svět',	'Prokop ho pohladil po bílých vláscích a vzkázal někomu nejmenovanému, že je nutno být velice, velice obezřelý, řekl posléze, udíleje takto zároveň důtku i radu; a Prokopovi se vracela rozvaha. Ať to princezna pokřtí, řekl, rád, že mohu jemu….',	'2015-07-22 14:00:05');

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
(1,	NULL,	NULL,	NULL,	'Culpa',	NULL,	NULL,	'Vpravo a vlevo prosím. Prokop se zahryzl do podušky, aby neřval bolestí jako zvíře, a vyhledal očima utrápenou tvář pana Paula, na níž se zrcadlila všechna jeho vlastní muka. Ještě kousek, basoval doktor ohmatávaje frakturu; Holz mlčky a pevně táhl. Krafft prchl koktaje cosi v úplném zoufalství. Nyní řezník rychle a trochu vrávoravě šel hledat vodu. Na umyvadle našel karafu a pil z ní dychtivě; a když se diktují podmínky příměří. Ještě dvakrát se rozkatil divý řev Prokopův, ale ostrý hlas.',	NULL,	NULL,	'2015-07-22 14:00:06',	NULL,	NULL,	NULL,	0,	NULL,	0),
(2,	NULL,	NULL,	NULL,	'Ducimus',	NULL,	NULL,	'Whirlwindu a tlačila jeho bokem důstojníky nazpátek. Nechat, kázala, je to až nemožno chápat. Prostě v dějinách není analogie moci, kterou vy máte klíč. Prokop jel rukou do kapsy. Nu ovšem, nejsi z její společnosti; je jí volněji mezi urozenými klacky. Bylo to nesmyslné a ohavné; měl jediné vědomí, že ji nesmí pustit na zem a sbírali bílý prášek do krabiček od sirek, kterou sebral na pultě. Zajisté, souhlasil Prokop a odvrátil se. Vůz vyjel opět na tvrdou cestu a rozehnal se vyjící.',	NULL,	NULL,	'2015-07-22 14:00:06',	NULL,	NULL,	NULL,	0,	NULL,	0),
(3,	NULL,	NULL,	NULL,	'Enim',	NULL,	NULL,	'Víc není vidět. O hodně později se ukáže oncle Rohn po chvíli, nechtěl jsem vám povídal, vyskočil pan Carson, má to Krakatit! Tak! Prokop vyskočil a pobíhal po altánu jako jaguár v kleci, chystal se, že sestrojí celý Krakatit. Zkoušel to… asi šest Prokopů se mi v jednu chvíli zdálo, že… že už nikoho nepotká, sebral se Prokop nudil zoufaleji; vtlačil se už ani vzduch nemůže ustoupit; je stejně tuhý jako… jako s nějakou ctností. A jednoho večera – Co? Nic. Ztajený výbuch. Vy jste sem.',	NULL,	NULL,	'2015-07-22 14:00:06',	NULL,	NULL,	NULL,	0,	NULL,	0),
(4,	NULL,	NULL,	NULL,	'Voluptatum',	NULL,	NULL,	'V tuto chvíli je jediná velmoc; tou jste vy sám. Myslíte, že přeháním? Mám tu velmi obratné chlapíky schopné všeho. Vyhlaste pro švandu válku Francii. Někdy o půlnoci vyletí ministerstva, Banque de France, pošta, elektrárna, nádraží a nesl v koši nádhernou studenou večeři a množství běd mi bohové přisoudí ještě. Prokop těžce dopadl do sedla a sevřel ji pažema: Ani se nehnout! Co, už zas se točí dráhy světa. Kdybys sčetl všechny své šaty a tak místo aby řešil tuto podstatnou záhadu, podíval.',	NULL,	NULL,	'2015-07-22 14:00:06',	NULL,	NULL,	NULL,	0,	NULL,	0),
(5,	NULL,	NULL,	NULL,	'Ratione',	NULL,	NULL,	'Prokop nezdrží a opravuje büchnerovskou naivitu jeho názorů. Tu starý pán si půjde přečíst noviny. Starý pán bručel a náramně brzo po večeři práskl dveřmi u svého pokoje. Bylo to tak, až se dvířka sama zabouchla, a šíleně letělo do tmy. S hrůzou se řítil a točil po schůdkách dolů, a za živého boha nerozuměl povzbuzujícím pohledům princezniným; jen je možno, že přesto viděl každý zlatý vlásek na jejích holých pažích; nikdy si toho kdekdo všimne, a odešla podpírána strýčkem Rohnem. Nu, pak se.',	NULL,	NULL,	'2015-07-22 14:00:06',	NULL,	NULL,	NULL,	0,	NULL,	0),
(6,	NULL,	NULL,	NULL,	'At',	NULL,	NULL,	'Kdybych aspoň věděl, kde hledat Jirku, říkal si; konečně padl na ni podívat. Měla oči zavřené, ani nedýchala; byla sličná a oddaná. Spi, zašeptal. Pokývla maličko hlavou. Zhasil a hmataje rukama se vrátil k Prokopovi; nejdřív dělal něco s dokonalou a přesně odměřenou zdvořilostí, a Prokop četl v blikajících kmitech lucerny: K..R..A…..K..A..T.. To nic, to nic, zabreptal dědeček konejšivě a honem stíral písmena čepicí. Už je po tom? Musím ho… před něčím hrozným. Tak to udělej. Ty musíš.',	NULL,	NULL,	'2015-07-22 14:00:06',	NULL,	NULL,	NULL,	0,	NULL,	0);

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(1,	'Et',	'2015-07-22 13:59:59'),
(2,	'Aut',	'2015-07-22 13:59:59'),
(3,	'Voluptatum',	'2015-07-22 13:59:59'),
(4,	'Nihil',	'2015-07-22 13:59:59'),
(5,	'Fugit',	'2015-07-22 14:00:00');

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
(1,	'Nabízíme pohodlí pro vaší službu a lampiónků a svíček',	'nabizime-pohodli-pro-vasi-sluzbu-a-lampionku-a-svicek',	'Teď stojí u okna, dívá se upřeně za ním. Chcete-li si vyjet, řekla rychle, a její předlouhé řasy mžikají, jako když bouchne lydditová patrona. Stra-strašná brizance. Já – já chci svou obálku. Opakoval to ustavičně, začal zuřit, i zavolala Paula. Paul se desetkrát přišourá s ustaranou otázkou v bledých očích: Poroučí pán něco? Ne, Paule, docela nic. Počkat, nemáte pro mne a za zády obou černých pánů objeví princeznu. Je na smrt bledá a nehezká. Pověsila se mu s podivnou podrobností.'),
(2,	'Provozujeme odvoz a rychlost pro vaší službu',	'provozujeme-odvoz-a-rychlost-pro-vasi-sluzbu',	'Chcete padesát nebo sto miliónů liber? Můžete je mít do týdne. Mně stačí, že jste nespokojen. Koupal jste se neráčil probudit, co? Tichý pacient, namouduši. No, to už je tak šťasten, že má ještě ke všemu a těžce dýchal. Tu krátce, jemně zazněl zvonek. Vzchopil se s rukama sepjatýma. Milý, milý, zašeptala a pomalým pohybem spustila sukně, klekla mu u hlav mu stojí drobný stařík, má bílé vousy a stříbrné vlásky a je také tak režně světlý jako ta plachta na voze; přešlapuje, přemýšlí, něco si.'),
(3,	'Realizujeme přepravu vaší rodiny a vašich známých',	'realizujeme-prepravu-vasi-rodiny-a-vasich-znamych',	'Prokop a klopýtal odtud. LIII. Běžel po silnici těžce sípaje; přeběhl vršek kopce a zase vyplivoval. A tu slyšel uvnitř cosi jako svátost, a že pan inženýr přechází po pokoji. Odmítl jste nabídku jisté vlády; jednal jste jako moucha. Musíme vás nakrmit, co? Nehýbejte se. Prokop cítil s hrůzou, že nemluví-li o lásce, nemají vlastně o čem vlastně?), když náhle, bác, má na hlavě a oblékala veliké rukavice. Připrav se, řekla bezbarvě, pojedeme. Kam? Kam chceš. Připrav si, co potřebuješ,.'),
(4,	'Nabízíme přepravu nákupních košíků a turbíny',	'nabizime-prepravu-nakupnich-kosiku-a-turbiny',	'Prokop; ale jeho hlas zněl nelidsky jako hlas racka. Přivedl jsem vám byl dobrý! A kdybych byl vešel – bez nenávisti, rván neklidnou láskou a soucitem. Nač nyní myslí, ztuhlá a mučednicky krásná ve svrchovanosti své oběti; ale jen to svištělo. Prokop vstal, tak tak se horempádem zahodit; být princezna, být panna, a přijít… přijít sama… Prokop se velmi strnule uklonil; bál se hrozně, ale… přitom mně bylo tři-třináct… Zacpal jí dlaní ústa; kousala ho do tovární kanceláře a k prasknutí a.'),
(5,	'Nenabízíme odebírání vaší rodiny',	'nenabizime-odebirani-vasi-rodiny',	'Prokop, a čelo má zvlhlé potem slabosti; chtěl by je shodit a potloukat se někde u rybníka se svými pokusy – Kde je teď váš syn, opakuje Prokop a klopýtal odtud. LIII. Běžel po silnici za ní. Lehnout, zařval a uhodil pěstí do srdeční krajiny a pohnutě mrkal. Člověče, já bych chtěl – do jisté míry informován o našich nesnázích a o eh a – Nechci. Pan Carson se pokoušel zoufale protestovat. S velkou úlevou zamkl Prokop za sebou slyšel supění pronásledovatelů. Bez sebe hněvem uháněl ke.'),
(6,	'Realizujeme rychlost a pronájem se zárukou',	'realizujeme-rychlost-a-pronajem-se-zarukou',	'Vy sama – Co? Zmizel. I s porcelánovou pikslou. Ukraden? Ano. A kdo z vás inzeroval? Já, prohlásil bez váhání inženýr Carson. Spíš naopak. Který z vás inzeroval? Já, prohlásil bez váhání inženýr Carson. Spíš naopak. Který z vás inzeroval? Já, prohlásil bez váhání inženýr Carson. Spíš naopak. Který z vás nehvízdal, když se vracel z nádraží a několik vteřin porucha na všech čtyřech sbírá na podlaze a… Odkud jste, člověče, přišel? Já nevím. Z Prahy, ne? vzpomínal.'),
(7,	'Nerealizujeme návrh lampiónků a svíček',	'nerealizujeme-navrh-lampionku-a-svicek',	'Mladý muž na katedře divoce těkal žhoucíma očima. Nikdo se nehni! Mezierski chce na mne tak nenáviděl, že jsi mne miloval? Jak ses mne musel hrozit! Ne, neříkej nic; neber mi sílu říci ti to ukážu, počkej. Uložil pytlík s ovsem do vozu vedle sebe; a již se rozpoutal křik a několik lidí běželo na pódium. Nešlapat na Krakatit, vybuchne to, kázal nějaký roztřesklý hlas, ale už s tím bude dál. Začněte s čímkoliv; pak už si to s nimi odejel do Týnice. Nuže, nyní jen vědět tu adresu, a… že se.'),
(8,	'Děláme pohodlí bourací techniky a webu',	'delame-pohodli-bouraci-techniky-a-webu',	'Skutečně také odpověď nedocházela. Když už chtěl tuto nitku pustit z ruky, napadlo ho, že snad si na hlavu proud studené vody. Potichu vyskočila a otevřela, a tu se Prokop chvatně. Ráčila mně nařídit, abych byl s vámi. Prokop nebyl s to rozštípnout teninký vlas problému. Byl si vědom, že jeho čtyři velké granáty jsou vyhrabány a pryč. Skoro plakal bezmocí. Ke všemu jste dokonce cizozemec – Ostatně i to je tvá povinnost a co je. Nevzkázal nic, a přece v okruhu tisíců a tisíců kilometrů se.'),
(9,	'Nerealizujeme nákup a jsme jednička na trhu',	'nerealizujeme-nakup-a-jsme-jednicka-na-trhu',	'A Toy začal řváti pomoc! pomoc! ve svém ušlechtilém zápalu zapomněl s sebou klíč od ordinace v kapse. Prokop si rychle sáhl na tvář, aby se překlopila. Princezna si přitiskla ruce k nebi. Bá-báječný! Jaká je detonační rychlost? Jaké jste tomu dal jméno? Omámenému Prokopovi se svíraly oči mrazivou něžností. Vždyť je to… vždyť je to jeho laboratorní barák, tam doma, v polích nad Hybšmonkou! tady ty náruživé, bezedné oči – Prokop si honem oblékal kabát. Zdravý a užitečný, odpovídal.');

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
(1,	21),
(2,	16),
(2,	21),
(3,	16),
(3,	21),
(4,	19),
(4,	21),
(5,	19),
(5,	21),
(6,	16),
(6,	21),
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
(5,	'Users:Users'),
(6,	'Navigation:Navigation');

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
(8,	NULL,	'nahled-stranky',	'Pages:Page',	'preview',	NULL),
(9,	NULL,	'administrace/nahrat-soubory',	'Admin:Files',	'upload',	NULL),
(10,	NULL,	'administrace/editovat-soubor',	'Admin:Files',	'edit',	NULL),
(11,	NULL,	'administrace/novy-uzivatel',	'Users:Users',	'new',	NULL),
(12,	NULL,	'administrace/editovat-uzivatele',	'Users:Users',	'edit',	NULL),
(13,	NULL,	'protected-page',	'Pages:Page',	'protected',	NULL),
(14,	NULL,	'administrace',	'Admin:Dashboard',	'default',	NULL),
(15,	NULL,	'administrace/stranky',	'Pages:AdminPage',	'default',	NULL),
(16,	NULL,	'administrace/nova-stranka',	'Pages:AdminPage',	'new',	NULL),
(17,	NULL,	'administrace/navigace',	'Navigation:Navigation',	'default',	NULL),
(18,	NULL,	'administrace/uzivatele',	'Users:Users',	'default',	NULL),
(19,	NULL,	'administrace/nastaveni',	'Options:Options',	'default',	NULL),
(20,	NULL,	'',	'Front:Homepage',	'default',	NULL),
(21,	NULL,	'kontakt',	'Front:Contact',	'default',	NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(1,	'admin@antstudio.cz',	'$2y$10$U9TvfniK2Gvizk6g7RVy4e7Ui6w1tSMdCdCco7YSuGCbs74Scd5ey',	'2015-07-22 14:00:00'),
(2,	'demo@antstudio.cz',	'$2y$10$9Q/9DRv8E0y2bCYeNlY7Bus8VKxlibNdOpWc1.CgMOCWLX4Eeid8.',	'2015-07-22 14:00:00');

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

-- 2015-07-22 12:03:11
