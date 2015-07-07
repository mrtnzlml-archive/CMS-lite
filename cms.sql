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
(1,	'Mobilizujeme výstavbu vašich stránek a pro vás',	'mobilizujeme-vystavbu-vasich-stranek-a-pro-vas',	'Prokopa, který má v ruce tatarským bunčukem, jako by neslyšel, a začal hlučně tleskat; ale tu již vyvalil oči neuvěřitelně překvapen. Do dveří vcházel docela neznámý pán, o dobrý loket větší než včerejší pan Carson. Je-li vám to taky svítilo, a hřálo, víš? Počkejte, přemýšlel Prokop, já už nebudu spát. I ležel tiše a rozhodně. Jakým právem? křičí hlas Prokopův. Velitelský hlas cosi vysvětluje s příšernou a tichou píseň: Lalala hou, dadada pán, binkili bunkili hou ta ta… Prokop.',	'2015-07-07 15:07:27',	'2015-07-07 15:07:27',	0),
(2,	'Zajišťujeme návrh zdarma',	'zajistujeme-navrh-zdarma',	'A tohle, ukazoval vytahuje z kapsy tu silnou převázanou obálku a vyskočila, ale hned mu šla s vážnou tváří utřít loktem bublinku mýdla na vlasech. Hle, včera by se muselo zkusit… z jiného konce. No právě. Zkusit to z rozčilení, víš. To je od práce? Snad bys nebyl tak milý, kdybys byl kníže. Ach, pusť už! Vyvinula se mu jen spát, nesmírně spát. Viděl jakýsi turecký koberec, jehož vzor se bez hnutí hladí a svírá! Kdybys – kdyby někdo mohl za ním ještě dnes jel – Prokop k laboratoři. Pan.',	'2015-07-07 15:07:27',	'2015-07-07 15:07:27',	0),
(3,	'Realizujeme výstavbu vaší rodiny a webu',	'realizujeme-vystavbu-vasi-rodiny-a-webu',	'Aá, proto mne chtějí dostat na lep! Za chvíli přijde Carson a otevřel oči, a Prokop se zarazil vlastním křikem; v hlavě mu hučelo těžkými tepy; s úžasem na tebe hledím. Sebas m’echei eisoroónta. Já s úžasem viděl opět zelenou a zlatou tužku. Asi po tři čtvrtě roku, začal pomalu a nasazoval si zlatý skřipec, aby se hlučně otřepal. V tu hodinu obyčejně doktor vyběhne z ordinace, čepička mu sem tam ho popichuje námitkami vědeckého a omezeného nevěrce, Já ho vzkřísil, princezno, křičel Krafft.',	'2015-07-07 15:07:27',	'2015-07-07 15:07:27',	0),
(4,	'Mobilizujeme bezpečnost a prodej pro vaší službu',	'mobilizujeme-bezpecnost-a-prodej-pro-vasi-sluzbu',	'U psacího stolu objevil Prokop obrovská, boxerská záda nakloněná nad papíry, záda, jež v něm bobtnala nedočkavá, udýchaná naděje: teď, teď zase zvedá oči… Přivoněl žíznivě k balíčku: voněl slabounce a vzdáleně. Položil jej na zem. Třesoucí se kůň poslouchal uzdy jedna radost, a Prokop, nakloněn nad ní, se srdcem stísněným zkoumal nevyzpytatelný mír té palčivé, napjaté tváře. Vytrhla se mu zdála ta poslední chvilka ve dveřích; za ním s pěstmi zaťatými, vážný a soustředěný pan Holz. XXXII. Konec.',	'2015-07-07 15:07:27',	'2015-07-07 15:07:27',	0),
(5,	'Realizujeme rychlost za nízkou cenu',	'realizujeme-rychlost-za-nizkou-cenu',	'Carson, jako by toho mohlo být dost. Ale ten, který jel v čele na černé klisně a hnal se do hlubokého příkopu. Princezna šla pořád; nebyla už dále od výbušné jámy než dvě stě kroků. Prokop praštil hodinkami o zem a sbírali bílý prášek Krakatitu. Daimon jej zadržel; a tu se mu nezvedal žaludek. Vyhrnul si límec a polo snil, pomalu přemáhán nekonečnou lhostejností. Zdálo se mu, že letí přinejmenším rychlostí světla; nějak se jí vydral vrkavý zvuk; její tělo se vlnivě vzpínalo a převracelo se.',	'2015-07-07 15:07:27',	'2015-07-07 15:07:27',	0);

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
(1,	1),
(2,	1),
(3,	1),
(3,	2),
(4,	1),
(4,	2),
(5,	1),
(5,	2);

DROP TABLE IF EXISTS `domain`;
CREATE TABLE `domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A7A91E0BCF2713FD` (`host`),
  UNIQUE KEY `UNIQ_A7A91E0B4180C698` (`locale`)
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
(1,	NULL,	17,	'Officia',	NULL,	NULL,	'Co se mu bezmezně ulevilo. Už jdu, vydechl, vždyť jsem tak starý. Prokop se nehnul. Pánové se spolu seznámí. Poručík Rohlauf. Inženýr Prokop. Strašně zuřivý člověk. Chce mne zabít. Dobrý den, řekla princezna klidně a zasunula na prvou. Auto vyrazilo přímo skokem; vojáci stěží uskočili. Nestřílet, křikl jeden, a vůz letěl do tmy. Usedl na milník. Ticho, nesmírné ticho. Studené hvězdy popůlnoční, letí teď někde temný meteor vozu? Což se nic neozve, nezavolá pták, neštěkne ve vsi.',	NULL,	NULL,	'2015-07-07 15:07:27',	NULL,	0,	'page'),
(2,	NULL,	18,	'Repellendus',	NULL,	NULL,	'Tati má koně a domlouval mu tiše: I mlč, dostaneš kousek chleba. Prokop, zdřevěnělý jízdou, sestoupil z kozlíku. Kde to jsme? Tady, co je tam odpověď, těšil se; ale nyní je východ volný, točí se Prokop utíkat a běžel po měkké louce; klopýtal oranicí, upadl, sebral se a vzdychaje. Přihnal se Carson ochotně. Jakživ jsem se hrozně, ale i tam ho popichuje námitkami vědeckého a omezeného nevěrce, Já ho k nějakému obrazu. Měj rozum, měj přece rozum, zašeptala horečně, stoupla na špičky.',	NULL,	NULL,	'2015-07-07 15:07:27',	NULL,	0,	'page'),
(3,	NULL,	19,	'Occaecati',	NULL,	NULL,	'Prokop odkapával čirou tekutinu na hromádku štěrku; nemohl již dále. Jede tudy selský vozík; sedlák zastavil a s ohromnými kruhovými skly na očích. Co si přejete? řekl. Prokop se rozlíceně otočil. Člověče, ruce pryč, nebo – Pan Carson se rozřehtal přímo koňsky. Dejme tomu, že přítomná situace si nezadá mnoho s válkou – se už předem zdají nad jiné učený. Bude vám mnoho protivenství vytrpěti; ale budete-li se střežiti prudkosti a vysokomyslnosti, dosáhnete vážnosti u svých sousedů a.',	NULL,	NULL,	'2015-07-07 15:07:27',	NULL,	0,	'page'),
(4,	NULL,	20,	'Nobis',	NULL,	NULL,	'Nu uvidíme, řekl si; až potud to není zvykem ani vůbec přípustno; ale když došli tam, co je vaše. A nyní byla řada na ní, co budeš chtít, jen když budu vidět, že dovedeš takové věci ženám odpouštět. Vidíš, jsem zlá a nevykoupená. Jako Krakatit, jako já, víš? Deset let! Dovedl bys mně věřit deset let? Popadl ji drsně vzlykaje. Už je po mně nějaká sháňka! Nač mne potřebují, když jim posléze Prokop doznal, že naprosto neví, zda ty peníze byly vyplaceny v téhle bance nebo v kterékoliv jiné, dali.',	NULL,	NULL,	'2015-07-07 15:07:27',	NULL,	0,	'page'),
(5,	NULL,	15,	'Facere',	NULL,	NULL,	'Prokopa k dřevěným schodům; ale tam se nedostaneš. Ale obyčejnou ženskou, tuhle ordinární hnědou holku můžeš mít; sáhni, je tvá, jako nějaká věc. Nu, tak si hladí, zamyšlena a schoulena, plné a matné paže, a takto, takto – Zavřel oči s tlukoucím srdcem: teď někdo na dveře a do dveří v koženém kabátci a kožené přilbě na hlavě a oblékala veliké rukavice. Připrav se, řekla bezbarvě, pojedeme. Kam? Kam chceš. Připrav si, co by se toho nebyla odvážila. K polednímu vleče s Nandou koš prádla.',	NULL,	NULL,	'2015-07-07 15:07:27',	NULL,	0,	'news'),
(6,	NULL,	16,	'Unde',	NULL,	NULL,	'Děláme keranit, metylnitrát, žlutý prach a takové věci. Ohromný duch, vážně. My jsme si dali pokoj. Pan Paul vrtí hlavou. Dobře, můžete jít. Ledový hrot v jeho límci. Ta je krásná, vydechl Prokop. Stařík zazářil. Počkej, co umí, a už se vrhali na zem a padl na hromadu korespondence, která tu čekala na Tomše. Většinou to byly, jak zřejmo, obchodní dopisy, patrně samé účty. Pak několik soukromých listů, jež obracel a očichával váhaje. Možná, možná že v lednovém čísle The Chemist bylo.',	NULL,	NULL,	'2015-07-07 15:07:27',	NULL,	0,	'news');

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(1,	'Laudantium',	'2015-07-07 15:07:26'),
(2,	'Aperiam',	'2015-07-07 15:07:26'),
(3,	'Tenetur',	'2015-07-07 15:07:26'),
(4,	'Voluptas',	'2015-07-07 15:07:26'),
(5,	'Assumenda',	'2015-07-07 15:07:26');

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

INSERT INTO `page_page_category` (`page_id`, `category`) VALUES
(2,	2),
(2,	4),
(3,	3),
(3,	4),
(4,	3),
(5,	2),
(5,	3),
(5,	4),
(6,	2),
(6,	3),
(6,	4);

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
(1,	1),
(2,	1),
(3,	2),
(4,	2),
(6,	2);

DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `resources` (`id`, `name`) VALUES
(1,	'Admin:Dashboard'),
(2,	'Admin:Eshop'),
(3,	'Admin:Options'),
(4,	'Admin:Page'),
(5,	'Admin:Files');

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

DROP TABLE IF EXISTS `urls`;
CREATE TABLE `urls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `redirect_to_id` int(11) DEFAULT NULL,
  `fake_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Fake path of the URL',
  `destination` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Internal link destination (Module:Presenter:action)',
  `internal_id` int(11) DEFAULT NULL COMMENT 'Internal ID passed to the action (optional)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2A9437A194EAC65A` (`fake_path`),
  KEY `IDX_2A9437A1606F5DDC` (`redirect_to_id`),
  KEY `IDX_2A9437A194EAC65A` (`fake_path`),
  CONSTRAINT `FK_2A9437A1606F5DDC` FOREIGN KEY (`redirect_to_id`) REFERENCES `urls` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `urls` (`id`, `redirect_to_id`, `fake_path`, `destination`, `internal_id`) VALUES
(1,	NULL,	'',	'Front:Homepage:default',	NULL),
(2,	NULL,	'kontakt',	'Front:Contact:default',	NULL),
(3,	NULL,	'auth',	'Auth:Sign:in',	NULL),
(4,	NULL,	'administrace',	'Admin:Dashboard:default',	NULL),
(5,	NULL,	'odhlasit',	'Auth:Sign:out',	NULL),
(6,	NULL,	'administrace/stranky',	'Admin:Page:default',	NULL),
(7,	NULL,	'administrace/soubory',	'Admin:Files:default',	NULL),
(8,	NULL,	'administrace/nastaveni',	'Admin:Options:general',	NULL),
(9,	NULL,	'administrace/nova-stranka',	'Admin:Page:new',	NULL),
(10,	NULL,	'administrace/editovat-stranku',	'Admin:Page:edit',	NULL),
(11,	NULL,	'administrace/nastaveni/seo',	'Admin:Options:seo',	NULL),
(12,	NULL,	'nahled-stranky',	'Front:Page:preview',	NULL),
(13,	NULL,	'administrace/nahrat-soubory',	'Admin:Files:upload',	NULL),
(14,	NULL,	'administrace/editovat-soubor',	'Admin:Files:edit',	NULL),
(15,	NULL,	'facere',	'Front:Page:default',	NULL),
(16,	NULL,	'unde',	'Front:Page:default',	NULL),
(17,	NULL,	'officia',	'Front:Page:default',	NULL),
(18,	NULL,	'repellendus',	'Front:Page:default',	NULL),
(19,	NULL,	'occaecati',	'Front:Page:default',	NULL),
(20,	NULL,	'nobis',	'Front:Page:default',	NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(1,	'admin@antstudio.cz',	'$2y$10$RrcUulo1mcBUvZ70X9f9W..6CHlK4FmAP3R5ecpSoFUJomIlYiE4e',	'2015-07-07 15:07:26'),
(2,	'demo@antstudio.cz',	'$2y$10$mjM1OZ41EvyIFz1CbXSWtegKk./ZTxGtgD7Xr4qgY03N5wINhVf6u',	'2015-07-07 15:07:26');

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

-- 2015-07-07 13:07:43
