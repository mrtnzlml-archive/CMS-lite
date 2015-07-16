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
(661,	'CESKA_POSTA',	'Česká pošta',	215.50,	1),
(662,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	206.60,	1),
(663,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	95.40,	1),
(664,	'DPD',	'DPD',	170.20,	1),
(665,	'DHL',	'DHL',	161.30,	1),
(666,	'DSV',	'DSV',	120.00,	1),
(667,	'EMS',	'EMS',	167.70,	1),
(668,	'FOFR',	'FOFR',	142.80,	1),
(669,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	97.00,	1),
(670,	'GEIS',	'Geis',	184.60,	1),
(671,	'GENERAL_PARCEL',	'General Parcel',	120.80,	1),
(672,	'GLS',	'GLS',	167.30,	1),
(673,	'HDS',	'HDS',	95.50,	1),
(674,	'HEUREKAPOINT',	'HeurekaPoint',	104.70,	1),
(675,	'INTIME',	'InTime',	144.00,	1),
(676,	'PPL',	'PPL',	219.30,	1),
(677,	'RADIALKA',	'Radiálka',	151.80,	1),
(678,	'SEEGMULLER',	'Seegmuller',	127.50,	1),
(679,	'TNT',	'TNT',	193.50,	1),
(680,	'TOPTRANS',	'TOPTRANS',	197.10,	1),
(681,	'UPS',	'UPS',	183.60,	1),
(682,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	112.40,	1);

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
(4,	'Eshop\\DI\\EshopExtension');

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
(26,	'Administrace - Hlavní menu');

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
(187,	775,	'icon ai-home60',	'Nástěnka'),
(188,	NULL,	NULL,	'admin_root'),
(189,	NULL,	'icon flaticon-document236',	'Obsah'),
(190,	776,	NULL,	'Stránky'),
(191,	777,	NULL,	'Nová stránka'),
(192,	778,	'icon flaticon-user8',	'Uživatelé'),
(193,	779,	'icon flaticon-gear39',	'Nastavení');

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
(187,	26),
(189,	26),
(190,	26),
(191,	26),
(192,	26),
(193,	26);

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
(1410,	187,	187,	0),
(1411,	188,	188,	0),
(1412,	188,	187,	1),
(1413,	189,	189,	0),
(1414,	188,	189,	1),
(1415,	190,	190,	0),
(1416,	189,	190,	1),
(1417,	188,	190,	2),
(1419,	191,	191,	0),
(1420,	189,	191,	1),
(1421,	188,	191,	2),
(1423,	192,	192,	0),
(1424,	188,	192,	1),
(1425,	193,	193,	0),
(1426,	188,	193,	1);

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
(16,	61,	'Děláme výstavbu vašeho webu a pro vaše zákazníky',	'Prokop a nutil se Prokop chvatně. … Přesně to nevím, vycedil opovržlivě lord. Carsone, obrátil se k němu přilne celou délkou; a Prokop slézá z kozlíku, chvěje se na zem; i zachytil ji pevněji sám kolísaje jejím zdivočelým odporem. Svíjela se se.',	'2015-07-16 15:38:03'),
(17,	61,	'Mobilizujeme návrh a přepravu webu',	'Prokop mnoho profitoval od jemného pána, obrousil se jaksi a vyspělá, o čemsi rozhodnutá, s čímsi smířená; jako by mu ztuhly údy. Tak pojďte. Šel rovnou do toho: aby ho neobjal kolem krku, a začnou se líbat. Po létech zase cítí Prokop tělesné.',	'2015-07-16 15:38:04'),
(18,	61,	'Nabízíme nákup pro lepší svět a pro vaše zákazníky',	'Kře-mi-čitan hlinitý. Porcelán. Piksla. Já myslel, že jste v držení našich lidí, donesl jim to už je tu věcí divných a něžných! Flakónky, tyčinky, pouzdra, krémy, hračiček bezpočtu; to tedy a rozkuckala se; byl to seník či co, slzel a jedl; a.',	'2015-07-16 15:38:04');

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
(151,	63,	'site_title',	'Název webu'),
(152,	63,	'site_title_separator',	'Oddělovač titulku'),
(153,	64,	'index',	'Indexovat web'),
(154,	64,	'page_url_end',	'Koncovka URL stránek'),
(155,	64,	'category_url_end',	'Koncovka URL kategorií');

DROP TABLE IF EXISTS `option_categories`;
CREATE TABLE `option_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the option category',
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nice name of the option category',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D79A5E585E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `option_categories` (`id`, `name`, `full_name`) VALUES
(63,	'general',	'Obecné'),
(64,	'seo',	'SEO');

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
(331,	151,	'ANTstudio CMS',	0),
(332,	152,	'|',	0),
(333,	153,	'1',	0),
(334,	154,	NULL,	0),
(335,	154,	'/',	0),
(336,	154,	'.htm',	0),
(337,	154,	'.html',	0),
(338,	155,	NULL,	0),
(339,	155,	'/',	0),
(340,	155,	'.htm',	0),
(341,	155,	'.html',	0);

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
(186,	NULL,	780,	'Laboriosam',	NULL,	NULL,	'Stál nad ohněm s rukama za zády a měřil s nelibostí své boty podobné vojenským bagančatům i své unošené nohavice. Ponořen v tyto myšlenky divže nevlezl až doprostřed tenisového hříště, zahlédl tam několik svých ručních granátů a pozoroval střídavě park, chvátajícího střevlíka a vrabce na rozhoupaných větvičkách. Jednou tam slétla dokonce červenka, a Prokop provedl znovu generální prohlídku celého bytu; řádil ve všech skříních i zásuvkách, nenacházeje krom prašiviny starých účtů, milostných.',	NULL,	NULL,	'2015-07-16 15:38:06',	NULL,	0,	'news'),
(187,	NULL,	781,	'Asperiores',	NULL,	NULL,	'A tady je přes ruku ta jizva. A potom jsem chtěl s pýchou podívat na své Magnetové hoře řídí příšerně tiché bubnové bombardement celého světa; mílovými kmity si razí letící vlny cestu rozlohami, aby zachytily a rozmetaly první prášek Krakatitu kdekoliv na zemi. A tady je cíl, kaplička mezi dvěma starými lípami; je pozdní hodina, kdy pasáci začínají zpívat. Tu je k smíchu, poslyšte, tak počkejte, to je Krafft, Krafft zapomenutý v plovárně; má oči zpuchlé a rudé, jako by nemohl uvěřit, že je.',	NULL,	NULL,	'2015-07-16 15:38:06',	NULL,	0,	'news'),
(188,	NULL,	782,	'Et',	NULL,	NULL,	'Anči se vrhla k vypínači a rozsvítila. A nestůj tady, hřmotil starý pán se rozčiloval, funěl a potil se na katedru vyšvihl černý mladý muž a krátkým gestem mu ukázal do své ložnice; jen ho tížilo, že musí vstát a vyhledat Jirku Tomše, který neobraceje se od Prokopa zpráva nepřicházela. Snad se ohlásí sám, napadlo ji, a v pátek… o půl jedenácté… si umane ,sám od sebe‘ explodovat. A víte co ještě? Prokop to ovšem nevěděl. Dále, pravili mu, snad ten dotyčný tu prodal jen cenné papíry; pak jeho.',	NULL,	NULL,	'2015-07-16 15:38:06',	NULL,	0,	'page'),
(189,	NULL,	783,	'In',	NULL,	NULL,	'Prokop až sepjal ruce: bože, co vše jsem odhodlán učinit, abych si zasloužil tahle slova – Ó-ó, jak ten vlak pomalu jede! XV. Jakmile přistál v Praze, hnal se rukou přejížděl známé ubohé podrobnosti; všecko je, jak to měla sehrát: pravá faleš, vzít trochu dole, a není jí podobna, ujišťoval se. Zdálo se mu, že zas je rozšlapal svým příliš těžkým uvažováním. Rozmrzen praštil vším, aby se uzdravil; já… já jsem našel atomové výbuchy. Já – já – já jsem rozbil hmotu, prohlásil Prokop. Plinius nic;.',	NULL,	NULL,	'2015-07-16 15:38:06',	NULL,	0,	'page'),
(190,	NULL,	784,	'Consequatur',	NULL,	NULL,	'Řekli Prokopovi, že do tří dnů udělá nový pokus o úsměv – a z toho bylo něco ohromného bílého. Anči držela, kolena se jí v prstech pivní láhev. Jakýsi tlustý cousin navrhnout Prokopovi, aby toho nechal; že zase dostane svou laboratoř a kdesi cosi. Já nevím, o čem vlastně?), když náhle, bác, má na rameni blažený dech ospalé pozornosti. Posléze se Anči vzpřímila, složila ruce v těsných, maličkých rukavičkách; chladná vůně, pohled jasný a matoucí pod sličným, pevným obočím. Ruce na klíně, ruce.',	NULL,	NULL,	'2015-07-16 15:38:06',	NULL,	0,	'page'),
(191,	NULL,	785,	'Non',	NULL,	NULL,	'Prokop váhavě. Dívka se usmála, jasná a růžová jako nikdy, a nechala se dlouho a všelijak zajímavě skládat, za pozorného mžikání ohnutých řas. Co to děláš? Třaskaviny. Prosím, tu láhev, obrátil se sir Reginald Carson. Sir Carson jal se znovu okukovat laboratoř. Trochu mu to svrchovaně lhostejno: tak jednoduché si to přečti, povídal stařík zavíraje pečlivě krabici. Já zatím přinesu roští; a už mu s podivnou podrobností dehtovaný tovární plot s trochou smutné zaprášené trávy a rezavými.',	NULL,	NULL,	'2015-07-16 15:38:06',	NULL,	0,	'news');

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(151,	'Est',	'2015-07-16 15:38:01'),
(152,	'Voluptatum',	'2015-07-16 15:38:01'),
(153,	'Aliquid',	'2015-07-16 15:38:01'),
(154,	'Molestiae',	'2015-07-16 15:38:01'),
(155,	'Corporis',	'2015-07-16 15:38:01');

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
(568,	151,	151,	0),
(569,	152,	152,	0),
(570,	151,	152,	1),
(571,	153,	153,	0),
(572,	152,	153,	1),
(573,	151,	153,	2),
(575,	154,	154,	0),
(576,	153,	154,	1),
(577,	152,	154,	2),
(578,	151,	154,	3),
(579,	155,	155,	0),
(580,	154,	155,	1),
(581,	153,	155,	2),
(582,	152,	155,	3),
(583,	151,	155,	4);

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
(186,	152),
(186,	153),
(188,	152),
(188,	154),
(189,	153),
(190,	152);

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
(187,	61),
(187,	62),
(188,	61),
(188,	62),
(190,	61),
(191,	61);

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the product',
  `slug` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Webalized title (slug) of the product',
  `description` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Long description of the product',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products` (`id`, `title`, `slug`, `description`) VALUES
(262,	'Mobilizujeme pronájem bourací techniky a zdarma',	'mobilizujeme-pronajem-bouraci-techniky-a-zdarma',	'Vždyť ani nevíte, proč – tak, že mne to celé počínání… zůstává bez vlivu. Ale na mne přišlo, taková odvaha nebo zoufalství: zavřela jsem oči, udělala křížek a skočila. Neptej se, jak se tiskl závoj k jejím rtům! Prokop zasténal a otevřel oči, a tu se mu obzvláště příčilo, bylo, že se ještě necítil v sedle a že se vám tu líbí? Ohromně, mínil Prokop nejistě. Náramný nešika, že? řekl pan Carson podivem hvízdl. Jednoduše kouzelník. Jestli chcete, já vám opatřím prostředky. Čestné slovo..'),
(263,	'Provozujeme zprostředkování a bezpečnost zdarma',	'provozujeme-zprostredkovani-a-bezpecnost-zdarma',	'Flakónky, tyčinky, pouzdra, krémy, hračiček bezpočtu; to tedy je řemeslo žen; oči, úsměv, vůně, vůně ostrá a lichotná – Pahýly jeho prstů se třásly na těch křehkých a tajemných věcičkách, podrážděny, jako by do ní táhnouc ho k sobě. Nesmíš, teď nesmíš, zasykla a ožehla ho plamenným pohledem. Jinaké větší škody pokusný výbuch Vicitu nezpůsobil. Shodilo to jen suky a léta a vlhkost a prach – Dědeček se usmál. Chutnalo ti? A-a, už zas se dívala jinam. Řekněte mu, že… že vy… Ale je to tak..'),
(264,	'Nabízíme zprostředkování vašich známých a turbíny',	'nabizime-zprostredkovani-vasich-znamych-a-turbiny',	'Tu ho napadla nová myšlenka: totiž dluhy. Sebral se a utíkal k soudu, oddělení pro pohledávky. A hle, zde tuze dobře pozorovat vaše důvěrné svazky s těmi navoněnými idioty. Za tu žárlivou paličatost ho princezna Wille. Prokop se mu zdálo, že studuje veleučený článek v The Chemist. Zarazil se u zahradních vrátek a vyšel rázně na silnici; a než ho umlčeli. S mračným znechucením studoval Prokop v něčem podobném; vykládané parkety, anglický empir, vše staroučké a drahocenné, že se mu jazyk a.'),
(265,	'Nemobilizujeme odvoz za hubičku',	'nemobilizujeme-odvoz-za-hubicku',	'Kašgar, jejž spálil povraždiv na padesát tisíc lidí, mezi nimi čínského vladaře, kterému dal utahovat namočený provaz kolem hlavy tak dlouho, až praskla jako ořech. O dalších předcích Litajových není nic známo, pokud snad nebudou přístupny archívy ve Lhase. Jeho syn Giw-khan vyplenil Chivu a řádil až po oči zahalená v modré zástěře stojí, chudák, celá rudá nad plotýnkou – Moucha masařka se bezdeše zarazila. Teď přijde… tatarská kněžna a řekne: Milý, milý, zapomněla jsem udělat křížek. Kvečeru.'),
(266,	'Mobilizujeme zprostředkování a prodej a jsme jednička na trhu',	'mobilizujeme-zprostredkovani-a-prodej-a-jsme-jednicka-na-trhu',	'Já se tě na to. Když je člověk princezna, myslí si, že nefunguje zvonek, a jal se skládati své papíry do aktovky. Zajisté, řekl pomalu, bude lépe, navštívím-li vás jindy – Jen račte zůstat, přerušil ho Prokop chraptivě. Nu, zabreptal Carson trochu rozpačitý, ale dopadlo do dobře; Prokop se zhrozil; až tohle propukne, kam až stříkne hanba těchto nevýslovných špinavostí? Vzpomněl si na ně vyjížděl pořád mysle na zlořečený pudr. U všech všudy, co ještě máte v kapsách? ptal se vlídně a.'),
(267,	'Děláme testování nákupních košíků',	'delame-testovani-nakupnich-kosiku',	'Egonek. Po pěti dnech mu začalo svítat; horečně studoval aromatické nitroaminy, načež se uvelebil u ohníčka, dal Prokopovi větší díl a sám se sebou, ale tak rychle to nešlo; mohli byste jej vidět, jak stojí uprostřed pokoje, máchá rukou a zašeptala: Ten balíček – Tu se probudil zarachocením klíče. Je čiročiré ráno a do toho nepletli, nebo že je nějaká souvislost mezi Tomšem a šli jsme k němu, vzal do rukou, mihlo se mu chtěly vyrvat, které se mu obzvláště příčilo, bylo, že se houpe nějaké.'),
(268,	'Předstihujeme bezpečnost a seo a jsme jednička na trhu',	'predstihujeme-bezpecnost-a-seo-a-jsme-jednicka-na-trhu',	'Premiera za udidla. Nechte ho, žádal Prokop. Vždyť máte bolavou ruku, namítalo děvče s velikou vážností, tisknouc k prsoum bílé prádlo a zbrusu nové a zrovna vylamoval jeho křečí sevřené prsty. Vodu, křikl, a tlustý cousin navrhnout Prokopovi, aby toho nechal; že zase pracujete, mluví princezna. Co zrovna děláte? Nu, to a ono, padla na Prokopa ostrýma, zachmuřenýma očima, jež ho fascinovaly. Řezník se zvedl a podával Prokopovi ruku: Chtěl jsem jenom… poprosit, abyste mi řekli, kde.'),
(269,	'Mobilizujeme návrh a výstavbu lampiónků a svíček',	'mobilizujeme-navrh-a-vystavbu-lampionku-a-svicek',	'A ona je vlastně jen škrobový prášek; považoval jej patrně za zemitou barvu. Nuže, škrob je výborná věc dejme tomu na včerejší odpoledne. Do poslední chvíle o taktiku. Nejspíš tam hoří. Na obzoru bylo vidět celou frontu zámku. Točila se mu prudce z dlaní. Proč bych ti půjčil, nechceš? Nech. Na to bys nestačil. Snad ještě můj tatík – Tomeš mávl rukou. Klid, řekl, jenom klid. Prokop, třeba mu bylo hladit a konejšit někoho jiného. Já vám budu sloužit, nechte mne nechte mne… já vám.'),
(270,	'Nezajišťujeme výstavbu pro vás',	'nezajistujeme-vystavbu-pro-vas',	'Zalomcoval jimi zběsile; vůbec se to dělá… náramně diskrétně. Pan Carson jen trhl rameny. A co z příčin jistě uvážených hodláte nechat pro sebe. Znám vaši práci. Myslím, že tě odtud odvezou. Nehýbej se teď, dívá se za ruce a poskakovali rychle, rychle, pořád rychleji. Prokop vzhlédl a viděl nad sebou koňskou hlavu, i popadl cukřenku, vrhl na kavalec a spal stočen jako pes. Báječná exploze, povídal nadšen, a jen sípe, nemoha ze sebe jakési na shledanou a trapně se vytratil. Jako zloděj,.');

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
(262,	676),
(263,	676),
(264,	676),
(264,	679),
(264,	681),
(265,	681),
(266,	676),
(266,	679),
(268,	676),
(268,	681),
(269,	676),
(269,	679),
(269,	681),
(270,	679);

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
(59,	263,	'modrá-M',	'blue1'),
(60,	264,	'červená-S',	'red1');

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
(59,	271),
(59,	275),
(60,	272),
(60,	274);

DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `resources` (`id`, `name`) VALUES
(167,	'Admin:Dashboard'),
(168,	'Options:Options'),
(169,	'Pages:AdminPage'),
(170,	'Admin:Files'),
(171,	'Users:Users'),
(172,	'Eshop:AdminProduct');

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
(125,	NULL,	'guest'),
(126,	125,	'user'),
(127,	126,	'admin'),
(128,	127,	'superadmin');

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
(761,	NULL,	'',	'Front:Homepage:default',	NULL),
(762,	NULL,	'kontakt',	'Front:Contact:default',	NULL),
(763,	NULL,	'auth',	'Auth:Sign:in',	NULL),
(764,	NULL,	'odhlasit',	'Auth:Sign:out',	NULL),
(765,	NULL,	'administrace/soubory',	'Admin:Files:default',	NULL),
(766,	NULL,	'administrace/nastaveni/general',	'Options:Options:general',	NULL),
(767,	NULL,	'administrace/editovat-stranku',	'Pages:AdminPage:edit',	NULL),
(768,	NULL,	'administrace/editovat-stranky',	'Pages:AdminPage:multiEdit',	NULL),
(769,	NULL,	'administrace/nastaveni/seo',	'Options:Options:seo',	NULL),
(770,	NULL,	'administrace/nastaveni/navigace',	'Options:Options:navigation',	NULL),
(771,	NULL,	'nahled-stranky',	'Pages:Page:preview',	NULL),
(772,	NULL,	'administrace/nahrat-soubory',	'Admin:Files:upload',	NULL),
(773,	NULL,	'administrace/editovat-soubor',	'Admin:Files:edit',	NULL),
(774,	NULL,	'administrace/novy-uzivatel',	'Users:Users:new',	NULL),
(775,	NULL,	'administrace',	'Admin:Dashboard:default',	NULL),
(776,	NULL,	'administrace/stranky',	'Pages:AdminPage:default',	NULL),
(777,	NULL,	'administrace/nova-stranka',	'Pages:AdminPage:new',	NULL),
(778,	NULL,	'administrace/uzivatele',	'Users:Users:default',	NULL),
(779,	NULL,	'administrace/nastaveni',	'Options:Options:default',	NULL),
(780,	NULL,	'laboriosam',	'Pages:Page:default',	186),
(781,	NULL,	'asperiores',	'Pages:Page:default',	187),
(782,	NULL,	'et',	'Pages:Page:default',	188),
(783,	NULL,	'in',	'Pages:Page:default',	189),
(784,	NULL,	'consequatur',	'Pages:Page:default',	190),
(785,	NULL,	'non',	'Pages:Page:default',	191),
(786,	NULL,	'administrace/eshop/zbozi',	'Eshop:AdminProduct:default',	NULL),
(787,	NULL,	'eshop',	'Eshop:Product:default',	NULL),
(788,	NULL,	'produkt',	'Eshop:Product:detail',	NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(61,	'admin@antstudio.cz',	'$2y$10$x13xD9SIc.EyYeOqsau9EOjqxyDt8FwBWs0kPzcGgsNMrpI07/hzK',	'2015-07-16 15:38:02'),
(62,	'demo@antstudio.cz',	'$2y$10$efxHI3NXO95rYZcclw3FK.QsOPWbmX63pP7wv5cWBU6IZXHTxaW2.',	'2015-07-16 15:38:02'),
(63,	'mrtnzlml@gmail.com',	'mrtnzlml@gmail.com',	'2015-07-16 15:53:44');

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
(61,	128),
(62,	126),
(63,	125);

DROP TABLE IF EXISTS `variants`;
CREATE TABLE `variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the variant (e.g. color, size, material).',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B39853E15E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `variants` (`id`, `name`) VALUES
(91,	'barva'),
(93,	'materiál'),
(92,	'velikost');

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
(271,	91,	'modrá'),
(272,	91,	'červená'),
(273,	91,	'žlutá'),
(274,	92,	'S'),
(275,	92,	'M'),
(276,	92,	'L'),
(277,	93,	'bavlna'),
(278,	93,	'dřevo'),
(279,	93,	'polyester');

-- 2015-07-16 14:05:27
