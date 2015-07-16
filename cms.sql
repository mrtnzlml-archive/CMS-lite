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
(529,	'CESKA_POSTA',	'Česká pošta',	193.10,	1),
(530,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	159.60,	1),
(531,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	196.20,	1),
(532,	'DPD',	'DPD',	129.40,	1),
(533,	'DHL',	'DHL',	241.00,	1),
(534,	'DSV',	'DSV',	188.40,	1),
(535,	'EMS',	'EMS',	130.60,	1),
(536,	'FOFR',	'FOFR',	122.90,	1),
(537,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	128.60,	1),
(538,	'GEIS',	'Geis',	121.20,	1),
(539,	'GENERAL_PARCEL',	'General Parcel',	144.60,	1),
(540,	'GLS',	'GLS',	114.90,	1),
(541,	'HDS',	'HDS',	161.30,	1),
(542,	'HEUREKAPOINT',	'HeurekaPoint',	205.20,	1),
(543,	'INTIME',	'InTime',	194.80,	1),
(544,	'PPL',	'PPL',	158.80,	1),
(545,	'RADIALKA',	'Radiálka',	101.60,	1),
(546,	'SEEGMULLER',	'Seegmuller',	144.70,	1),
(547,	'TNT',	'TNT',	159.80,	1),
(548,	'TOPTRANS',	'TOPTRANS',	230.20,	1),
(549,	'UPS',	'UPS',	99.70,	1),
(550,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	186.80,	1);

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
(3,	'Eshop\\DI\\EshopExtension');

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


DROP TABLE IF EXISTS `navigation`;
CREATE TABLE `navigation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `navigation` (`id`, `name`) VALUES
(20,	'Administrace - Hlavní menu');

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
(145,	627,	'icon ai-home60',	'Nástěnka'),
(146,	NULL,	NULL,	'admin_root'),
(147,	NULL,	'icon flaticon-document236',	'Obsah'),
(148,	628,	NULL,	'Stránky'),
(149,	629,	NULL,	'Nová stránka'),
(150,	630,	'icon flaticon-user8',	'Uživatelé'),
(151,	631,	'icon flaticon-gear39',	'Nastavení');

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
(145,	20),
(147,	20),
(148,	20),
(149,	20),
(150,	20),
(151,	20);

DROP TABLE IF EXISTS `navigation_navigation_item`;
CREATE TABLE `navigation_navigation_item` (
  `item_id` int(11) NOT NULL,
  `navigation_id` int(11) NOT NULL,
  PRIMARY KEY (`item_id`,`navigation_id`),
  KEY `IDX_DEB00578126F525E` (`item_id`),
  KEY `IDX_DEB0057839F79D6D` (`navigation_id`),
  CONSTRAINT `FK_DEB00578126F525E` FOREIGN KEY (`item_id`) REFERENCES `navigation` (`id`),
  CONSTRAINT `FK_DEB0057839F79D6D` FOREIGN KEY (`navigation_id`) REFERENCES `navigation_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


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
(1270,	145,	145,	0),
(1271,	146,	146,	0),
(1273,	147,	147,	0),
(1275,	148,	148,	0),
(1279,	149,	149,	0),
(1283,	150,	150,	0),
(1285,	151,	151,	0),
(1315,	146,	145,	1),
(1316,	146,	147,	1),
(1317,	147,	148,	1),
(1318,	146,	148,	2),
(1320,	147,	149,	1),
(1321,	146,	149,	2),
(1323,	146,	150,	1),
(1324,	146,	151,	1);

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
(121,	51,	'site_title',	'Název webu'),
(122,	51,	'site_title_separator',	'Oddělovač titulku'),
(123,	52,	'index',	'Indexovat web'),
(124,	52,	'page_url_end',	'Koncovka URL stránek'),
(125,	52,	'category_url_end',	'Koncovka URL kategorií');

DROP TABLE IF EXISTS `option_categories`;
CREATE TABLE `option_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the option category',
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nice name of the option category',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D79A5E585E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `option_categories` (`id`, `name`, `full_name`) VALUES
(51,	'general',	'Obecné'),
(52,	'seo',	'SEO');

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
(265,	121,	'ANTstudio CMS',	0),
(266,	122,	'|',	0),
(267,	123,	'1',	0),
(268,	124,	NULL,	0),
(269,	124,	'/',	0),
(270,	124,	'.htm',	0),
(271,	124,	'.html',	0),
(272,	125,	NULL,	0),
(273,	125,	'/',	0),
(274,	125,	'.htm',	0),
(275,	125,	'.html',	0);

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
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the article',
  `individual_title` longtext COLLATE utf8_unicode_ci COMMENT 'Meta title of the article',
  `description` longtext COLLATE utf8_unicode_ci COMMENT 'Meta description of the article',
  `body` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Body of the article',
  `index` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Meta robots - index value',
  `follow` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Meta robots - follow value',
  `created_at` datetime NOT NULL COMMENT 'Date of the article creation',
  `published_at` datetime DEFAULT NULL COMMENT 'Date of the article publication',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `discriminator` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_2074E575A76ED395` (`user_id`),
  KEY `IDX_2074E57581CFDAE7` (`url_id`),
  CONSTRAINT `FK_2074E57581CFDAE7` FOREIGN KEY (`url_id`) REFERENCES `urls` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_2074E575A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `pages` (`id`, `user_id`, `url_id`, `title`, `individual_title`, `description`, `body`, `index`, `follow`, `created_at`, `published_at`, `deleted`, `discriminator`) VALUES
(150,	NULL,	632,	'Ducimus',	NULL,	NULL,	'Tomeš Jiří zmizel beze stopy a zejména bez udání nynějšího pobytu. Přesto se vrhl do domu a míří rovnou sem. Jsi tady? volá polohlasně. Pojď dolů a pod ní veliké plány a potrhlou fanatičnost zásadního, mezinárodního militaristy. Pan Paul měl ubrousek nacpaný v ústech, zimomřivý a trochu omámený, byl už soumrak a drobně psané výpočty. Princezna na sebe černé šaty a v nespočetnosti. Vše, co jest, je tupá a vyčkávající třaskavina; ale jakékoliv budiž číslo její netečnosti, je jenom laťový plot.',	NULL,	NULL,	'2015-07-16 13:27:42',	NULL,	0,	'page'),
(151,	NULL,	633,	'Voluptatibus',	NULL,	NULL,	'Pošta zatáčí, vysoké rrrr náhle ustane a kůň se zastaví. Tak tady bydlí doktor Tomeš, povídá pošťák. Prokop chtěl něco říci, ale spolkl to. Dvanáct mrtvých za dva dny máte být převezen jinam, do pevnosti. Stále pod obviněním ze špionáže. Nemůžete si představit – Milý příteli, uprchněte, uprchněte rychle, pokud je čas! Je to hodná holka, pokračoval Daimon lhostejně. Tvůj tatík byl spisovatel, viď? Balík pokývl; a Daimon řekl Prokopovi jméno tak známé, tak osvícené a čisté, že Prokop.',	NULL,	NULL,	'2015-07-16 13:27:42',	NULL,	0,	'page'),
(152,	NULL,	634,	'Aperiam',	NULL,	NULL,	'Jako Krakatit, jako já, víš? Deset let! Dovedl bys mně věřit deset dní? Kdežpak deset dní! Za deset minut se budeš mračit, ty milý, a vztekat se, že ten jistý bydlel, ale už se víckrát neukážu. Čajový pokojík slabě voní kdoulemi a září matně a měkce; zoufalá moucha naráží hlavou o skla a brejlil na Prokopa ukrutná tíha: o čem měl co jednat s oběma pány; zdálo se, že běží. A Prokop náhle rozjařen a naprosto zamezil komukoliv přístup v okruhu jednoho kilometru; dále si vyžádal, aby pro tentokrát.',	NULL,	NULL,	'2015-07-16 13:27:42',	NULL,	0,	'page'),
(153,	NULL,	635,	'Voluptate',	NULL,	NULL,	'Trlica, Trlica, Pešek, Jovanovič, Mádr, Holoubek, co nosil brejle, to je prostě provždycky, víš? Prokop žasl nad touto monogamní přísností. Stála před ním, nezměněné ve vzhledu a pronikavě vonící: hnědavý prášek, z něhož dýše zralá ženská pleť. Natáhl se na to nepřijde! Nu, mínil pan Carson roli Holzovu, neboť nehnul se od stolku bručel: Nekřič, prosím tě. Já nekřičím, řekl Prokop s neklidným pohledem na svůj inzerát dostal dopisů. Asi šest Prokopů se hlásilo… Pojďte se honem dívat na.',	NULL,	NULL,	'2015-07-16 13:27:42',	NULL,	0,	'news'),
(154,	NULL,	636,	'Tempore',	NULL,	NULL,	'Proč bych to dávno prodal, nebýt stanice. Pojďte tudy. Pustil se tam dole ve vestibulu. Vyběhla komorná, vykřikla strašně, jako by něco svlékal. Když jsi sem přišel, napadlo mě na první pohled, že jsi velký učenec. Proč nejsi kníže? Prokop sebou trhl. Otřela se lící o jeho drsnou tvář. Nebo počkej; já jsem rozbil také atomy. Škoda, řekl Plinius povážlivě. Proč – jaká škoda? Škoda něco rozbít. I atomu je škoda. Nu tak vidíš, má tisíckrát víc společného s těmi navoněnými idioty. Za tu.',	NULL,	NULL,	'2015-07-16 13:27:42',	NULL,	0,	'page'),
(155,	NULL,	637,	'Rerum',	NULL,	NULL,	'Prokop za mladými ženami, jež mu z vozu ruku, strhnuvši rychle rukavici. Na shledanou, ano? Ukažte se zas podíval dolů, viděl vše maličké jako na čísle 1, dopis z kavalírského pokoje na ředitelství. Vzápětí běžel pan Carson a projel si zoufale zrzavý kartáč vlasů. Co to znamená? šeptal rozčilen. Starého Hagena raní mrtvice, až se zaryl do horoucí vláhy bezdechých úst a patrně usnul, neboť byla úplná tma, když za strašlivé exploze a nebesa se rozštípla mocí ohňovou; kvasil v něm a.',	NULL,	NULL,	'2015-07-16 13:27:42',	NULL,	0,	'news');

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(121,	'Animi',	'2015-07-16 13:27:39'),
(122,	'Consequuntur',	'2015-07-16 13:27:39'),
(123,	'Omnis',	'2015-07-16 13:27:39'),
(124,	'Quod',	'2015-07-16 13:27:39'),
(125,	'Sed',	'2015-07-16 13:27:39');

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
(454,	121,	121,	0),
(455,	122,	122,	0),
(456,	121,	122,	1),
(457,	123,	123,	0),
(458,	122,	123,	1),
(459,	121,	123,	2),
(461,	124,	124,	0),
(462,	123,	124,	1),
(463,	122,	124,	2),
(464,	121,	124,	3),
(465,	125,	125,	0),
(466,	124,	125,	1),
(467,	123,	125,	2),
(468,	122,	125,	3),
(469,	121,	125,	4);

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
(150,	122),
(150,	124),
(151,	122),
(151,	123),
(151,	124),
(153,	122),
(153,	123),
(154,	123),
(155,	122),
(155,	124);

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
(151,	49),
(151,	50),
(153,	50),
(154,	49),
(154,	50),
(155,	49);

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the product',
  `slug` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Webalized title (slug) of the product',
  `description` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Long description of the product',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products` (`id`, `title`, `slug`, `description`) VALUES
(208,	'Nepředstihujeme odebírání vašich známých',	'nepredstihujeme-odebirani-vasich-znamych',	'To není ona, trne bolestně Prokop, a čelo mu zrovna praskalo náběhem vzteku. Jděte, křičel, a řekněte jim, řekněte jim, řekněte jim, že… že snad si na ni hladké konečky prstů; nějaký blesk proběhl Prokopem, srdce mu zabouchalo a hlavou mu nesmyslně kmitlo: Což kdybych sevřel! A již vlezla s hadrem pod stůl. Prosím tě, pojď sem, ozvalo se z kouta, a u pacienta zůstal dr. Krafft, celý rudý a zatíná pěstě. Panstvo před zámkem a zapálil si velmi tlusté cigáro, načež usilovně přemítal..'),
(209,	'Předstihujeme návrh a pohodlí vaší rodiny',	'predstihujeme-navrh-a-pohodli-vasi-rodiny',	'A proto, proto musíš za fakty! až ti to dáno, abys toho dobýval, abys to věděl – I Daimon? Neodpověděla, jenom se otřásla. Mů-můžeš mne kopnout já jsem udělal vynález – a musí mu o ní pomalý lord nerozhovořil. Ano. Čirý nesmysl. Celá věc má jen obchodní pozadí. Někdo má zájem na tom, aby dokázal nespolehlivost našich stanic, rozumíte? Chce podrýt veřejnou důvěru. Bohužel naše receptory a – nehýbejte se! Já vás neukousnu. Co mně je? ptal se Daimon. Mám starou, prastarou horečku. Co.'),
(210,	'Neděláme výstavbu pro vaše zákazníky',	'nedelame-vystavbu-pro-vase-zakazniky',	'Prokop klnul, rouhal se, válel se v surových a nejnižších výrazech; jako by se ti dokazovat… tak hrozně jako já, víš? Deset let! Dovedl bys mně věřit deset dní? Kdežpak deset dní! Za deset minut se budeš mračit, ty milý, a vztekat se, že je tak prudký, ozvala se konečně. On je tak útlá a skoro veličensky se uzavřela v sebe; najednou byla taková distance mezi ní a všemi ostatními, že všichni se narovnali jako na poplach. Kristepane, že jsem ho milovala. Teď vidím, že jsem vás víc, než jsem.'),
(211,	'Provozujeme výstavbu a výstavbu bourací techniky',	'provozujeme-vystavbu-a-vystavbu-bouraci-techniky',	'Stra-strašná brizance. Já – já – Vyskočil tluka se pěstmi do hlavy. Vy chcete nemožné dobro; následkem toho budete asi velmi krutý. Nezastavujte se před vůz; byl to poražený kříž. Těžce sípaje usedl na prázdný podstavec. Mlžná záplava nad Grottupem obrovská černá masa, vše zhaslo; jako by jí neznal či co, slzel a jedl; a dědeček každé druhé sousto podával koníkovi, který nad ním dva staří černí páni. Bylo mu skoro do pláče prudkým pohnutím. Mlčky kývla a podávala mu ruku. Jsem ráda, že jste.'),
(212,	'Zajišťujeme prodej pro lepší svět',	'zajistujeme-prodej-pro-lepsi-svet',	'Je stěží vidět na cestu. Prokop se nepodivil, jen se neplaš, cenil se Daimon. Holka, ty bys tak někoho mohl zadržet! Jen udělat rukou takhle – Z okna vrátného domku vyhlédla povědomá tvář, náramně podobná jistému Bobovi. Prokop tedy ani nedokončil svou myšlenku, otočil se jako v snách objevoval Prokop poprvé v životě, co vše jsem odhodlán učinit, abych si zasloužil tahle slova – Ó-ó, jak ten vlak pomalu jede! XV. Jakmile přistál v Praze, hnal se rukou své pouzdro na cigára. Kouříte? Ne..'),
(213,	'Provozujeme odvoz a nákup zdarma',	'provozujeme-odvoz-a-nakup-zdarma',	'Prokop mlčky uháněl k vrátnici, bodán starostí o Holze. Už zdálky viděl hroznou skutečnost: dva chlapi stáli ve fortně, zahradník zahrabával v rozrytém písku stopy zápasu, mřížová vrata z parku ven a viděl, že rozkousala a roztrhala na cáry a krváceje z úst a líbal ji mumlaje nadšením vše možné. Zrůžověla nyní a zkrásněla. Nejsem ošklivá? šeptala mezi polibky šťastná a omámená. Chtěla bych být krásná jen pro východ C, tamhle, co jsou ty tam, a na rtech stopy jejích někdejších polibků nebo.'),
(214,	'Děláme nákup a nákup vaší rodiny',	'delame-nakup-a-nakup-vasi-rodiny',	'Zalomila rukama. Já tě milovala! Já jsem tak dobře schovaná, bzučela šťastně, ležíc mu hlavou o skla a úpí hlasem téměř lidským. Kam jsi dal hlavu, člověče! Teď klekneš, přijde-li, uhodíš čelem o peň dubový. Sotva ji Prokop poplašil. Tak si tam šeptají; a Prokop četl v blikajících kmitech lucerny: K..R..A…..K..A..T.. To nic, to nic, zabreptal dědeček konejšivě a honem stíral písmena čepicí. Už je to zarostlé ve mně… jako v snách. Princezna stála opřena o veřeje, bledá, s očima zavřenýma,.'),
(215,	'Předstihujeme odvoz a návrh mrakodrapů',	'predstihujeme-odvoz-a-navrh-mrakodrapu',	'Avšak u nového baráku mu klesly bezmocně ruce: Zatraceně, je ten člověk? Prokop se zvedl a dal se Prokop zimničně. Krakatit se musí roztříštit, aby vydal vše. Společnost se musí roztříštit, aby vydal vše. Společnost se musí zabránit… Pan Tomeš, namítl Carson rychle, prodá Krakatit samému ďáblu, když mu jej podala odměnou nebo na pana domácího, odkudže poslal Tomeš ty peníze byly vyplaceny v téhle bance nebo v takovém případě se nedá písemně vyřizovat, prosím, abyste mi řekli, kde je teď.'),
(216,	'Realizujeme pronájem jako jediní na trhu',	'realizujeme-pronajem-jako-jedini-na-trhu',	'XV. Jakmile přistál v Praze, a v prsou se mu nejasně zdálo, že už ho napadla spásná myšlenka. Uteku domů, do svého pokoje a vrací se oblékajíc si přes hlavu čínského vyslance. Prokop si zdrcen uvědomil, že není žádná tautomerie. Já jim ukážu takovou merotropii, že budou z toho obracel žaludek. Německý dopis, písmeno G., valutní obchod, prodej ty papíry, erwarte Dich, P. S. Achtung, K. aus Hamburg eingetroffen. Táž G, uražený a chvatný dopis, mrazivé vykání, vraťte těch deset tisíc, sonst.');

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
(208,	544),
(208,	547),
(209,	544),
(209,	547),
(209,	549),
(210,	544),
(210,	549),
(211,	544),
(211,	547),
(212,	549),
(213,	547),
(213,	549),
(214,	547),
(216,	547);

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
(47,	209,	'modrá-M',	'blue1'),
(48,	210,	'červená-S',	'red1');

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
(47,	217),
(47,	221),
(48,	218),
(48,	220);

DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `resources` (`id`, `name`) VALUES
(136,	'Admin:Dashboard'),
(137,	'Options:Options'),
(138,	'Pages:AdminPage'),
(139,	'Admin:Files'),
(140,	'Users:Users'),
(141,	'Eshop:AdminProduct');

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
(101,	NULL,	'guest'),
(102,	101,	'user'),
(103,	102,	'admin'),
(104,	103,	'superadmin');

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
(614,	NULL,	'',	'Front:Homepage:default',	NULL),
(615,	NULL,	'kontakt',	'Front:Contact:default',	NULL),
(616,	NULL,	'auth',	'Auth:Sign:in',	NULL),
(617,	NULL,	'odhlasit',	'Auth:Sign:out',	NULL),
(618,	NULL,	'administrace/soubory',	'Admin:Files:default',	NULL),
(619,	NULL,	'administrace/nastaveni/general',	'Options:Options:general',	NULL),
(620,	NULL,	'administrace/editovat-stranku',	'Pages:AdminPage:edit',	NULL),
(621,	NULL,	'administrace/editovat-stranky',	'Pages:AdminPage:multiEdit',	NULL),
(622,	NULL,	'administrace/nastaveni/seo',	'Options:Options:seo',	NULL),
(623,	NULL,	'administrace/nastaveni/navigace',	'Options:Options:navigation',	NULL),
(624,	NULL,	'nahled-stranky',	'Pages:Page:preview',	NULL),
(625,	NULL,	'administrace/nahrat-soubory',	'Admin:Files:upload',	NULL),
(626,	NULL,	'administrace/editovat-soubor',	'Admin:Files:edit',	NULL),
(627,	NULL,	'administrace',	'Admin:Dashboard:default',	NULL),
(628,	NULL,	'administrace/stranky',	'Pages:AdminPage:default',	NULL),
(629,	NULL,	'administrace/nova-stranka',	'Pages:AdminPage:new',	NULL),
(630,	NULL,	'administrace/uzivatele',	'Users:Users:default',	NULL),
(631,	NULL,	'administrace/nastaveni',	'Options:Options:default',	NULL),
(632,	NULL,	'ducimus',	'Pages:Page:default',	150),
(633,	NULL,	'voluptatibus',	'Pages:Page:default',	151),
(634,	NULL,	'aperiam',	'Pages:Page:default',	152),
(635,	NULL,	'voluptate',	'Pages:Page:default',	153),
(636,	NULL,	'tempore',	'Pages:Page:default',	154),
(637,	NULL,	'rerum',	'Pages:Page:default',	155),
(638,	NULL,	'administrace/eshop/zbozi',	'Eshop:AdminProduct:default',	NULL),
(639,	NULL,	'eshop',	'Eshop:Product:default',	NULL),
(640,	NULL,	'produkt',	'Eshop:Product:detail',	NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(49,	'admin@antstudio.cz',	'$2y$10$3ZzP4U/f8oRVsWgdTrn/guu3.kkCq2sx8i7MyskGs.7t98t3lVm3m',	'2015-07-16 13:27:39'),
(50,	'demo@antstudio.cz',	'$2y$10$bhkNoClt2MZRh0G8MzOnGuIAUgGPEYbrq5Fhe5iwQaUZTPC8R4uim',	'2015-07-16 13:27:39');

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
(49,	104),
(50,	102);

DROP TABLE IF EXISTS `variants`;
CREATE TABLE `variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the variant (e.g. color, size, material).',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B39853E15E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `variants` (`id`, `name`) VALUES
(73,	'barva'),
(75,	'materiál'),
(74,	'velikost');

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
(217,	73,	'modrá'),
(218,	73,	'červená'),
(219,	73,	'žlutá'),
(220,	74,	'S'),
(221,	74,	'M'),
(222,	74,	'L'),
(223,	75,	'bavlna'),
(224,	75,	'dřevo'),
(225,	75,	'polyester');

-- 2015-07-16 11:31:30
