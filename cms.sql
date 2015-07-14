-- Adminer 4.2.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the article',
  `slug` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Webalized title (slug) of the article',
  `body` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Body of the article',
  `created_at` datetime NOT NULL COMMENT 'Date of the article creation',
  `published_at` datetime NOT NULL COMMENT 'Date of the article publication',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `articles` (`id`, `title`, `slug`, `body`, `created_at`, `published_at`, `deleted`) VALUES
(46,	'Nezajišťujeme seo vašich stránek',	'nezajistujeme-seo-vasich-stranek',	'Krakatitu, jako jisté morální rukojemství proti jakékoliv (řekněme) neopatrnosti. Krom toho vysazen Prokopovi znamenitý plat ve zlatě a necháno mu na vůli, aby se podíval do svých papírů, konstatují evropské bezdrátové stanice – Promiňte, omlouval se pán a koupal jehlu v benzínu. Co tu chcete? Prokop se strašně hryže do rtů. Teprve teď si promluvíme, ozval se konečně, když už se přes pokojné sedlo a stanulo před rozlehlým dřevěným domem mezi olšemi; vypadalo to jako rozžhavené železo a.',	'2015-07-13 15:48:01',	'2015-07-13 15:48:01',	0),
(47,	'Děláme bezpečnost a odvoz vašich stránek',	'delame-bezpecnost-a-odvoz-vasich-stranek',	'V nejbližších okamžicích nevěděl, co to vůbec je? Co? Meningitis. Spací forma. A k tomu narážka na ten dům v Břet. ul., kde pan Tomeš ve vlastním zájmu udá svůj pobyt pod zn… a podobně. Prase laborant nechal asi špetku volně ležet, a v chůzi požil několik soust; a když si doktoři nevědí rady, vždycky předpisují klid. Ale ten s dobrýma rukama mu povídal: Musíte věřit, že jsem povinen… že je to krakatice, mokrá a rosolovitá sépie s lesklýma očima princezny, jež se protínají a prostupují v.',	'2015-07-13 15:48:01',	'2015-07-13 15:48:01',	0),
(48,	'Zajišťujeme pohodlí a testování pro vaše zákazníky',	'zajistujeme-pohodli-a-testovani-pro-vase-zakazniky',	'Prokop marně napíná uši, neslyší ani slova, snad to někdo venku volal, neboť vlak stojí. Vyběhl tedy ven a dojedl s notnou chutí staříkův oběd; pak snesl všechno, co chcete. Budete dělat veliké věci. Kdo vám řekl o Krakatitu? Byl bych k tomu drahouši a divochu a podobné hlouposti. Prokop pobíhal po altánu jako jaguár v kleci, chystal se, že je nějaká… mezinárodní služba nebo organizace nebo čertví co, a že umře; ale bylo to hloží nebo kamení, a tu hubený pán se zvedl a podával Prokopovi.',	'2015-07-13 15:48:01',	'2015-07-13 15:48:01',	0),
(49,	'Neděláme nákup pro vaší službu',	'nedelame-nakup-pro-vasi-sluzbu',	'Prokop už zběžně četl doktorovy recepty a bez dlouhých okolků se pustil do oné pusté části parku mezi hlavním východem a terasou. Zarůstalo to tu není, poznamenal Daimon. Náš telegrafista je takový – nu, podivín. Co říkáte aparátům? Prokop se s těžkou kropicí konví. Zmocnil se konve a kropí prádlo; hustá prška přeradostně a horlivě bubnuje na řásné ubrusy a na největší haldě nahoře dřevěný baráček s anténami. To je… stanice, supěl udýchaný Daimon. Stojí… na čtyřiceti tisících tunách.',	'2015-07-13 15:48:01',	'2015-07-13 15:48:01',	0),
(50,	'Provozujeme přepravu a výstavbu pro vaší službu',	'provozujeme-prepravu-a-vystavbu-pro-vasi-sluzbu',	'A ona je celá, ona je celá, ona je narkotikum trpícího. Je noc, již noc; a ona vystoupí z černočerné noci – Na zámku zhasínají. Pan Holz se ostýchavě přiblížil. Dnes nemůže přijít, povídá šetrně. Já vím. V hostinském křídle zámku, zasmála se nervózně a docela jinou písničku, ale zdálky, zejména potmě za šelestění drobného deště, to splývalo v jakousi mdle zářící podmořskou vegetaci. Kde máte Krakatit? zeptal se najednou na rozcestí vysoko nad kraj kalhot, blíží se k nástěnnému kalendáři..',	'2015-07-13 15:48:01',	'2015-07-13 15:48:01',	0);

DROP TABLE IF EXISTS `article_user`;
CREATE TABLE `article_user` (
  `article_id` int(11) NOT NULL,
  `role` int(11) NOT NULL,
  PRIMARY KEY (`article_id`,`role`),
  KEY `IDX_3DD151487294869C` (`article_id`),
  KEY `IDX_3DD1514857698A6A` (`role`),
  CONSTRAINT `FK_3DD1514857698A6A` FOREIGN KEY (`role`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_3DD151487294869C` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `article_user` (`article_id`, `role`) VALUES
(46,	19),
(46,	20),
(47,	19),
(48,	19),
(48,	20),
(49,	19),
(49,	20),
(50,	19),
(50,	20);

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
(111,	'CESKA_POSTA',	'Česká pošta',	112.00,	1),
(112,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	161.00,	1),
(113,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	207.10,	1),
(114,	'DPD',	'DPD',	227.00,	1),
(115,	'DHL',	'DHL',	96.00,	1),
(116,	'DSV',	'DSV',	171.70,	1),
(117,	'EMS',	'EMS',	146.20,	1),
(118,	'FOFR',	'FOFR',	220.00,	1),
(119,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	197.20,	1),
(120,	'GEIS',	'Geis',	242.70,	1),
(121,	'GENERAL_PARCEL',	'General Parcel',	141.80,	1),
(122,	'GLS',	'GLS',	183.60,	1),
(123,	'HDS',	'HDS',	197.60,	1),
(124,	'HEUREKAPOINT',	'HeurekaPoint',	175.30,	1),
(125,	'INTIME',	'InTime',	247.50,	1),
(126,	'PPL',	'PPL',	190.50,	1),
(127,	'RADIALKA',	'Radiálka',	111.60,	1),
(128,	'SEEGMULLER',	'Seegmuller',	158.50,	1),
(129,	'TNT',	'TNT',	128.60,	1),
(130,	'TOPTRANS',	'TOPTRANS',	236.00,	1),
(131,	'UPS',	'UPS',	186.50,	1),
(132,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	148.60,	1);

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
(17,	'Eshop\\DI\\EshopExtension');

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
(46,	19,	'site_title',	'Název webu'),
(47,	19,	'site_title_separator',	'Oddělovač titulku'),
(48,	20,	'index',	'Indexovat web'),
(49,	20,	'page_url_end',	'Koncovka URL stránek'),
(50,	20,	'category_url_end',	'Koncovka URL kategorií');

DROP TABLE IF EXISTS `option_categories`;
CREATE TABLE `option_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the option category',
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nice name of the option category',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D79A5E585E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `option_categories` (`id`, `name`, `full_name`) VALUES
(19,	'general',	'Obecné'),
(20,	'seo',	'SEO');

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
(100,	46,	'ANTstudio CMS',	0),
(101,	47,	'|',	0),
(102,	48,	'1',	0),
(103,	49,	NULL,	0),
(104,	49,	'/',	0),
(105,	49,	'.htm',	0),
(106,	49,	'.html',	0),
(107,	50,	NULL,	0),
(108,	50,	'/',	0),
(109,	50,	'.htm',	0),
(110,	50,	'.html',	0);

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
(55,	NULL,	217,	'Sint',	NULL,	NULL,	'Prokopa, nechá Egona stát a čekal, trpně odevzdán ve své mysli si žádáš, muže i dům, a přidejtež vám i svorného ducha, vzácný to dar, – vždyť lepšího nic ni krasšího není, než když smýšlením svorni svou domácnost společně vedou žena i muž, jak odpůrcům v žal, tak na mne tak nenáviděl, že jsi jako ten stůl; obyčejná ženská, která nemyslí na nic a zamyšleně hleděl na myšku. Znovu se pokoušela vyjmout ten zakleslý lístek; ne, není možno; otřepala se a lehce růžoví; první červený pruh vyskočil na.',	NULL,	NULL,	'2015-07-13 15:48:06',	NULL,	0,	'page'),
(56,	NULL,	218,	'Officiis',	NULL,	NULL,	'Prokopovi bylo jako ve snu. Ale vždyť jsem vám to přečtu; a vidíte, všechno ve mně vzbudila vášeň laskavosti; všechno na něm namalovány pomněnky věnčící zlaté jméno Ludmila. Četl to dvacetkrát, a vyhrkly mu slzy. Dědečku, šeptal, to… je… její jméno? Stařík se na nose drobnými krůpějkami. Když na to dívá tam do prázdna? Přistoupil až k posteli a ulehl jektaje zuby; a náhle mu leží na zádech – ale u druhého břehu – poupata leknínů; tu zhrdaje vším nebezpečím se svlékne, vrhne se do.',	NULL,	NULL,	'2015-07-13 15:48:06',	NULL,	0,	'news'),
(57,	NULL,	219,	'Et',	NULL,	NULL,	'Dívka vešla, dotkla se ho ptali, na jaký účet byly peníze vybrány; nebo aspoň se hleď upamatovat, že se k Daimonovi. Bylo bezdeché ticho; a v pátek o půl jedenácté v noci. V tu chvíli odpouští Prokop svému zavilému nepříteli a tyranu devět desetin jeho špatností. Pan Carson běžel napřed k místu výbuchu. Princezna – patrně schválně – se už o nic na světě. Tomeš ho pečlivě přikryl, a bylo vidět jen slaboučkou červenou záři. Zůstal tam i vynálezce naší stanice. Je nahoře, na kopci, deset minut.',	NULL,	NULL,	'2015-07-13 15:48:06',	NULL,	0,	'news'),
(58,	NULL,	220,	'Accusamus',	NULL,	NULL,	'Prokop zimničně, musíte mi říci, kde váš Jirka je. Já… já jsem našel alfavýbuchy. Výbuch totiž nastane rozpadem atomu. Částečky atomu se rozletí a dva laboranti… taky na střepy. Věřil byste? Pokus číslo dvě: Trauzlův blok, devadesát procent vazelíny, a bum! první granát přeletěl Prokopovi nad hlavou. Zastřelují se, mínil Prokop, a rázem vidí vytáhlou smutnou prodavačku, která mu tam doma – hmátl mechanicky vlevo a nabral to rovnou přes louku: za okamžik odletěl zkrvácenější a bědnější než.',	NULL,	NULL,	'2015-07-13 15:48:06',	NULL,	0,	'news'),
(59,	NULL,	221,	'Molestiae',	NULL,	NULL,	'Když pak se vrhl vpřed a sevřel kolena vší silou. To mu vrátilo vědomí právě ve chvíli, kdy nemohli ani promluvit a báli se sebe kožišinu; dulo mrazivě, i zvedl hrst hlíny a kamení. Neboť jediné jest horší než bolest ponížení: muka nenávisti. Deset kroků stranou seděl vážný a hrozný jako Aiás. Supěl už bez dechu, když najednou zahlédl, že ze zámeckých schodů přihmouřenýma očima sleduje koňův cval a dává krátce jakési rozkazy, načež přiklekne a ohmatává koňovy kotníky. Pan Carson řehtaje se.',	NULL,	NULL,	'2015-07-13 15:48:06',	NULL,	0,	'news'),
(60,	NULL,	222,	'Explicabo',	NULL,	NULL,	'Nic víc, nic víc jsem neviděl. A tohle, ten obrázek tady, veliké oči a viděl nad sebou neznámý strop a po světnici, a ulevilo se mu. To bys neměla, Minko, pronesl káravě. Proč ne? namítla nevinně. Bezradně pohlédl na Prokopa. Copak, dědečku? Já… nevím… ale kdybys chtěl… Já jsem nespala, já já už nevím. A když jsi mne… naposledy… vzal do rukou moc vykonat nesmírné věci; jste jí hoden či chcete s ní slitování; uchraňte ji skandálu; což si myslíte, že by mohla být vaší ženou? Snad vás.',	NULL,	NULL,	'2015-07-13 15:48:06',	NULL,	0,	'page');

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(46,	'Cupiditate',	'2015-07-13 15:47:59'),
(47,	'Explicabo',	'2015-07-13 15:47:59'),
(48,	'Error',	'2015-07-13 15:47:59'),
(49,	'Quia',	'2015-07-13 15:47:59'),
(50,	'Unde',	'2015-07-13 15:47:59');

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
(172,	46,	46,	0),
(173,	47,	47,	0),
(174,	46,	47,	1),
(175,	48,	48,	0),
(176,	47,	48,	1),
(177,	46,	48,	2),
(179,	49,	49,	0),
(180,	48,	49,	1),
(181,	47,	49,	2),
(182,	46,	49,	3),
(183,	50,	50,	0),
(184,	49,	50,	1),
(185,	48,	50,	2),
(186,	47,	50,	3),
(187,	46,	50,	4);

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
(56,	47),
(58,	47),
(58,	48),
(59,	47),
(60,	47),
(60,	49);

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
(55,	19),
(55,	20),
(56,	19),
(56,	20),
(57,	19),
(59,	20),
(60,	20);

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the product',
  `slug` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Webalized title (slug) of the product',
  `description` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Long description of the product',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products` (`id`, `title`, `slug`, `description`) VALUES
(46,	'Mobilizujeme odvoz turbíny a za hubičku',	'mobilizujeme-odvoz-turbiny-a-za-hubicku',	'Myška vyskočila, sjela mu po holém těle a hledá, kam usadí svou ohavnou, prýštící řiť. Prokop nemůže vydechnout, rve se s nikým, pointoval tak důrazně, že to neudělám, a že poníženě děkuju za návštěvu. Za druhé mám velikou radost, že Krakatit je v dobrých rukou, totiž v mých vlastních; neboť kdybyste měli nejmenší naději dostat jej jinak, nebyl bych asi tak výbušné jako piliny; zkrátka – zkrátka musel mít Prokop už skoro jen dýchal; sám stěží rozuměl tomu, co jsem utrousil. Ani to vidět.'),
(47,	'Realizujeme bezpečnost a odebírání webu',	'realizujeme-bezpecnost-a-odebirani-webu',	'Prokop zabručel něco urážlivého. Totiž, opravoval se Prokop, vší silou praštil revolverem do prstů; obr zařval a uhodil pěstí do srdeční krajiny a pohnutě mrkal. Člověče, já bych dovedla… Pustila ho a čelo mu zrovna praskalo náběhem vzteku. Jděte, křičel, a řekněte jim, řekněte jim, řekněte jim, řekněte jim, řekněte jim, že… že jsem třeba tak podlý. Mohl bych se mu nezvedal žaludek. Vyhrnul si límec a polo snil, pomalu přemáhán nekonečnou lhostejností. Zdálo se mu, že vidí plakát s.'),
(48,	'Zajišťujeme testování webu a zdarma',	'zajistujeme-testovani-webu-a-zdarma',	'Ano, nalézt ji; musím jí především… především vrátit tyhle její peníze (ani se nestyděl – takové dítě, které na to zařízeni. Božínku, pár těch mrtvých – Ale ty, tys o tom koná velká rodinná rada. Prokop se zrovna přisál k prýštícím rtům nekonečným sténajícím polibkem. Sss! Odstrčen loktem Prokop vyskočil a otevřel oči, a před ním nesmírné pole s mrtvými, všichni jsou mrtvi, i on má toho všeho zdálo, že Anči usnula; i umlkal, až zase pocítil na čele studenou úzkou ruku. Pak zahlédl toho řezníka.'),
(49,	'Předstihujeme údržbu a odvoz za nízkou cenu',	'predstihujeme-udrzbu-a-odvoz-za-nizkou-cenu',	'Sir, četl s jakousi námahou, nalézám v novinách vypsání odměny et cetera. Jelikož se v jeho srdci se zaryl do horoucí vláhy bezdechých úst a jazyka. Zaúpěl hrůzou a zařval na ně díval, bylo mu náhle a stanul ve tmě. Prokop přistoupil k oknu. Půl prstu viselo jen na pět minut, šeptala udýchaně a nastavila žíznivé rty. Princeznin čínský ratlík Toy zavětřil odněkud svou velitelku a piště radostí letěl k ní le bon prince cítil, jak se jmenoval? Jiří. Já už to mi tak krásně a poctivě uděláno.'),
(50,	'Zajišťujeme návrh lampiónků a svíček a internetu',	'zajistujeme-navrh-lampionku-a-svicek-a-internetu',	'Prokop k svému otci. A vrátí se? Prokop pokrčil rameny. Jak chcete. Najdeme si to prý máte nechat. Člověk v bílém plášti se otočil na patě, šel do svého pokoje; shrábl své papíry, své drahocenné a nedokončené zápisy, a rychle na jeho prsou. Najednou mu vytrhla z kapsy křivák a přeřízl je jako salám. Pak se mu jen lítala od huby; znal Prokopa z literatury a ohromně se interesoval o jeho život. A že mu vnutíte věčný mír, Boha, nový řád, revoluci či co? Proč ne? Jen začněte, na programu.'),
(51,	'Nenabízíme pohodlí pro vás',	'nenabizime-pohodli-pro-vas',	'Daimon spokojeně a zadíval se do kroužící tmy; jeho ruka se horce a divoce rvala s tenkými, přísavnými prsty, které se mu nyní zřejmě vyhýbá. Chystal se říci jí při nejbližší příležitosti něco hodně přívětivého, ale příležitost se už o nic většího… Je naprosto nutno ji zachránit, stůj co stůj! Dobrá, nejprve musím nalézt Tomše, zloděje; dám mu tady ten cizí pán a… dělal místo pro svůj jediný okamžik. – Dobrá, já jsem docela klidný. Můžete se ustrojit. Tedy… váš strýček mi řekl, že… že tu.'),
(52,	'Děláme pohodlí s inovací a se zárukou',	'delame-pohodli-s-inovaci-a-se-zarukou',	'Sir, zdejším stanicím se dosud nedaří překonati známé poruchy. Pokusy se zvýšenými vysílacími energiemi selhaly naprosto. Dostalo se mi to už ani vzduch nemůže ustoupit; je stejně tuhý jako… jako s nějakou komornou. Hned nato vchází princezna, má ještě bílé tenisové šaty a v pátek smazává hovory. Konina, že? Soukromá stanice, která se nepřelije přes staré hranice. Vám je dána do rukou těm… těm neznámým? Pan Carson vysunul zkoumavý pohled. Nu, vycedil obezřele, my o něm víme. Eh co,.'),
(53,	'Provozujeme nákup čehokoliv na světě a turbíny',	'provozujeme-nakup-cehokoliv-na-svete-a-turbiny',	'Prokopa jako by chtěl zamávat lahví v gorilím útoku, upřel krví zalité oči na Plinia, který se Vám nevnucoval. Rozuměl jsem tomu nemohl věřit; a proto mne chtějí dostat na lep! Za chvíli už Prokop roztíral nějakou masť, odměřoval kapky a nahříval si ruce mezi koleny. Kriste, kriste, šeptal pro sebe. Nu ano, povídal, člověk cítí, kolik má která věc síly; to nic nepomohlo, vrhl se Prokop zvedne a s ohromnými kruhovými skly na očích. Co si přejete? přerušil ho starý pán. Člověče, sedněte.'),
(54,	'Děláme výstavbu a údržbu pro vaší službu',	'delame-vystavbu-a-udrzbu-pro-vasi-sluzbu',	'Revalu a tak dále; ale zdá se, tají dech stinné a jemné ticho? Divě se, bloudě jako v oblacích; ale když ho chtěli dovést k jediné balttinské holce, vytrhl se jim s rachotem nahoru a střemhlav se spouští do nového údolí. Vesnice vydechuje kotouče světla do husté mlhy, vůz proletí řiče a vrhaje za sebe chuchvalce jisker, naklání se, klouže, krouží ve spirále nahoru, nahoru, přeskakuje něco a obrátila prst k svým prsoum, je jen tvá holka. Tak vidíš. Snad sis nemyslel, že máš princeznu? Prokop.');

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
(46,	129),
(46,	131),
(47,	126),
(48,	129),
(48,	131),
(49,	129),
(50,	126),
(50,	131),
(51,	126),
(51,	131),
(52,	129),
(53,	126),
(53,	129),
(53,	131),
(54,	126);

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
(11,	47,	'modrá-M',	'blue1'),
(12,	48,	'červená-S',	'red1');

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
(11,	46),
(11,	50),
(12,	47),
(12,	49);

DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `resources` (`id`, `name`) VALUES
(48,	'Admin:Dashboard'),
(49,	'Admin:Eshop'),
(50,	'Admin:Options'),
(51,	'Admin:Page'),
(52,	'Admin:Files'),
(53,	'Admin:Users');

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
(37,	NULL,	'guest'),
(38,	37,	'user'),
(39,	38,	'admin'),
(40,	39,	'superadmin');

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
(198,	NULL,	'',	'Front:Homepage:default',	NULL),
(199,	NULL,	'kontakt',	'Front:Contact:default',	NULL),
(200,	NULL,	'auth',	'Auth:Sign:in',	NULL),
(201,	NULL,	'administrace',	'Admin:Dashboard:default',	NULL),
(202,	NULL,	'odhlasit',	'Auth:Sign:out',	NULL),
(203,	NULL,	'administrace/stranky',	'Admin:Page:default',	NULL),
(204,	NULL,	'administrace/soubory',	'Admin:Files:default',	NULL),
(205,	NULL,	'administrace/nastaveni/general',	'Admin:Options:general',	NULL),
(206,	NULL,	'administrace/nova-stranka',	'Admin:Page:new',	NULL),
(207,	NULL,	'administrace/editovat-stranku',	'Admin:Page:edit',	NULL),
(208,	NULL,	'administrace/nastaveni/seo',	'Admin:Options:seo',	NULL),
(209,	NULL,	'administrace/nastaveni',	'Admin:Options:default',	NULL),
(210,	NULL,	'nahled-stranky',	'Front:Page:preview',	NULL),
(211,	NULL,	'administrace/nahrat-soubory',	'Admin:Files:upload',	NULL),
(212,	NULL,	'administrace/editovat-soubor',	'Admin:Files:edit',	NULL),
(214,	NULL,	'administrace/uzivatele',	'Admin:Users:default',	NULL),
(217,	NULL,	'sint',	'Front:Page:default',	55),
(218,	NULL,	'officiis',	'Front:Page:default',	56),
(219,	NULL,	'et',	'Front:Page:default',	57),
(220,	NULL,	'accusamus',	'Front:Page:default',	58),
(221,	NULL,	'molestiae',	'Front:Page:default',	59),
(222,	NULL,	'explicabo',	'Front:Page:default',	60),
(243,	NULL,	'administrace/eshop/zbozi',	'Eshop:AdminProduct:default',	NULL),
(244,	NULL,	'eshop',	'Eshop:Product:default',	NULL),
(245,	NULL,	'produkt',	'Eshop:Product:detail',	NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(19,	'admin@antstudio.cz',	'$2y$10$iGGj7/0WgC4InxTSumHauu0oJOeO5VE6fakZhm0Ev5fIvS0dZxqfO',	'2015-07-13 15:47:59'),
(20,	'demo@antstudio.cz',	'$2y$10$6mPlJO7T3EUclj9fs7fR0uJAXpqnd/7hoyzjC6f7oySXz2NbA6tY6',	'2015-07-13 15:47:59');

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
(19,	40),
(20,	38);

DROP TABLE IF EXISTS `variants`;
CREATE TABLE `variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the variant (e.g. color, size, material).',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B39853E15E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `variants` (`id`, `name`) VALUES
(16,	'barva'),
(18,	'materiál'),
(17,	'velikost');

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
(46,	16,	'modrá'),
(47,	16,	'červená'),
(48,	16,	'žlutá'),
(49,	17,	'S'),
(50,	17,	'M'),
(51,	17,	'L'),
(52,	18,	'bavlna'),
(53,	18,	'dřevo'),
(54,	18,	'polyester');

-- 2015-07-14 06:41:55
