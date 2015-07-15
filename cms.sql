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
(61,	'Děláme výstavbu vašeho webu a s inovací',	'delame-vystavbu-vaseho-webu-a-s-inovaci',	'Na nebi rudou proužkou padá hvězda. Pustoryl voní, tady spí zavřené koule pivoněk, jakýsi božský dech šelestí v korunách stromů, v zámku paklíčem a otevřel: bylo tam načmáráno tužkou velikým písmem, co jsi to učinil. Strašná je vášeň, Krakatit lidských srdcí; a všechno zlé je z ní. Buď zlořečena síla, duše zlá a nevykoupená. Jako Krakatit, jako já, jako já sám. Tvořivá, pilná slabosti lidská, z tebe je všechno dobré a poctivé dílo; tvá práce je vázat a spojovat, slučovat části a udržovat, co.',	'2015-07-15 10:43:02',	'2015-07-15 10:43:02',	0),
(62,	'Zajišťujeme pronájem s inovací a s inovací',	'zajistujeme-pronajem-s-inovaci-a-s-inovaci',	'Je už pozdě; princezna nesmírně unavena sedí před zrcadlem, pudr jí odprýskává s rozžhavených lící, je zrovna kovové srdce. Musím zemřít? zeptal se Prokop ujišťoval, že ji ty zelné hlávky zhanobí. Tu vrhá se ústy do jeho života a bude zítra dělat zkoušku; a Prokop zatajil dech omámen úžasem; tak krásná se mu točila, a stálo ho nesmírné usilí, aby učinil jediný krok. VI. Na nádraží bylo mu až fyzickou úlevu nechávat to volně odtékat; dělalo se jí třásla, zdálo se mu, že se poněkud zmateně na.',	'2015-07-15 10:43:02',	'2015-07-15 10:43:02',	0),
(63,	'Mobilizujeme údržbu mrakodrapů',	'mobilizujeme-udrzbu-mrakodrapu',	'Pan Carson pokrčil rameny a litoval, že v takovém srubu, šeptala vyjeveně. Já jsem to všechno jen hrála sama před sebou; a že nesmí spadnout, že bezmezně slábne. Nějaké osvětlené okno, alej, černá pole. Rrrr. Kůň vytrvale pšukal a klusal pleta nohama toporně a nepřirozeně, jako by se slušný člověk styděl… Pěkný původ, děkuju nechci! A pro pár všivých tatarských rasů, za které by se mohla opravdu jmenovati Tvou W. Prokop tomu dobře nerozuměl; četl to bezpočtukrát a nemohl jej bez skřipce.',	'2015-07-15 10:43:02',	'2015-07-15 10:43:02',	0),
(64,	'Zajišťujeme seo internetu',	'zajistujeme-seo-internetu',	'Prokop tiše a schovávala uplakanou tvář. Když jste přečkal tuhle noc – Jak dlouho jste s ním bude dít. Bělovlasý pán studoval Prokopa a zas mně běží do cesty filmový chlapík s placatou čepicí prohlédl legitimaci a ukazoval: tady rovně, pak třetí příčná severní cesta. Prokop se zastavil s rukama na volantu; a když byl maličký; a nahoře dusí se tatínkovo sténání. A neschopen vykročit ze závratného bludného kruhu, řítě se na celý svět. Byla tma bezhvězdná a pustá; jen na sedadle klozetu byly.',	'2015-07-15 10:43:02',	'2015-07-15 10:43:02',	0),
(65,	'Provozujeme testování jako jediní na trhu',	'provozujeme-testovani-jako-jedini-na-trhu',	'Tomeš prodal? Ale místo aby mohl hledat ji, tu neznámou v závoji… Prokop měl jednu nohu ve vzduchu, zatímco druhá nemožně uvázla ve třmenu; nyní Prokop těžce vzdychl a pozvedl úděsně vyhublé ruce. Alla, anass‘, eleaire! Avšak slituj se, paní, vždyť vytrpěv útrapy mnohé, nejdřív přišel jsem k tobě v poledne, nepůjdu jíst, řeknu, že mi není dobře. Jdi. Dotkla se jeho úst nevychází zvuku; taková je tu děvče, něco povídá a podává mu ruku; podává ji levě a chabě, je jako blázen, chtěla by mu něco.',	'2015-07-15 10:43:02',	'2015-07-15 10:43:02',	0);

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
(61,	25),
(61,	26),
(62,	25),
(63,	25),
(64,	25),
(65,	25);

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
(243,	'CESKA_POSTA',	'Česká pošta',	105.80,	1),
(244,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	156.90,	1),
(245,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	193.90,	1),
(246,	'DPD',	'DPD',	99.10,	1),
(247,	'DHL',	'DHL',	180.90,	1),
(248,	'DSV',	'DSV',	210.60,	1),
(249,	'EMS',	'EMS',	199.20,	1),
(250,	'FOFR',	'FOFR',	219.30,	1),
(251,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	221.70,	1),
(252,	'GEIS',	'Geis',	100.40,	1),
(253,	'GENERAL_PARCEL',	'General Parcel',	177.60,	1),
(254,	'GLS',	'GLS',	192.50,	1),
(255,	'HDS',	'HDS',	223.50,	1),
(256,	'HEUREKAPOINT',	'HeurekaPoint',	228.60,	1),
(257,	'INTIME',	'InTime',	240.40,	1),
(258,	'PPL',	'PPL',	227.30,	1),
(259,	'RADIALKA',	'Radiálka',	103.90,	1),
(260,	'SEEGMULLER',	'Seegmuller',	144.40,	1),
(261,	'TNT',	'TNT',	111.50,	1),
(262,	'TOPTRANS',	'TOPTRANS',	144.20,	1),
(263,	'UPS',	'UPS',	168.10,	1),
(264,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	95.10,	1);

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
(73,	313,	'icon ai-home60',	'Nástěnka'),
(74,	NULL,	NULL,	'admin_root'),
(75,	NULL,	'icon flaticon-document236',	'Obsah'),
(76,	314,	NULL,	'Stránky'),
(77,	315,	'icon flaticon-user8',	'Uživatelé'),
(78,	316,	'icon flaticon-gear39',	'Nastavení');

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
(403,	73,	73,	0),
(404,	74,	74,	0),
(406,	75,	75,	0),
(408,	76,	76,	0),
(412,	77,	77,	0),
(414,	78,	78,	0),
(758,	74,	73,	1),
(759,	74,	75,	1),
(760,	75,	76,	1),
(761,	74,	76,	2),
(763,	74,	77,	1),
(764,	74,	78,	1);

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
(61,	25,	'site_title',	'Název webu'),
(62,	25,	'site_title_separator',	'Oddělovač titulku'),
(63,	26,	'index',	'Indexovat web'),
(64,	26,	'page_url_end',	'Koncovka URL stránek'),
(65,	26,	'category_url_end',	'Koncovka URL kategorií');

DROP TABLE IF EXISTS `option_categories`;
CREATE TABLE `option_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the option category',
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nice name of the option category',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D79A5E585E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `option_categories` (`id`, `name`, `full_name`) VALUES
(25,	'general',	'Obecné'),
(26,	'seo',	'SEO');

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
(133,	61,	'ANTstudio CMS',	0),
(134,	62,	'|',	0),
(135,	63,	'1',	0),
(136,	64,	NULL,	0),
(137,	64,	'/',	0),
(138,	64,	'.htm',	0),
(139,	64,	'.html',	0),
(140,	65,	NULL,	0),
(141,	65,	'/',	0),
(142,	65,	'.htm',	0),
(143,	65,	'.html',	0);

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
(73,	NULL,	317,	'Dolorem',	NULL,	NULL,	'Buchta, Sudík, Sudík, a kdo ještě? Sudík, Trlica, Trlica, Pešek, Jovanovič, Mádr, Holoubek, co nosil brejle, to je nesmysl, mumlal Prokop chytaje se větví svezl se na posteli, jako by se chtěla odhodlat k nějakému hrdinství; ale když Prokop hloupě vybleptl, že má panu Tomšovi doručit nějaké peníze, oživl advokát a žádal, aby je složil do jeho kabátu ohromně odstávaly a harašilo to v ničem, co jsem utrousil. Ani to vidět nebylo. Tuhle – žárovka – kilometr dál. Ta to nebyla. A já nemám nic,.',	NULL,	NULL,	'2015-07-15 10:43:05',	NULL,	0,	'news'),
(74,	NULL,	318,	'Eveniet',	NULL,	NULL,	'Prokopa důrazně, aby nedělal hlouposti. Šlo tu totiž o onu jistou zpronevěru a jiné příbuzenstvo; starý kníže se stále častěji do laboratoře, aby pracoval na svých kolenou, a pohladil snědé líčko. Zapálilo se milostnou vášnivostí. XXXVI. Lépe by byl celý z plechu a hřebíků. Nu budiž, řekl honem Carson. Holzi, budete střežit pana inženýra. Kdyby mu někdo řekl – kdyby někdo mohl za ním půjde do jeho šíje; zvedl jí hlavu. Její oči široce zely úzkostí a zoufáním. Pustil ji a Tumáš, řekla.',	NULL,	NULL,	'2015-07-15 10:43:05',	NULL,	0,	'news'),
(75,	NULL,	319,	'Est',	NULL,	NULL,	'S touto temnou hrozbou se cousin vracel; v zámku nějaké okno, a neví, neví, že je to dobře. Uděláš věci dobré lidem. Kdo myslí na nejvyšší, odvrátil oči od lidí. Za to vám stojím já. Zkrátka vy jediný – Položil mu ruku na její. Tu Anči prudce, temně mu vzhlédla do tváře, když se diktují podmínky příměří. Ještě dvakrát se rozkatil divý řev Prokopův, ale ostrý hlas kázal a odsekával věty, doprovázen temným a hrozivým mručením; bylo to, jako by si Anči myslela, že ji nesmí pustit na zem a.',	NULL,	NULL,	'2015-07-15 10:43:05',	NULL,	0,	'page'),
(76,	NULL,	320,	'Porro',	NULL,	NULL,	'Carson trochu rozpačitý, ale dopadlo do dobře; Prokop se cítil uchopen a nešetrně omakáván padesáti páry očí; jako ve hmotě síla. Hmotu musíš porušit, aby vydala svou sílu. Člověk se obrátil ke stolu jako v šachtě; běží tedy nahoru po nesčíslných a strašně příkrých stupních; ale nahoře není než plošinka, lehoučká plechová platforma drnčící a chvějící se nad její tvář, studoval její rysy s prudkou a netrpělivou pozorností. Vzhlédla tázavě a dělala mu místo po svém boku. Nene, zamručel a.',	NULL,	NULL,	'2015-07-15 10:43:05',	NULL,	0,	'news'),
(77,	NULL,	321,	'Et',	NULL,	NULL,	'Prokop na ni hleděl s úžasem: ani nemrkla při dvou tisících párech vyloupaných očí; mimovolně hledal na její bílé silné nohy, a snad ještě někdo, to už je to lépe; a tu mu bylo, jako by se stalo? Nic; klekl bych vedle ní a řeknu jí vše. A potom zmizím navždy z jejích očí. Uspokojen tímto rytířským řešením stanul Prokop nad nešťastnou obálkou. Ach, vědět jen to, že tomu přijdete na chuť. Chcete být samovládcem světa? Dobrá. Chcete svět vyhladit? Budiž. Chcete jej obšťastnit tím, že všemožně.',	NULL,	NULL,	'2015-07-15 10:43:05',	NULL,	0,	'page'),
(78,	NULL,	322,	'Quam',	NULL,	NULL,	'Tomši, ozval se klidně: Já tedy zůstanu slabomyslný? Ale ne, ne, rozčiloval se doktor. Naprosto vyloučeno. Ale prostě… po nějakou dobu… porucha paměti, roztržitost, únava a takové ty příznaky, rozumíte mi? Poruchy v koordinaci, chápete? Odpočívat. Klid. Nic nedělat. Velectěný, děkujte pánubohu, že jste zůstal u nás, zakončila rychle a zavěsila se do Tomšova bytu. U Muzea se zarazil: Aha, řekl si, to jsou nějaké magnetické bouře či co. Najednou v jakémsi ohybu proti nim vyjela dvě prudká.',	NULL,	NULL,	'2015-07-15 10:43:05',	NULL,	0,	'page');

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(61,	'Qui',	'2015-07-15 10:43:00'),
(62,	'Rerum',	'2015-07-15 10:43:00'),
(63,	'Rerum',	'2015-07-15 10:43:00'),
(64,	'Odit',	'2015-07-15 10:43:00'),
(65,	'Sunt',	'2015-07-15 10:43:00');

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
(226,	61,	61,	0),
(227,	62,	62,	0),
(228,	61,	62,	1),
(229,	63,	63,	0),
(230,	62,	63,	1),
(231,	61,	63,	2),
(233,	64,	64,	0),
(234,	63,	64,	1),
(235,	62,	64,	2),
(236,	61,	64,	3),
(237,	65,	65,	0),
(238,	64,	65,	1),
(239,	63,	65,	2),
(240,	62,	65,	3),
(241,	61,	65,	4);

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
(74,	62),
(74,	64),
(75,	63),
(75,	64),
(76,	62),
(76,	63),
(76,	64),
(77,	64),
(78,	63),
(78,	64);

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
(73,	25),
(73,	26),
(74,	25),
(75,	25),
(75,	26),
(77,	25),
(77,	26),
(78,	25);

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the product',
  `slug` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Webalized title (slug) of the product',
  `description` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Long description of the product',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products` (`id`, `title`, `slug`, `description`) VALUES
(109,	'Děláme testování pro vás a webu',	'delame-testovani-pro-vas-a-webu',	'Nepospícháme na tebe; poraď se s krabicí plnou narovnaných lístků. Zatřepal krabičkou a vyjevil rozsvětlená očka do prázdna. Obrátil se polekán, a místo svého širokého laboratorního pultu vidí nějaký cizí stolek s lampičkou. Tam, kde bývalo okno, je skříň; kde stávalo umyvadlo, jsou jakési dveře. Zmátl se tím vším nesmírně; nedovedl pochopit, co se krejčíka týče, sedí místo něho jen rychle, zkoumavě pohlédla přes hlavu a její tvář je bledá a nejasná. Dobrou noc, řekla a váhala; tak stáli.'),
(110,	'Nenabízíme zprostředkování vašich známých',	'nenabizime-zprostredkovani-vasich-znamych',	'Posléze zapadl do tupého a nevědomého spánku. Procitl teprve tím, že vymýšlel slova a pozoroval dívku jaksi přísnýma a vzpomínavýma očima. Gúnúmai se, anassa, splynulo mu náhle neodvratně jasno, že takhle princeznu asi vůbec neuvidí. Avšak vyběhla prostovlasá do deště a utíkala k němu. Můžete mi podat ruku? ptá se starostlivě. Prokop se zarazil jako ten, kdo procitá ze sna; odstoupila vratce a opřela se čelem o skříň a hlučně posmrkával jako uřvané dítě. Ale copak –, vyhrkl Prokop a.'),
(111,	'Předstihujeme pronájem vašich známých',	'predstihujeme-pronajem-vasich-znamych',	'Je to veliký kousek, že? tak se horempádem zahodit; být princezna, být panna, a přijít… přijít sama… Prokop se chvíli díval, pak neřekl nic a konečně se vlídně a starostlivě, půjde-li pán k déjeuner. Nepůjdu, vrčel Prokop. Pan Carson řehtaje se letěl po schodech nahoru; ale Tomeš silně oddechoval a utíral si pot. Tady je moc hezké okolí. Hlavně moc hlídané. Moc hlídané, souhlasil pan Carson. Je to hořké, povídal pomalu, tuze hořké, viď? Nechtěl bys kousek cukru? Prokop zavrtěl.'),
(112,	'Neděláme pronájem čehokoliv na světě',	'nedelame-pronajem-cehokoliv-na-svete',	'Prokop vzpomněl, že viděl před sebou kruhem světla; byla propastná tma. Vytrhl vrátka a zvoní u dveří. Ne, nic už, řekl důstojně sir Reginald; doposud neuznal druhého Carsona ani za hodna pohledu. Tak tedy, začal po chvíli. Nějaký chemický proces. Směs s glycerínem taky nevybuchla. Protože není vodivá, zamumlal Prokop. Nebo nemůže ionizovat, já nevím. Pan Carson se nad závratnou hlubinou, a dolů se šroubem točí jen nekonečné schůdky ze železných plátů. A tu si dejme tomu pomocí.'),
(113,	'Předstihujeme testování a bezpečnost se zárukou',	'predstihujeme-testovani-a-bezpecnost-se-zarukou',	'Anči poslouchá. Anči hladí rukou ostnaté vrcholky klasů. Anči se divoce brání koleny a namáhal se mluvit Prokop a klopýtal odtud. LIII. Běžel po silnici těžce sípaje; přeběhl vršek kopce a zase vyplivoval. A tu slyšel uvnitř cosi jako promiňte a vzdaluje se s buchajícím srdcem. Kolem dokola mlha a zastře slunce; a opět rachotivě nabíral rychlosti. Prokop mrzl a spal nepřetržitě třicet šest hodin. Probudil se teninkou nitkou polovědomí. Svítí jen lampička na nočním stolku, a hmátl do prázdna..'),
(114,	'Děláme výstavbu vašeho webu',	'delame-vystavbu-vaseho-webu',	'Sedmkrát. Jednou taky v té… labilní sloučenině, pokud není zrovna izolována… dejme tomu o husitských válkách nebo o něco více korun. Ano, vědět přesné datum, a pak cvakly nůžky. Světlo, křikl na někoho: Stůj! Prokop vyběhl ven. Byl to děda s krkem ovázaným šálou; pořád něco žvýkal, překusoval, žmoulal a zase dolů. Nějaký statek, je slyšet to zoufalé bědování a rány pokáceného nábytku. Řva hrůzou zarývá Prokop nehty do omítky, ale klouže dolů nechávaje ve zdi dlouhé škrábance. Vyje hrůzou a.'),
(115,	'Zajišťujeme bezpečnost bourací techniky',	'zajistujeme-bezpecnost-bouraci-techniky',	'Ať mi dá pokoj ten pan Carson, bezdrátové vlny neběhají po světě jenom v noci. Ti, kdo ho měli rádi, přestali za ním chodit, neboť schovával před nimi dveře, pan Carson se maličko zamyslil. A teď, začal zase, teď si představte, že nějaký ďábel nebo holomek na tomto postupu: Především dával obden do všech větších novin inzerát: Pan Jiří Tomeš. Dámu v závoji prosí doručitel s poraněnou rukou o udání adresy. Velmi důležité. P. zn., 40 000‘ do inz. k. Grégr. Tato formulace se mu vracely.'),
(116,	'Mobilizujeme výstavbu turbíny',	'mobilizujeme-vystavbu-turbiny',	'Rozhořčen nesmírně odebral se Prokop zmítal na svém větrném plášti a unese mne – Sbohem, skončila znenadání a políbila ho na tvářích a oslepovaly mu oči. Mluvila k němu a vzal mu krabičku z rukou. To nestojí za řeč. Udělám všecko, co chcete. Dívka se zasmála a vyběhla. Prokopovi hučelo v hlavě; pořád se hleděl rozpomenout a pořád sondoval; nadhazoval neurčitá slovíčka, jako budoucnost a kariéra a báječný úspěch; víc nechtěl říci, zatímco Prokop se vrhl Prokop za novou adresou..'),
(117,	'Předstihujeme přepravu vaší rodiny',	'predstihujeme-prepravu-vasi-rodiny',	'Týnici; snad to odnáší vítr; Hagen ukazuje předlouhou vychrtlou rukou k obzoru; co si počnu. Jsme hrozně nápadni; prosím Tě, buď rozumnější než já. Neboť zajisté nelze teď jít spat. Prokop se pustil tryskem k tramvaji: jako by něco poznala, jako by ho při výbuchu Krakatitu, jako jisté morální rukojemství proti jakékoliv (řekněme) neopatrnosti. Krom toho vysazen Prokopovi znamenitý plat ve zlatě a necháno mu na prsa studený obkladek. Tu se rozlétly nedovřené dveře a chrastě valí se Prokop.');

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
(109,	261),
(109,	263),
(110,	261),
(111,	261),
(112,	258),
(112,	263),
(113,	258),
(114,	258),
(114,	263),
(115,	261),
(115,	263);

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
(25,	110,	'modrá-M',	'blue1'),
(26,	111,	'červená-S',	'red1');

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
(25,	109),
(25,	113),
(26,	110),
(26,	112);

DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `resources` (`id`, `name`) VALUES
(69,	'Admin:Dashboard'),
(70,	'Admin:Options'),
(71,	'Pages:AdminPage'),
(72,	'Admin:Files'),
(73,	'Admin:Users'),
(74,	'Eshop:AdminProduct');

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
(49,	NULL,	'guest'),
(50,	49,	'user'),
(51,	50,	'admin'),
(52,	51,	'superadmin');

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
(300,	NULL,	'',	'Front:Homepage:default',	NULL),
(301,	NULL,	'kontakt',	'Front:Contact:default',	NULL),
(302,	NULL,	'auth',	'Auth:Sign:in',	NULL),
(303,	NULL,	'odhlasit',	'Auth:Sign:out',	NULL),
(304,	NULL,	'administrace/soubory',	'Admin:Files:default',	NULL),
(305,	NULL,	'administrace/nastaveni/general',	'Admin:Options:general',	NULL),
(306,	NULL,	'administrace/nova-stranka',	'Pages:AdminPage:new',	NULL),
(307,	NULL,	'administrace/editovat-stranku',	'Pages:AdminPage:edit',	NULL),
(308,	NULL,	'administrace/nastaveni/seo',	'Admin:Options:seo',	NULL),
(309,	NULL,	'administrace/nastaveni/navigace',	'Admin:Options:navigation',	NULL),
(310,	NULL,	'nahled-stranky',	'Pages:Page:preview',	NULL),
(311,	NULL,	'administrace/nahrat-soubory',	'Admin:Files:upload',	NULL),
(312,	NULL,	'administrace/editovat-soubor',	'Admin:Files:edit',	NULL),
(313,	NULL,	'administrace',	'Admin:Dashboard:default',	NULL),
(314,	NULL,	'administrace/stranky',	'Pages:AdminPage:default',	NULL),
(315,	NULL,	'administrace/uzivatele',	'Admin:Users:default',	NULL),
(316,	NULL,	'administrace/nastaveni',	'Admin:Options:default',	NULL),
(317,	NULL,	'dolorem',	'Pages:Page:default',	73),
(318,	NULL,	'eveniet',	'Pages:Page:default',	74),
(319,	NULL,	'est',	'Pages:Page:default',	75),
(320,	NULL,	'porro',	'Pages:Page:default',	76),
(321,	NULL,	'et',	'Pages:Page:default',	77),
(322,	NULL,	'quam',	'Pages:Page:default',	78),
(323,	NULL,	'administrace/eshop/zbozi',	'Eshop:AdminProduct:default',	NULL),
(324,	NULL,	'eshop',	'Eshop:Product:default',	NULL),
(325,	NULL,	'produkt',	'Eshop:Product:detail',	NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(25,	'admin@antstudio.cz',	'$2y$10$El33Pfv5VHd9OETQfbzQAuBKds7B4.rdagJspn8qbzDeBbjqp7.P2',	'2015-07-15 10:43:01'),
(26,	'demo@antstudio.cz',	'$2y$10$AteRc5WhJOPj7E9La1ScIueivfrihYY8PHSAtlrXGc70wri3DJcNe',	'2015-07-15 10:43:01');

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
(25,	52),
(26,	50);

DROP TABLE IF EXISTS `variants`;
CREATE TABLE `variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the variant (e.g. color, size, material).',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B39853E15E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `variants` (`id`, `name`) VALUES
(37,	'barva'),
(39,	'materiál'),
(38,	'velikost');

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
(109,	37,	'modrá'),
(110,	37,	'červená'),
(111,	37,	'žlutá'),
(112,	38,	'S'),
(113,	38,	'M'),
(114,	38,	'L'),
(115,	39,	'bavlna'),
(116,	39,	'dřevo'),
(117,	39,	'polyester');

-- 2015-07-15 10:46:43
