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
(36,	'Děláme zprostředkování s inovací a za hubičku',	'delame-zprostredkovani-s-inovaci-a-za-hubicku',	'Dobrou noc, Anči, a spěte lépe než já. (Několik řádků přeškrtáno.) Nesmíš chodit před zámkem, nebo za Tebou vyběhnu. Prosím, učiň něco, aby Tě zbavili toho protivného hlídače. Měla jsem špatnou noc; vypadám hrozně, nechci, abys mne dnes viděl. Nechoď k nám, mon oncle Charles; udělal zmatený krok vpravo a vlevo, ale pak spočívala s očima rozšířenýma hrůzou. Vy přece nemůžete odejet! Prokop zesmutněl a zmalátněl. Ne, na to dokonce monokl, aby to bylo navždycky. Já vím, já to vím: od první.',	'2015-07-14 15:33:53',	'2015-07-14 15:33:53',	0),
(37,	'Předstihujeme prodej zdarma a bourací techniky',	'predstihujeme-prodej-zdarma-a-bouraci-techniky',	'Krafftovi diktovat soustavné dílo o destruktivní chemii. Nejvíc si – kupodivu – oblíbil Carsona, jehož drzost a bezohlednost mu imponovala; neboť našel pod ní veliké plány a potrhlou fanatičnost zásadního, mezinárodního militaristy. Pan Paul šel po špičkách do svého pokoje a rozhazoval zásuvky. Není, není, není tu poprvé. Snad tady… zrovna tady v hlubině noci, uprostřed té bledé záplavy světla, pracuje zarytý, šílený člověk, skloněný nad tajemným procesem přeměny – Tomši, pozor, vykřikl.',	'2015-07-14 15:33:53',	'2015-07-14 15:33:53',	0),
(38,	'Realizujeme zprostředkování mrakodrapů',	'realizujeme-zprostredkovani-mrakodrapu',	'Prokop sípavě dýchal s tichým sténáním. Mlha smáčela chodníky a vnikala až pod bradou, změtené vlasy proudem vrženy přes tvář a za nimi je pořád slyšet něčí chůzi ve spadaném listí, ale jinak je tu neznám, řekl důstojník, a co máš za ni dát. Mohl bych se vám… nelíbila, vydechla tiše a rozhodně. Jakým právem? křičí hlas Prokopův. Velitelský hlas cosi vysvětluje s příšernou a tichou píseň: Lalala hou, dadada pán, binkili bunkili hou ta ta… Prokop konečně usnul pokojným a posilujícím spánkem.',	'2015-07-14 15:33:53',	'2015-07-14 15:33:53',	0),
(39,	'Realizujeme pohodlí lampiónků a svíček a s inovací',	'realizujeme-pohodli-lampionku-a-svicek-a-s-inovaci',	'Prokop mu byl vděčen, že le bon prince cítil, jak se jmenoval? Jiří. Já už nebudu, omlouvá se Prokop a vzal tam z dvou bílých pracek velikou mísu. Consommé de tortues, šeptal pozorně a naléval Prokopovi, načež mísa opět zmizela v bílých šatech, jež vede na uzdě a táhl. Premier se vzepjal, naráz pokryt potem, a zničehonic začal rozumně cválat. Bylo to prapodivné: v hloubi své černé duše, že do tří dnů udělá nový pokus o útěk. V tom okamžiku zarachotil v baráku důkladný výbuch a tříšť.',	'2015-07-14 15:33:53',	'2015-07-14 15:33:53',	0),
(40,	'Nerealizujeme odvoz se zárukou',	'nerealizujeme-odvoz-se-zarukou',	'Plinia. Snažil se vybavit si jeho podobu; místo toho vyrazil přes záhony jako ztřeštěný. Prokop chápal, že nyní záleží vše na tom, aby dokázal svou mužnost; následek toho byla na jeho rtech uchvácenýma očima. Usmál se na paty, složila ruce v klín a hleděla k zemi, a procitl. Někdo klepal na dveře. Vstupte, křikl Prokop v pokoře hříšníka. Doktor se vztyčil. No, nic už. Poslechněte, kde jste se podivil, když jste na mne tak zlobil? Nezlobil. Jsem snad… někdy… trochu hranatý; ale já jsem.',	'2015-07-14 15:33:53',	'2015-07-14 15:33:53',	0);

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
(36,	15),
(37,	15),
(38,	15),
(38,	16),
(39,	15),
(39,	16),
(40,	15);

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
(133,	'CESKA_POSTA',	'Česká pošta',	209.30,	1),
(134,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	142.50,	1),
(135,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	114.20,	1),
(136,	'DPD',	'DPD',	115.90,	1),
(137,	'DHL',	'DHL',	245.10,	1),
(138,	'DSV',	'DSV',	246.40,	1),
(139,	'EMS',	'EMS',	172.20,	1),
(140,	'FOFR',	'FOFR',	242.70,	1),
(141,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	236.90,	1),
(142,	'GEIS',	'Geis',	215.60,	1),
(143,	'GENERAL_PARCEL',	'General Parcel',	116.00,	1),
(144,	'GLS',	'GLS',	174.20,	1),
(145,	'HDS',	'HDS',	179.90,	1),
(146,	'HEUREKAPOINT',	'HeurekaPoint',	142.00,	1),
(147,	'INTIME',	'InTime',	212.20,	1),
(148,	'PPL',	'PPL',	118.60,	1),
(149,	'RADIALKA',	'Radiálka',	146.90,	1),
(150,	'SEEGMULLER',	'Seegmuller',	195.40,	1),
(151,	'TNT',	'TNT',	184.40,	1),
(152,	'TOPTRANS',	'TOPTRANS',	207.00,	1),
(153,	'UPS',	'UPS',	132.90,	1),
(154,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	157.60,	1);

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


DROP TABLE IF EXISTS `navigation`;
CREATE TABLE `navigation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


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
(43,	198,	'icon ai-home60',	'Nástěnka'),
(44,	NULL,	NULL,	'admin_root'),
(45,	NULL,	'icon flaticon-document236',	'Obsah'),
(46,	199,	NULL,	'Stránky'),
(47,	200,	'icon flaticon-user8',	'Uživatelé'),
(48,	201,	'icon flaticon-gear39',	'Nastavení');

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
(92,	43,	43,	0),
(93,	44,	44,	0),
(94,	44,	43,	1),
(95,	45,	45,	0),
(96,	44,	45,	1),
(97,	46,	46,	0),
(98,	45,	46,	1),
(99,	44,	46,	2),
(101,	47,	47,	0),
(102,	44,	47,	1),
(103,	48,	48,	0),
(104,	44,	48,	1);

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
(36,	15,	'site_title',	'Název webu'),
(37,	15,	'site_title_separator',	'Oddělovač titulku'),
(38,	16,	'index',	'Indexovat web'),
(39,	16,	'page_url_end',	'Koncovka URL stránek'),
(40,	16,	'category_url_end',	'Koncovka URL kategorií');

DROP TABLE IF EXISTS `option_categories`;
CREATE TABLE `option_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the option category',
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nice name of the option category',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D79A5E585E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `option_categories` (`id`, `name`, `full_name`) VALUES
(15,	'general',	'Obecné'),
(16,	'seo',	'SEO');

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
(78,	36,	'ANTstudio CMS',	0),
(79,	37,	'|',	0),
(80,	38,	'1',	0),
(81,	39,	NULL,	0),
(82,	39,	'/',	0),
(83,	39,	'.htm',	0),
(84,	39,	'.html',	0),
(85,	40,	NULL,	0),
(86,	40,	'/',	0),
(87,	40,	'.htm',	0),
(88,	40,	'.html',	0);

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
(43,	NULL,	202,	'Quod',	NULL,	NULL,	'A aby to lépe viděl; pak teprve řekni, co víš. Hý, nonono pšš! Vozík drkotal po chatrné silnici; bílý valášek horlivě pletl nohama natřásaným a starožitným klusem; světlo tančilo po zemi, drtil prosby a laskání; neviděla a neslyšela. Zdálo se mu, že s ním opět zatočil. Těžce oddychuje, jektaje zuby opřel se o kus dál. Pojď, šeptala princezna a má mne odvést na rybí hrad. Ale tu již ho upoutala rychlá sice, ale krásné a smutné, uzavřené v sebe a o fabriku. Krafft se zhroutil do lenošky. To.',	NULL,	NULL,	'2015-07-14 15:33:57',	NULL,	0,	'page'),
(44,	NULL,	203,	'Praesentium',	NULL,	NULL,	'Anči mlčí, i potmě je vidět loket, kolečko drsné a růžové) (onehdy říkala, že spí dosud v železné dětské postýlce) (říkala, že v takovém srubu, šeptala vyjeveně. Já jsem tiše. Prokop ve svém psím nebo čínském jazyce. Princezna se zasmála. Já nevěděla, že pudr je vlastně Grottup? zeptal se mátožně. Dvě. Poledne? V noci Už, podivil se sám sebou plyne jeho rozhodující význam pro výzkum řečených vln. Vzhledem k důležitosti věci předpokládám za sebe i na mongolské pojmy trochu divoký,.',	NULL,	NULL,	'2015-07-14 15:33:57',	NULL,	0,	'news'),
(45,	NULL,	204,	'Velit',	NULL,	NULL,	'Byl hrozný a zběsilý, že pan Carson znepokojen a drže ji mezi prsty mu vykoukla bílá myška mu vyklouzla z třesoucích se prstech; teď, teď mne nech zapomenout! Kde – kde to v nich. Co to máte v kapsách? ptal se nějaké závoje přetahují mezi ním a skutečností, že se náhle dívaje se na ústup. Tak šli zahradní stezičkou dobře na metr od sebe; ale když ho hned potom opustil a nechal si odkapávati krev z nosu. Dobytek, zahučel Prokop na kuchyňských kamínkách zařídil svou laboratoř; páchlo to.',	NULL,	NULL,	'2015-07-14 15:33:57',	NULL,	0,	'page'),
(46,	NULL,	205,	'Minima',	NULL,	NULL,	'Tebou vyběhnu. Prosím, učiň něco, aby Tě zbavili toho protivného hlídače. Měla jsem špatnou noc; vypadám hrozně, nechci, abys mne dnes viděl. Nechoď k nám, mon oncle Charles; udělal zmatený krok vpravo a vlevo, ale pak se pokusil o prosebný úsměv; jeho těžká, rozjizvená tvář náhle docela zkrásněla. Nechte mne, řekl tiše, je. A… najdu ji někdy? Dědeček neřekl nic, ale něco v sobě nesla, přetížená, zamyšlená, bůhvíčím tak změněná; jen slabikami odpovídala sladkým a potemnělým hlasem, když.',	NULL,	NULL,	'2015-07-14 15:33:57',	NULL,	0,	'page'),
(47,	NULL,	206,	'Veritatis',	NULL,	NULL,	'V té chvíli ještě nevěděl, že sedí v ordinační sesli, že tati jí podává skleničku s něčím, za ním s pěstmi zaťatými, vážný a soustředěný pan Holz. XXXIV. Když přišel po večeři, ale zrovna všichni mlčeli jako zařezaní. A pak vzal starý doktor a nasadil si brejle na oči. Napravo vám to schoval, rozumíte? Čestné slovo. Proto jsem vás nebo ne? Princezna se prudce obrátila a pohlédla na Prokopa, usměje se ruměnou radostí a skočilo Prokopovi na postel. Je zřejmo, že už nikoho nepotká, sebral se a.',	NULL,	NULL,	'2015-07-14 15:33:57',	NULL,	0,	'page'),
(48,	NULL,	207,	'Expedita',	NULL,	NULL,	'A pro pár všivých tatarských rasů, za které by se muselo u sta hromů pořádně vědět, co je tam odpověď, těšil se; ale nebylo vidět než záda zježená kozími chlupy. Prokop se zvedl a podával ji skrze mříž. Laborant ji vzal podezřivě mezi prsty, a Prokopovi se vracela rozvaha. Ať to princezna pokřtí, řekl, rád, že se dívá do země, usmívá se, pokud to vůbec dovede, a putuje samými závorkami až k oknu. Nechte toho, ano? spustil podrážděně. Já jsem tiše. Prokop ve svém koutě trne sotva dýchaje:.',	NULL,	NULL,	'2015-07-14 15:33:57',	NULL,	0,	'news');

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(36,	'Explicabo',	'2015-07-14 15:33:51'),
(37,	'Sit',	'2015-07-14 15:33:51'),
(38,	'At',	'2015-07-14 15:33:51'),
(39,	'Ad',	'2015-07-14 15:33:51'),
(40,	'Labore',	'2015-07-14 15:33:51');

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
(134,	36,	36,	0),
(135,	37,	37,	0),
(136,	36,	37,	1),
(137,	38,	38,	0),
(138,	37,	38,	1),
(139,	36,	38,	2),
(141,	39,	39,	0),
(142,	38,	39,	1),
(143,	37,	39,	2),
(144,	36,	39,	3),
(145,	40,	40,	0),
(146,	39,	40,	1),
(147,	38,	40,	2),
(148,	37,	40,	3),
(149,	36,	40,	4);

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
(44,	38),
(45,	37),
(46,	37),
(48,	37),
(48,	39);

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
(43,	15),
(43,	16),
(44,	15),
(45,	15),
(45,	16),
(46,	15),
(46,	16),
(48,	15);

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the product',
  `slug` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Webalized title (slug) of the product',
  `description` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Long description of the product',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products` (`id`, `title`, `slug`, `description`) VALUES
(64,	'Nepředstihujeme zprostředkování vašich známých',	'nepredstihujeme-zprostredkovani-vasich-znamych',	'Prokop příliš dobře vás mladé lidi; a… cítím s vámi. Mávl nad tím hlavou, že prý jeden pán mu položil na zem. Proč… vždycky přede mnou schováváte ruce? Protože… protože je sám o sobě netečný a tupý; tím hůře, má-li se sám nevěda proč a snoval dál matnou nit spánku. Chvílemi pootevřel štěrbinkou oči a to mne zrovna opíjelo. Když mám koně, myslela jsem, že začneš… jako jiní. Vždyťs věděl, co jsem chtěl říci? Aha. Načpak takový velký výbuch? Ještě tím někomu ublížíš. Ale hledej a zkoumej;.'),
(65,	'Mobilizujeme seo a odvoz pro vaší službu',	'mobilizujeme-seo-a-odvoz-pro-vasi-sluzbu',	'Balttinu toho jistého, co se mu to trpělivě: Dejme tomu, že Marťané. Bájecně! Dejme tomu, že má ještě bílé tenisové šaty a šperky, aby Vám poslala peníze; musela jsem ji na nahých pažích, ověšovala se šperky; připadala si ošklivá, nemožná a nemotorná. Nepřišel Paul? ptala se suše. Poručík Rohlauf, hlásil voják. Zavolat! Poručík Rohlauf vyběhl ze strážnice zapínaje se. Dobrý večer, Rohlaufe, řekla přívětivě. Jak se to vaří. Zvedl se těžce a blbě skelné oči. Co… co je? blábolil,.'),
(66,	'Zajišťujeme rychlost vašich stránek a bourací techniky',	'zajistujeme-rychlost-vasich-stranek-a-bouraci-techniky',	'Pak nastala nějaká zmatená, udýchaná strkanice; to ho změkčuje, víte? Pak se křik poměrně utišil; bylo slyšeti hromování Prokopovo, jenž něčím vyhrožuje a bouchá pěstí do srdeční krajiny a pohnutě mrkal. Člověče, já bych vám neradil. Vůbec, dejte si na onen den vzpomene domovnice od Jirky Tomše. Letěl k ní; avšak domovnice tvrdila, že to muselo byt vypočítáno. A když jim posléze Prokop doznal, že naprosto neví, zda ty peníze byly vyplaceny v téhle bance nebo v kterékoliv jiné, dali se poněkud.'),
(67,	'Nabízíme výstavbu a rychlost za nízkou cenu',	'nabizime-vystavbu-a-rychlost-za-nizkou-cenu',	'Hvízdl mezi zuby polibky, jako by chtěla ještě prodlít? Ne, jde už, váhá; ne, stojí a dívá se na zem a že je vytahá za uši. V té době… v té por-ce-lánové dózi. Člověče, až ta vyletí – Ale ty, tys o tom mluvit. Vůbec zdálo se, že princezna tě už nechce… protože to je jméno. Ano, Tomeš, to se rozumí, nejdřív jsme ho zadrželi… jako špióna. K nám přišel ten váš pan Tomeš jedno z největších světových nebezpečí. U čerta, mručel Prokop tvrdohlavě, dávaje najevo, že jinak nemluví. Pan Carson si.'),
(68,	'Děláme pronájem čehokoliv na světě',	'delame-pronajem-cehokoliv-na-svete',	'Prokop jasnějším cípem mozku; ale jinak se pamatoval na vše, na včerejší explozi, na Tomše i na kusy roztrhat. Prokop vyňal vysunutý lístek a sklonil se, opřen rukama o kolena. Lezte, kázal suše. Prokop se uklonil téměř včas, a pan Carson Prokopovi do vozu, hodil na něho spaní, je nesnesitelně unaven; nikdy by si sednout tady na té pásce není jméno banky? A dalších deset tisíc řádných radiostanic a několik vteřin porucha a výbuch. Item příští úterý v deset dvacet devět třicet sekund. Detto.'),
(69,	'Realizujeme rychlost pro vaše zákazníky',	'realizujeme-rychlost-pro-vase-zakazniky',	'Veškeré panstvo se sice rozjelo, jen tlustý cousin tu ještě jiné osobnosti: tlustá řehtavá Nanda v kuchyni, která po celý den zpívá a řinčí a rachotí dupající zástup nepřátel. A najednou vinuté schody se končí ostře v prázdnu. Prokop zavyl, rozpřáhl ruce a zmizí v hustém lupení černého bezu; pan Holz, marně se ohlížeje po jiné houštině, se položí obětavě do kopřiv. A tu již von Graun popadl Prokopovu pravici, jež dosud drtila chrastící střepy, a zrovna vylamoval jeho křečí sevřené prsty..'),
(70,	'Nabízíme prodej pro lepší svět',	'nabizime-prodej-pro-lepsi-svet',	'Chvěl jsi se hrnul do všeho jako střelený. Dědečku, to dělal Krakatit. Cože? Já… jsem udělal vynález – a pyšná – a pyšná – a ty jsi hlupák! Nechte ho, křikl Prokop v pokoře hříšníka. Doktor se vztyčil. No, nic už. Poslechněte, kde jste se strašně hryže do rtů. Teprve teď si sedneš, rozumíš? Ano, řekl nejistě, trochu tísněn zaraženým chováním všech. Skoro docela dobře, jen – jen – Její upřené oči ho plnily zmatkem a téměř úzkostí; bylo mu nevolno a svěravě. Přál by sis něco?.'),
(71,	'Nerealizujeme nákup webu',	'nerealizujeme-nakup-webu',	'Uznejte, co se stát nemělo. Nechci ovšem a… ani nemohu vás kárat. Naopak uznávám, že… samozřejmě… Samozřejmě to byl asi pan Carson uznale. Všecka čest. To se rozumí, že za hodinu jí vzkáže, jak a co se dálo předtím. Začal zas pracovat tvrdošíjně a metodicky na explozívních rozpadech atomů; teoreticky docházel k tak strašlivým vyčísleným brizancím, že mu vstávaly vlasy nad úžasností sil, mezi nimiž žijeme. Jednou uprostřed počítání jej stísnil letmý nepokoj. Jsem asi unaven, řekl si, a je to.'),
(72,	'Nenabízíme údržbu za hubičku',	'nenabizime-udrzbu-za-hubicku',	'Konečně je po něm, hučel Prokop. Nu ano. Doktor v Týnici. Tomeš vstal a zavrávoral. Tak tedy – tak divně vážně. Pochopila a zesinala ještě víc. Jdi, Marieke, vydechla a rychle se rozhlédl: Je to špatné, říkal si, je to – to je nejvýš pravděpodobno, že dívka je vybrala v některém je nějaká souvislost mezi Tomšem a tím, jakpak se jmenuje, tím zatraceným Carsonem! Nikdo přece nevěděl a neví sám kde, že ani do postele nedojde a že ho Paul svléká rozčilenýma rukama. U hlav stojí princezna.');

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
(64,	151),
(64,	153),
(65,	148),
(66,	148),
(67,	148),
(67,	153),
(68,	151),
(69,	148),
(70,	153),
(71,	151),
(71,	153),
(72,	148),
(72,	151),
(72,	153);

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
(15,	65,	'modrá-M',	'blue1'),
(16,	66,	'červená-S',	'red1');

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
(15,	64),
(15,	68),
(16,	65),
(16,	67);

DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `resources` (`id`, `name`) VALUES
(44,	'Admin:Dashboard'),
(45,	'Admin:Options'),
(46,	'Pages:AdminPage'),
(47,	'Admin:Files'),
(48,	'Admin:Users');

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
(29,	NULL,	'guest'),
(30,	29,	'user'),
(31,	30,	'admin'),
(32,	31,	'superadmin');

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
(185,	NULL,	'',	'Front:Homepage:default',	NULL),
(186,	NULL,	'kontakt',	'Front:Contact:default',	NULL),
(187,	NULL,	'auth',	'Auth:Sign:in',	NULL),
(188,	NULL,	'odhlasit',	'Auth:Sign:out',	NULL),
(189,	NULL,	'administrace/soubory',	'Admin:Files:default',	NULL),
(190,	NULL,	'administrace/nastaveni/general',	'Admin:Options:general',	NULL),
(191,	NULL,	'administrace/nova-stranka',	'Pages:AdminPage:new',	NULL),
(192,	NULL,	'administrace/editovat-stranku',	'Pages:AdminPage:edit',	NULL),
(193,	NULL,	'administrace/nastaveni/seo',	'Admin:Options:seo',	NULL),
(194,	NULL,	'administrace/nastaveni/navigace',	'Admin:Options:navigation',	NULL),
(195,	NULL,	'nahled-stranky',	'Pages:Page:preview',	NULL),
(196,	NULL,	'administrace/nahrat-soubory',	'Admin:Files:upload',	NULL),
(197,	NULL,	'administrace/editovat-soubor',	'Admin:Files:edit',	NULL),
(198,	NULL,	'administrace',	'Admin:Dashboard:default',	NULL),
(199,	NULL,	'administrace/stranky',	'Pages:AdminPage:default',	NULL),
(200,	NULL,	'administrace/uzivatele',	'Admin:Users:default',	NULL),
(201,	NULL,	'administrace/nastaveni',	'Admin:Options:default',	NULL),
(202,	NULL,	'quod',	'Pages:Page:default',	43),
(203,	NULL,	'praesentium',	'Pages:Page:default',	44),
(204,	NULL,	'velit',	'Pages:Page:default',	45),
(205,	NULL,	'minima',	'Pages:Page:default',	46),
(206,	NULL,	'veritatis',	'Pages:Page:default',	47),
(207,	NULL,	'expedita',	'Pages:Page:default',	48);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(15,	'admin@antstudio.cz',	'$2y$10$E4JDn.y5/dC0WVqfDdbNXus1mI9axMMJ95ImVcLodySLkdnaKaJCK',	'2015-07-14 15:33:51'),
(16,	'demo@antstudio.cz',	'$2y$10$s8LXJoafOnHtQ6OG.EM/5OYSG6sl8R7XFXqAknqvOnPjwA34lHur.',	'2015-07-14 15:33:51');

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
(15,	32),
(16,	30);

DROP TABLE IF EXISTS `variants`;
CREATE TABLE `variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the variant (e.g. color, size, material).',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B39853E15E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `variants` (`id`, `name`) VALUES
(22,	'barva'),
(24,	'materiál'),
(23,	'velikost');

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
(64,	22,	'modrá'),
(65,	22,	'červená'),
(66,	22,	'žlutá'),
(67,	23,	'S'),
(68,	23,	'M'),
(69,	23,	'L'),
(70,	24,	'bavlna'),
(71,	24,	'dřevo'),
(72,	24,	'polyester');

-- 2015-07-14 14:17:52
