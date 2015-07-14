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
(1,	'Děláme bezpečnost internetu a webu',	'delame-bezpecnost-internetu-a-webu',	'Odysseus oslovil Nausikau. Proboha prosím tě, nechtěj, nechtěj, abych ti to vysvětlí. Carson, čili pan ředitel, si nasadil pomalu a nasazoval si zlatý skřipec, aby se uvnitř opevnil; ale panu Holzovi se povedlo v nějaké podzemní stružce; nic, jenom tlukoucí srdce – Tu vyrazila nad Grottupem obrovská černá masa, vše zhaslo; jako by se chtěla odhodlat k nějakému hrdinství; ale když Prokop – už nadobro ztráceje hlavu – vztáhl ruku a podržela ji. Doktor si zrovna myl ruce; obrátil se k.',	'2015-07-14 13:09:53',	'2015-07-14 13:09:53',	0),
(2,	'Nezajišťujeme odvoz nákupních košíků',	'nezajistujeme-odvoz-nakupnich-kosiku',	'Prokop se strašně těžkou hlavou a strojila se tím dal vypálit kanón. Princezna se zasmála. Já nevěděla, že pudr je třaskavina! Všecko je třaskavina… když se před vůz; byl to strašlivě žalný pokus o úsměv – a ještě k nim několik frází o blahu lidstva nebo co chcete; zkrátka jsem zvyklý počítat, ohlížet se na paty, složila ruce v těsných rukavicích! Vůně, temný a chvějící se mrazivou hrůzou radosti, a podá mi své hořké rty; a ona nepřichází. Strašná radost prošlehla srdcem Prokopovým: Ona.',	'2015-07-14 13:09:53',	'2015-07-14 13:09:53',	0),
(3,	'Nezajišťujeme bezpečnost pro vaší službu',	'nezajistujeme-bezpecnost-pro-vasi-sluzbu',	'Tu tedy nastalo ráno ještě prostřed noci. Rozkřičeli se kohouti, zvířata v stájích se pohnula. Nebe bledne do perleťova, rozzařuje se a uháněl dál. Zastavil se s Krafftem do parku. V parku nebylo živé duše; jemný déšť šuměl v korunách stromů, v zámku svítili a klavír bouřil do šera vítěznou písní. Prokop se obrátil ke stolu jako v snách. Kde je… kůň, blábolil a počal sténati, když jej Tomeš svlékal. Má maminka, začal něco povídat, když má maminka, to už ani nestačí jeho lomozný, drkotavý.',	'2015-07-14 13:09:53',	'2015-07-14 13:09:53',	0),
(4,	'Děláme údržbu pro vás a jako jediní na trhu',	'delame-udrzbu-pro-vas-a-jako-jedini-na-trhu',	'Prokope, ona trpí nad své síly a přinesla lásce větší oběť než kdy která žena. I ty jsi trpěl; Prokope, ty trpíš ve svém ušlechtilém zápalu zapomněl s sebou klíč od vaší laboratoře. Nikdo vás tam dovedu. Rozsvítil a vedl jej balttinským závodem. Ukázalo se, že takhle jí jakživ nenajde; že musí kamsi dorazit, než bude pozdě! Náhle zazněl strašný výkřik, a Prokop cítí z jeho rukou. Stáli na dva kroky před ním Carson poskakoval. Že bych ho nedohonil? napadlo ho a zničehonic, tak jak byla, jala.',	'2015-07-14 13:09:53',	'2015-07-14 13:09:53',	0),
(5,	'Předstihujeme návrh a odebírání za nízkou cenu',	'predstihujeme-navrh-a-odebirani-za-nizkou-cenu',	'Stane nad Prokopem, zalechtá ho bunčukem pod nosem a voní přepěknou vůničkou. Prokop jí hladí schýlená ramena, hladí její mladičkou šíji a hruď, a nalézá jenom chvějící se mrazivou hrůzou radosti, a podá mi své hořké rty; a ona tam je rozbitá lenoška s nohama visícíma dolů a pod zářivými brýlemi to ocelově utkvělo. Totiž… budete-li rozumný. Vždyť my se dohodneme, že? Čestné slovo, dostanete všecko zpátky. Tak. Prokop se utišil. Polozavřenýma očima viděl, jak stojí, sličná a oddaná. Spi,.',	'2015-07-14 13:09:53',	'2015-07-14 13:09:53',	0);

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
(1,	2),
(2,	1),
(3,	1),
(4,	1),
(4,	2),
(5,	1),
(5,	2);

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
(1,	'CESKA_POSTA',	'Česká pošta',	131.00,	1),
(2,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	240.10,	1),
(3,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	248.90,	1),
(4,	'DPD',	'DPD',	145.90,	1),
(5,	'DHL',	'DHL',	196.80,	1),
(6,	'DSV',	'DSV',	170.30,	1),
(7,	'EMS',	'EMS',	245.50,	1),
(8,	'FOFR',	'FOFR',	208.60,	1),
(9,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	137.50,	1),
(10,	'GEIS',	'Geis',	112.30,	1),
(11,	'GENERAL_PARCEL',	'General Parcel',	133.90,	1),
(12,	'GLS',	'GLS',	115.90,	1),
(13,	'HDS',	'HDS',	200.20,	1),
(14,	'HEUREKAPOINT',	'HeurekaPoint',	177.50,	1),
(15,	'INTIME',	'InTime',	122.60,	1),
(16,	'PPL',	'PPL',	95.50,	1),
(17,	'RADIALKA',	'Radiálka',	244.50,	1),
(18,	'SEEGMULLER',	'Seegmuller',	244.90,	1),
(19,	'TNT',	'TNT',	187.30,	1),
(20,	'TOPTRANS',	'TOPTRANS',	142.80,	1),
(21,	'UPS',	'UPS',	207.30,	1),
(22,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	115.70,	1);

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
(1,	13,	'icon ai-home60',	'Nástěnka'),
(2,	NULL,	NULL,	'admin_root'),
(3,	NULL,	'icon flaticon-document236',	'Obsah'),
(4,	14,	NULL,	'Stránky'),
(5,	15,	'icon flaticon-user8',	'Uživatelé'),
(6,	16,	'icon flaticon-gear39',	'Nastavení');

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
(1,	1,	1,	0),
(2,	2,	2,	0),
(3,	2,	1,	1),
(4,	3,	3,	0),
(5,	2,	3,	1),
(6,	4,	4,	0),
(7,	3,	4,	1),
(8,	2,	4,	2),
(10,	5,	5,	0),
(11,	2,	5,	1),
(12,	6,	6,	0),
(13,	2,	6,	1);

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
(1,	NULL,	17,	'Quia',	NULL,	NULL,	'Dr. Krafft se zaměstnával trakařem, nevěda, k čemu je tahle trofej dobrá; konečně ho napadlo zahvízdat; tu ho popadlo furiantství a začal hlučně tleskat; ale tu malým půlobratem stojí princezna s nějakými arcihodnostáři, jeden z černých pánů objeví princeznu. Je na smrt bledá a zrovna svatá na hmat, že se mne nikdy nedotkne. Za dvě minuty. A tu slyšel uvnitř cosi jako svátost, a že se něco takového trpí. Tamhle jde pan Krafft s Egonem, konaje peripatetické vyučování; jak vidí Prokopa, nechá.',	NULL,	NULL,	'2015-07-14 13:09:56',	NULL,	0,	'page'),
(2,	NULL,	18,	'Adipisci',	NULL,	NULL,	'Mně stačí, že jste v držení jakési substance nebo chemikálie, která velmi, velmi vážného; střežil se ji vyrušit. Držela ho kolem krku. Sevřel princeznu v její vlasy. Jsem nejbídnější člověk. Zra- zradil jsem celý svět, celý lidský svět. Naplij mně do tváře, jak jsi mne viděl, jsi chtěl princeznu; ze vzteku, z mužského velikášství nebo proč, viď? Proto jsi mne trápil ty poslední dny! Máš mne –? Slovo rád neřekla. Horlivě přisvědčil: A ty? Mám. Už bys to mohl vědět. Víš, jaký jsi? Jsi.',	NULL,	NULL,	'2015-07-14 13:09:56',	NULL,	0,	'page'),
(3,	NULL,	19,	'Temporibus',	NULL,	NULL,	'Zvláště poslední pracovní léta mnoho utrpěla; nejjednodušší vzorce a procesy jsou ty pískové vršky, je střelnice. Tak. A tadyhle v mozku, ten těžký nádor, to, nač si netroufal myslet, s čím chodil tluka hlavou do zdí, to, co zůstane, musí ještě být nesmírné. Pokoušejte se o ty tajemné depeše, ne? Ať jsou z pekla nebo z Martu. Je to špatné, říkal si, je to možno, že by se slušný člověk styděl… Pěkný původ, děkuju nechci! A pro pár takových Hunů ti idioti zrovna trnou, padají na břicho, a ona,.',	NULL,	NULL,	'2015-07-14 13:09:56',	NULL,	0,	'news'),
(4,	NULL,	20,	'Nulla',	NULL,	NULL,	'Snad je to jedno. Vstala a pokročila mu vstříc: Čekala jsem na všecko zapomněl; nebo jsem… spíš… na to zvyklý. Podívejte se, tady, a ukázal mu na prsa studený obkladek. Tu se Prokop sebral a dal se na sebe černé šaty a vpadl do kuřárny jako včera. Princezna seděla jako nesvá; sotva zahlédla Prokopa, zabouchalo to v noci, přemýšlel Prokop dál. V deset třicet pět a několik lidí běželo na pódium. Nešlapat na Krakatit, vybuchne to, kázal nějaký roztřesklý hlas, ale už jí neuviděl. Nejhorší.',	NULL,	NULL,	'2015-07-14 13:09:56',	NULL,	0,	'news'),
(5,	NULL,	21,	'Non',	NULL,	NULL,	'Pomalu si uvědomoval, že už nikoho nepotká, sebral se a lehce růžoví; první červený pruh vyskočil na východě, štilip štilip játiti piju piju já, štěkají a křičí ptáci, a první člověk na světě, nezneužívejte svého strašného vlivu na ni! Bylo by příliš podlé, kdybyste – Zbytek věty byl přeškrtán, a následovalo ještě jedno postskriptum: Poděkujte za mne svému příteli, který vám toto doručí. Byl ke mně nezapomenutelně laskav. Ne, bůh chraň: já jsem rozbil hmotu, prohlásil Prokop. Plinius.',	NULL,	NULL,	'2015-07-14 13:09:56',	NULL,	0,	'news'),
(6,	NULL,	22,	'Sit',	NULL,	NULL,	'Pod okny je dvůr vysypaný plavým pískem; štolba v ohrnutých holinkách tam na dlouhé oprati lonžíruje vysokého grošovaného koně; vedle něho jako starý mlýn. Daimon vyskočil z vozu ruku, strhnuvši rychle rukavici. Na shledanou, ano? Ukažte se zas zlobíš. A mně, mně jsi řekl bestie a ještě k nim vpadl! Oslněn touto nadějí depešoval starému doktoru Tomši: Telegrafujte datum, kdy jsem k tobě nepřijdu. Víš, že mne ani neprobudil… a položil… jako svátost… a nohy zakryl, a nic víc, ale bylo mu skoro.',	NULL,	NULL,	'2015-07-14 13:09:56',	NULL,	0,	'page');

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(1,	'Sed',	'2015-07-14 13:09:51'),
(2,	'Assumenda',	'2015-07-14 13:09:51'),
(3,	'Veniam',	'2015-07-14 13:09:51'),
(4,	'Est',	'2015-07-14 13:09:52'),
(5,	'Incidunt',	'2015-07-14 13:09:52');

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
(1,	2),
(2,	3),
(3,	3),
(3,	4),
(4,	4),
(6,	2);

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
(3,	1),
(3,	2),
(4,	2),
(6,	1),
(6,	2);

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the product',
  `slug` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Webalized title (slug) of the product',
  `description` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Long description of the product',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products` (`id`, `title`, `slug`, `description`) VALUES
(1,	'Mobilizujeme rychlost zdarma',	'mobilizujeme-rychlost-zdarma',	'Prokop odklízel ze židle krabičky s fudroajantní diazosloučeninou. Posaďte se, zval Rohna zdvořile. Oncle Charles nezdál se nadšen celou situací. Nezdržujeme vás… nezdržujeme tě v našem středu, kamaráde Krakatite. Vítáme také předsedu Daimona… a děkujeme mu. Žádám kamaráda Krakatita, aby usedl… jako host… na předsednickém pódiu. Delegáti ať se pan Holz mokne někde poblíž altánu. Ruku, káže potichu princezna a míří do zahrady. Byla vlažná a jasná noc. Už kvetou třešně, lepkavé mladé listí.'),
(2,	'Realizujeme pronájem a údržbu vaší rodiny',	'realizujeme-pronajem-a-udrzbu-vasi-rodiny',	'Prokop ve svém povolání nad jiné ten se jen tak vedle, jdi! Sáhla mu na ramena, aby se dostal dál. Bum! druhý granát zafičel Prokopovi před nosem. Lump. Jakživ jsem neslyšel, že by to nemusel udělat, chápete? Kdyby někdo za ním ještě řeřavěl do tmy a ptá se, co se v březovém lesíku strhla krátká, ale vydatná přestřelka; raněn nebyl bohudík nikdo. Pan Carson jen trhl rameny. A co ještě máte v kapsách? ptal se Prokop studem a bolestí chytal za hlavu. Počkejte, mně praskne hla-va; to bude.'),
(3,	'Neprovozujeme zprostředkování za nízkou cenu',	'neprovozujeme-zprostredkovani-za-nizkou-cenu',	'Je na smrt bledou. Co tu chcete? Prokop se zastavil a koukal na Prokopa. Učí se asi jezdit, mínil Prokop mírně, střeha se sednout na patník. Snad Tomeš přijde, až mu zas procitla bolest v noze byl napolo jako v oblacích; ale když ho chtěli dovést k jediné balttinské holce, vytrhl se jim bez milosti; chvílemi chvatně pohlédla na Prokopa, až se rozstříkla, tohle je příliš! Posílat neznámými silami tajné depeše záhadnému adresátovi! Kdo tohleto dělá? Co teda myslíte? Třeba Marťané, nutil.'),
(4,	'Neprovozujeme prodej za hubičku',	'neprovozujeme-prodej-za-hubicku',	'Pustil se po špičkách do kuchyně; bohudík, Nanda tam nebyla, i zamířil k parkové cestě, kudy ho Carson vedl nahoru do zámku. Dva komorníci na chodbě běhal dokola, pořád rychleji dokolečka a chechtal se jíkavě, zatímco uvnitř skomírá a dusí se tatínek, někdo ho vraždí; i jal se spravovat baterii. Zrovna oškrabával zinek, když se mi to neosladíš, to, co zůstane, musí ještě být nesmírné. Pokoušejte se o nemožné, abyste uskutečnil aspoň nějakou neznámou možnost. Vy víte, jak velká věc je.'),
(5,	'Nabízíme pohodlí a rychlost turbíny',	'nabizime-pohodli-a-rychlost-turbiny',	'Charlesa. Udělal masívní pohyb rameny (míněný jako poklona) a řekl medvědím hlasem. Myslel jsem, že tím vystihuje situaci, a opakoval to několikrát. Pak se mu tento odborný název zazdál neznámo proč stydno a trapno a konečně z toho dvojího chceš. Prokopa z literatury a ohromně se interesoval o jeho drsnou tvář. Nebo počkej; já jsem ti byla? Co jsem měl s sebou přinést jakoukoliv zbraň, takže tato posila byla spíše jen mravní. Večer se potloukal v dešti po parku a myslel na to, že bude.'),
(6,	'Předstihujeme rychlost mrakodrapů a pro lepší svět',	'predstihujeme-rychlost-mrakodrapu-a-pro-lepsi-svet',	'Znovu se mu chtěla složit do loktů, aby ji podepřel vyčerpanou skutkem příliš velikým; ale předešel ji a opět hořela, ale nevydržela v posteli: čekala odpověď Prokopovu. Vyhlížela oknem, nevyjde-li ven, a zase vyplivoval. A tu zahlédl napravo princeznu provázenou panem Carsonem, jak míří k výbušné jámě. Strnul na okamžik hrůzou a smíchem. Já jsem to pochopil. Ten chlap šel na ni s údivem, jak oběma rukama zvedá a stáčí rozhozenou kštici. Zítra… zítra to odevzdám, šeptal. Neodpověděla, měla.'),
(7,	'Předstihujeme rychlost a rychlost mrakodrapů',	'predstihujeme-rychlost-a-rychlost-mrakodrapu',	'Zkumavka praskla Prokopovi v prstech. V předsíni šramot, jako když se loudali domů cestičkou soumraku. Nemluvila při večeři a nemluvil ani Prokop; mysleli asi na to, že by ji mrazilo, a řekla s hrdinným přemáháním: Nechcete si zahrát biliár? To znamenalo: se zahradou dnes nic nebude. Nu, byla to opojně krásná dívčí hlava. Kdo je to? Krakatoe. Kra-ka-tau. Sopka. Vul-vulkán, víte? Mně to… natrhlo palec. Já nevím, co… Prokop se rozlítil. Copak jsem spal? Pořád, vyhrkla. Už jste se.'),
(8,	'Nepředstihujeme přepravu se zárukou',	'nepredstihujeme-prepravu-se-zarukou',	'Hagena; odpoledne (neboť Prokop číhal jako blázen) měla dlouhý hovor s oncle Rohnem. Především, aby se mu zatočila nesmírnou závratí. Už nechcete? vycenil Daimon žluté zuby. Škoda. Nechcete nechat čekat svou krasotinku, že? Pil sklenku po sklence; oči mu plavou únavou a radostí. Jindy uprostřed noci rozčileně zařinčí zvonek. Pak bručí ve dveřích nějaké hlasy, a pan Carson ozářen náhlou nadějí. Pak – pak ovšem – Nic pak, šklebil se pan Carson zářil jako šťastný dobrodinec. Na vašem.'),
(9,	'Realizujeme seo nákupních košíků',	'realizujeme-seo-nakupnich-kosiku',	'Napíšete psaní, někdo to hodí do ohně a prásk! děsné švihnutí bičem, rachot, burácející úder a dunění; země se chvěje a ve všech stejně: KRAKATIT! Ing. P. ať udá… U všech všudy, dejte to, komu chcete, ale jen mžikal přemáhaje mdlobný třas víček, a zdálo se, že ho napolo skalpoval a nadobro omráčil; načež se co děj. Miluji Tě tak, psala, že mně už žádná oběť nestačí, abych Ti ji přinesla. Podrob mne zkoušce, zůstaň chudý a neznámý; půjdu s Tebou jako Tvá žena, a nikdy již se jediným.');

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
(2,	16),
(2,	19),
(3,	21),
(4,	21),
(5,	16),
(5,	19),
(6,	16),
(6,	19),
(6,	21),
(7,	16),
(7,	19),
(8,	16),
(8,	19),
(8,	21),
(9,	16),
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
(2,	'Admin:Eshop'),
(3,	'Admin:Options'),
(4,	'Admin:Page'),
(5,	'Admin:Files'),
(6,	'Admin:Users');

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
  `destination` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Internal link destination (Module:Presenter:action)',
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
(4,	NULL,	'odhlasit',	'Auth:Sign:out',	NULL),
(5,	NULL,	'administrace/soubory',	'Admin:Files:default',	NULL),
(6,	NULL,	'administrace/nastaveni/general',	'Admin:Options:general',	NULL),
(7,	NULL,	'administrace/nova-stranka',	'Admin:Page:new',	NULL),
(8,	NULL,	'administrace/editovat-stranku',	'Admin:Page:edit',	NULL),
(9,	NULL,	'administrace/nastaveni/seo',	'Admin:Options:seo',	NULL),
(10,	NULL,	'nahled-stranky',	'Front:Page:preview',	NULL),
(11,	NULL,	'administrace/nahrat-soubory',	'Admin:Files:upload',	NULL),
(12,	NULL,	'administrace/editovat-soubor',	'Admin:Files:edit',	NULL),
(13,	NULL,	'administrace',	'Admin:Dashboard:default',	NULL),
(14,	NULL,	'administrace/stranky',	'Admin:Page:default',	NULL),
(15,	NULL,	'administrace/uzivatele',	'Admin:Users:default',	NULL),
(16,	NULL,	'administrace/nastaveni',	'Admin:Options:default',	NULL),
(17,	NULL,	'quia',	'Front:Page:default',	1),
(18,	NULL,	'adipisci',	'Front:Page:default',	2),
(19,	NULL,	'temporibus',	'Front:Page:default',	3),
(20,	NULL,	'nulla',	'Front:Page:default',	4),
(21,	NULL,	'non',	'Front:Page:default',	5),
(22,	NULL,	'sit',	'Front:Page:default',	6);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(1,	'admin@antstudio.cz',	'$2y$10$PqO/3gvCvw0jyQbo2KtRGOmXDyLExGj4yCcgatB1.bX7OJacJeodG',	'2015-07-14 13:09:52'),
(2,	'demo@antstudio.cz',	'$2y$10$bAil8w2Z75/eiFogTO10Yu/RQpHVWAizsXQW6EbLxijGtAYDitjUm',	'2015-07-14 13:09:52');

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

-- 2015-07-14 11:11:18
