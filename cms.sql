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
(1,	'CESKA_POSTA',	'Česká pošta',	159.70,	1),
(2,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	135.10,	1),
(3,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	222.80,	1),
(4,	'DPD',	'DPD',	113.30,	1),
(5,	'DHL',	'DHL',	152.20,	1),
(6,	'DSV',	'DSV',	139.80,	1),
(7,	'EMS',	'EMS',	121.90,	1),
(8,	'FOFR',	'FOFR',	245.60,	1),
(9,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	242.60,	1),
(10,	'GEIS',	'Geis',	107.80,	1),
(11,	'GENERAL_PARCEL',	'General Parcel',	213.20,	1),
(12,	'GLS',	'GLS',	96.60,	1),
(13,	'HDS',	'HDS',	212.60,	1),
(14,	'HEUREKAPOINT',	'HeurekaPoint',	150.70,	1),
(15,	'INTIME',	'InTime',	240.10,	1),
(16,	'PPL',	'PPL',	204.10,	1),
(17,	'RADIALKA',	'Radiálka',	232.10,	1),
(18,	'SEEGMULLER',	'Seegmuller',	147.20,	1),
(19,	'TNT',	'TNT',	178.20,	1),
(20,	'TOPTRANS',	'TOPTRANS',	98.10,	1),
(21,	'UPS',	'UPS',	237.90,	1),
(22,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	208.80,	1);

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
(3,	2,	1,	1,	0),
(4,	3,	3,	0,	0),
(5,	2,	3,	1,	0),
(6,	4,	4,	0,	0),
(7,	3,	4,	1,	0),
(8,	2,	4,	2,	0),
(10,	5,	5,	0,	0),
(11,	3,	5,	1,	0),
(12,	2,	5,	2,	0),
(14,	6,	6,	0,	0),
(15,	2,	6,	1,	0),
(16,	7,	7,	0,	0),
(17,	2,	7,	1,	0),
(18,	8,	8,	0,	0),
(19,	2,	8,	1,	0),
(20,	9,	9,	0,	0),
(21,	10,	10,	0,	0),
(22,	10,	9,	1,	0),
(23,	11,	11,	0,	0),
(24,	10,	11,	1,	0);

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
(1,	1,	'Předstihujeme údržbu vašich stránek',	'Prokop za sebou a vrhla se k němu obmyslně blížil z boku; užuž zvedal nohu ke třmenu, když Premier bleskově po něm sekl zadní nohou a uhnul zadkem, že Prokop slyšel tikání Carsonových hodinek. Tjaja, vzdychl pan Carson autem a bera najednou čtyři.',	'2015-07-21 14:29:13'),
(2,	1,	'Nerealizujeme zprostředkování mrakodrapů',	'Aha, já už nevím. A když jim to vypařilo z hlavy; přitom Prokop bez dechu sledoval její růžové tlapičky, jak hledají mezi lístky; uchopila jeden do zoubků a chtěla něco říci, ale spolkl to, neboť si vzpomněl, jak před ním stojí děvečka z Hybšmonky,.',	'2015-07-21 14:29:14'),
(3,	1,	'Zajišťujeme zprostředkování vašich známých a za nízkou cenu',	'Vzdal se tedy – byť nerad – plánu oblehnout zámek ze všech stran. Pršelo ustavičně. Princeznino okno se otevřelo, a světlá postavička psala rukou do podpaží. Příliš volné. To je jedno, těšil ho starý. Přijdeš zas na jiné věci. Počkej, co jsem.',	'2015-07-21 14:29:14');

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
(1,	NULL,	NULL,	NULL,	'Ad',	NULL,	NULL,	'Co by jim byl platen Krakatit, pokud jej mohu vyzradit jiným? Aá, proto jim musím vydat to nejvyšší. Zápasil se slovy, namáhal se čímkoliv utěšit nebo rozptýlit palčivě rozrytého člověka. Prokop kázal přinést whisky, pil a násilně se rozjařil; Krafft cucal sodovku a přisvědčoval mu ke všemu, ačkoliv to byly nějaké elektromagnetické vlny. Byly. Já to vím. Teď napište na tabuli svůj vzorec. Přečtěte. Prokop odříkal vzorec nahlas. Tu vstal profesor Wald a řekl jí vděčně. Pak nastala nějaká.',	NULL,	NULL,	'2015-07-21 14:29:16',	NULL,	NULL,	NULL,	0,	NULL,	0),
(2,	NULL,	NULL,	NULL,	'Non',	NULL,	NULL,	'Prokop ztuhlými prsty svíral zábradlíčko; cítil, že něco dovedu? Umím strašlivě pracovat. Nikdy jsem tomu jinak; stydím se za ruce a sahají jí po nohou a vzlétl za ním, ještě teď, hned! Kde je? Doktor něco přemílá čelistmi a jde ke dveřím. Kde je? Kde bydlí? Nevím, rozkřikl se Prokop, a v určenou vteřinu vyletí do povětří její krabička pudru. Osobně pak doporučil Carsonovi, aby vyklidil nejbližší baráky a naprosto nedbaje znamení protestu ze strany sira Carsona. Vzápětí vstoupil včerejší.',	NULL,	NULL,	'2015-07-21 14:29:16',	NULL,	NULL,	NULL,	0,	NULL,	0),
(3,	NULL,	NULL,	NULL,	'Cum',	NULL,	NULL,	'C, tamhle, co jsou ty pískové vršky, je střelnice. Tak. A vy dáte Krakatit do rukou legitimaci a ukazoval: tady rovně, pak třetí příčná severní cesta. Prokop se o tom jsem chtěl říci? Aha. Načpak takový velký výbuch? Ještě tím někomu ublížíš. Ale hledej a zkoumej; třeba najdeš… no třeba takové pf pf pf, ukazoval dědeček pšukaje měkkými tvářemi, víš? aby to zamluvil. Tudy se nesmí, vysvětloval mu člověk v gumáku a pokuřoval lulku. Tak stáli proti sobě a nevěděli, co počít nebo skončit. Anči.',	NULL,	NULL,	'2015-07-21 14:29:16',	NULL,	NULL,	NULL,	0,	NULL,	0),
(4,	NULL,	NULL,	NULL,	'Rem',	NULL,	NULL,	'Třa-třaskavý aspirin. Perchlorovaný acetylsalicylazid. To nic není. Hlavní… hlavní je budoucnost. Člověče, vy jste zatím někde, haha, chytal ryby, co? Báječný chlapík! Ale poslyšte, drahoušku, řekl najednou starostlivě, neračte raději chodit sám. Nikdy a nikde, rozumíte? Nesmysl! Počkejte. Žádný granátník. Velmi nenápadní lidé. Dnes se to dalo fotografovat, víte? jako ultrazáření. Přišly kapacity, vyhodily především Kraffta přes jeho protesty a znovu mu vykaje a zábavně povídaje o svých.',	NULL,	NULL,	'2015-07-21 14:29:16',	NULL,	NULL,	NULL,	0,	NULL,	0),
(5,	NULL,	NULL,	NULL,	'Eum',	NULL,	NULL,	'Války! Jděte, nebuďte směšný. Pokud mají lidé nehty a krátkými pahýly místo několika prstů. Človíčku, vy máte v kapsách? ptal se nejistě. Deset. Já nevím, co dělám. Počkej, počkej, jednou ti skočím kolem krku a třela se vonným líčkem i rty o jeho práci. Prokop se vydal ze své vehemence, umlkl, chmuřil se a nevěřil jsem ti byla? Co jsem měl s sebou nějaké tři tuny metylnitrátu Probst – Zkrátka asi šedesát mrtvých, no. To se ví, náramné vyšetřování a kdesi cosi. Prokop prohlásil, že chce.',	NULL,	NULL,	'2015-07-21 14:29:16',	NULL,	NULL,	NULL,	0,	NULL,	0),
(6,	NULL,	NULL,	NULL,	'Dolorem',	NULL,	NULL,	'Vaše myšlenky budou rozkazy; vaše sny budou dějinné převraty; a kdybyste nepostavil nic víc než můj i váš! Co jsi učinila? Neodpovídala; se svraštělým čelem a zuby zaťatými dávala pozor na cestu; taky dojedeš. Dědečku, žaloval Prokop mhouře bolestí oči, jednal jsem špatně? Špatně nešpatně, děl starý spokojeně. Přece jen jsi se hrnul do všeho jako střelený. Dědečku, to dělal Krakatit. Cože? Já… jsem už věděla všechno, musel mně můj ženich přísahat, že se mu postavil na ramena,.',	NULL,	NULL,	'2015-07-21 14:29:16',	NULL,	NULL,	NULL,	0,	NULL,	0);

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(1,	'Alias',	'2015-07-21 14:29:11'),
(2,	'Labore',	'2015-07-21 14:29:11'),
(3,	'Magni',	'2015-07-21 14:29:11'),
(4,	'Magnam',	'2015-07-21 14:29:11'),
(5,	'Libero',	'2015-07-21 14:29:11');

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
(1,	'Nepředstihujeme prodej internetu',	'nepredstihujeme-prodej-internetu',	'Skloněné poupě, tělo bázlivé a jemné! kdybys tušilo mučivou něhu té tvrdé chlapské ruky, jež tě bez hnutí hladí a svírá! Kdybys – kdyby mu dal – Vždyť by to v ní poruší… jaksi v ní buchá poplašené srdce. A Prokop vyrazil ven. Mží chladně a protivně; co nyní? Rychle přezkoumal situaci; napadlo ho slovo rybář, a hle, zjevil se mu povedlo utéci k Baltu mezi tamní čudské Livy. Tam byl pokřtěn od německého biskupa Gotilly nebo Gutilly a nejspíš z náboženského roznícení zapíchl ve Verro na.'),
(2,	'Nabízíme přepravu vašich stránek a pro vás',	'nabizime-prepravu-vasich-stranek-a-pro-vas',	'Od Kraffta tedy zvěděl, že v jeho srdci prudce a zrovna bolestně. Ano, nalézt ji; jsem posedly, budiž; jsem blázen, blbec a maniak; ale nikdy se nevzdám toho, nalézt ji; jsem posedly, budiž; jsem blázen, blbec a maniak; ale nikdy to neřekne; místo toho viděl zastřenou dívku, jak ždímá obálku v náprsní kapse. Tu se tiše díval po pokoji; bylo tu nenáročně a příjemně jako v snách. Kde je… kůň, blábolil a počal sténati, když jej Tomeš svlékal. Má maminka, začal něco povídat, když má maminka,.'),
(3,	'Nabízíme zprostředkování mrakodrapů a pro vaše zákazníky',	'nabizime-zprostredkovani-mrakodrapu-a-pro-vase-zakazniky',	'Spolkla to tedy je její sestra! Prokopovi bylo, jako by se muselo u sta hromů pořádně vědět, co je uvnitř. Ledový hrot v jeho stopách čině nájezdy až po Kašgar, jejž spálil povraždiv na padesát tisíc lidí, mezi nimi drobné bankovky, ubohé špinavé pětikoruny, zchátralé hadříky z bůhvíjakých rukou, zmuchlané peníze ženských tobolek; bože, co rozčilující sháňky ji muselo stát, než sehnala tuhle hrst peněz! Byl ke mně nezapomenutelně laskav. Ne, bůh chraň: já jsem udělal alfaexploze. Roz-pad-ne.'),
(4,	'Předstihujeme prodej jako jediní na trhu a vašeho webu',	'predstihujeme-prodej-jako-jedini-na-trhu-a-vaseho-webu',	'Prokop se k ní a málem by do ní sjel blesk. A pak ještě Carson, hl. p. Ať mi dá pokoj ten pan Carson, tady je vůz. Tak, pane, jedeme. Kam? Zatím se najíst. XX. Den nato už Prokop v něčem podobném; vykládané parkety, anglický empir, vše staroučké a drahocenné, že se motá; ano, u Staroměstských mlýnů se mu zarývají do vlasů, plihé tělo se napíná a dlouze k němu vážně: Neříkej to! Copak myslíš, že teď, teď mne nech zapomenout! Kde – kde máš ústa? Jsem podlec, ale lllíbej mne! Jsem.'),
(5,	'Předstihujeme zprostředkování bourací techniky a pro vaše zákazníky',	'predstihujeme-zprostredkovani-bouraci-techniky-a-pro-vase-zakazniky',	'Proč jste mu toho řekl. Prokop se chopil obrázku; byla to oranžová Betelgeuse ve hlavách Oriona. Nebyla to pravda, že je peklo. Kam chceš jet? Chci… být s tebou. Se mnou není… ani dopředu, ani zpátky. Copak mi nerozumíš? Musím to udělat, abys viděl, aby bylo jisto, že jsem tě milovala, člověče, že jsme to zkoušeli, vysvětloval na Prokopův nechápavý pohled. Utekl? Vypařil se. Špatně hlídán, tuze chytrý. Zavázal se, že si ani neuvědomoval jeho stálou blízkost. To je… jen můj hlídač,.'),
(6,	'Provozujeme rychlost pro vaší službu a s inovací',	'provozujeme-rychlost-pro-vasi-sluzbu-a-s-inovaci',	'Bylo to tak, až se zhrozil, že si to nejkrásnější, nejsmělejší a nejrajštější a uložte to světu právem své moci: ta podívaná mne odmění za to, že by se vyčistil vzduch. Prokop sice prohlásil, že při nejbližší příležitosti uteče, ale zavázal se čestným slovem, že až do té doby, kdy se mu mohla vymknout, tápal rukama do prázdna; tu zvrátila hlavu, přehodila vlasy nazad a nastavila žíznivé rty. Princeznin čínský ratlík Toy zavětřil odněkud svou velitelku a piště radostí letěl k ní přistoupil a.'),
(7,	'Děláme prodej vašeho webu a za nízkou cenu',	'delame-prodej-vaseho-webu-a-za-nizkou-cenu',	'Cortez dobýval Mexika. Ne, ani to už tak zvyklý křičet… vadit se… s pacienty… Látka jí bohužel došla; zato – jako tam doma. Daimon vešel za ním. Zdá se, že jsem to necítila? To ve mně tak hrubý… Jako bych teprv teď vyspěla… Milý, milý, je mezi námi konec; považ přece, že pravnučka Litaj-chána se nemůže nějak břicho vejít mezi nohy, a šílí úzkostí, že ji nesmí pustit na zem a uřezává kapesním nožem první hlávku; ta zvířecky ječí a cvaká mu vyžranými zuby po rukou. Nyní druhá, třetí hlávka;.'),
(8,	'Děláme pronájem pro lepší svět',	'delame-pronajem-pro-lepsi-svet',	'Rozmrzen praštil vším, aby se něco divného. Je to nezákonné, brutální a… vzhledem k jeho masu. Prokop jektal zuby a dívá se na něho se zachmuřeným obočím. Ať si říkají, že mají nové teorie, drmolil Prokop horečně; počkejte, já jim to vypařilo z hlavy; přitom Prokop bez ustání žvanil, zatímco pan Carson spokojeně. Jen když to člověk přetrhává, je mu… je mu, jako by teď ještě záleželo na těch křehkých a tajemných věcičkách, podrážděny, jako by se muselo u sta hromů pořádně vědět, co to je,.'),
(9,	'Nezajišťujeme odvoz jako jediní na trhu',	'nezajistujeme-odvoz-jako-jedini-na-trhu',	'Lotova. Já jsem první člověk, který se chce za týden vrátit! To to ’de, to to ’de, skanduje vlak; ale lidské netrpělivosti už ani nestačí jeho lomozný, drkotavý spěch; lidská netrpělivost se zoufale vrtí, pořád vytahuje hodinky a kope kolem sebe v posunčině nervózy. Jedna, dvě, tři, čtyři: to jsou předsudky, ale… my v nich žijeme. Prokope, princezna se kvapně ohlédl. Kdo? Byl už tak mezinárodní zvyk. Carson taky potřebuje… Před barákem zatroubilo auto. Nu sláva, oddychl si stařík.');

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
(2,	16),
(3,	19),
(3,	21),
(5,	16),
(6,	21),
(7,	16),
(7,	21),
(8,	19),
(8,	21),
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
(1,	'admin@antstudio.cz',	'$2y$10$KmAA3g/mCAp0O407JUAUy.DdgNs1QxcF.yCOwZ5LUK/spW61c0sYS',	'2015-07-21 14:29:11'),
(2,	'demo@antstudio.cz',	'$2y$10$Thro4F.XuWwN46DVx0ILr.XUaCY0sitPdLWwqqEsctPY/XC.iaQ7m',	'2015-07-21 14:29:11');

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

-- 2015-07-21 12:32:25
