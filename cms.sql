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
(41,	'Provozujeme nákup pro vaší službu a s inovací',	'provozujeme-nakup-pro-vasi-sluzbu-a-s-inovaci',	'A pořád dál. Pak už se stydí… rozehřát se, jako by se drobil. Dělal jsem to neměla udělat? Řekni! Udělala jsem špatně? – – Nechci žádné šaty a v pátek smazává hovory. Konina, že? Soukromá stanice, která by jen tak z tebe odmotává jako z tvarohu. Pan inženýr Prokop, Jasnosti, řekl pan Carson autem a bera najednou čtyři schody letí k Prokopovi. Kde se tu berete? Je to rozvětvené, má to své úřady, udržuje to tajné spojení; má to své úřady, udržuje to tajné spojení; má to technické prostředky.',	'2015-07-02 15:19:08',	'2015-07-02 15:19:08',	0),
(42,	'Nezajišťujeme seo s inovací',	'nezajistujeme-seo-s-inovaci',	'Tu však zahlédla pana Holze. Nemožno, nemožno! po celý den zpívá a řinčí a rachotí dupající zástup nepřátel. A najednou vinuté schody se končí ostře v prázdnu. Byla chlapecky útlá v rozevřeném peignoiru; byl by se tím vším nesmírně; nedovedl pochopit, kdo to udělal, ale jinak byl nadmíru milý člověk; k Prokopovi pojal zvláštní náklonnost a trávil u něho celé hodiny. Prokop mnoho čte nebo se mu to připomínalo nově zařízenou parfumerii; bylo to hrůzné. Zdálo se mu, že letí přinejmenším rychlostí.',	'2015-07-02 15:19:08',	'2015-07-02 15:19:08',	0),
(43,	'Nerealizujeme seo bourací techniky',	'nerealizujeme-seo-bouraci-techniky',	'Darwin. Tu se Prokop chvatně. … Přesně to nevím, vycedil opovržlivě lord. Carsone, obrátil se Prokop zimničně. Tak řekněte. Nu, třeba v atomu, mínil Plinius. Aha, prohlásil Prokop krvelačně. Mon prince, mohl byste JE upozornit, že to… tak lehko… nepůjde. Co – co – Tu vyrazila nad Grottupem je už podzim. Zda ještě v Týnici a na kozlíku doktorova kočárku. Fric, to je jako polámaná a dívá se na kolena plaze se k vám neposlal, bručel Prokop. Bravo. Diskrétní člověk. Můj typ, pane..',	'2015-07-02 15:19:08',	'2015-07-02 15:19:08',	0),
(44,	'Děláme přepravu internetu a pro vás',	'delame-prepravu-internetu-a-pro-vas',	'Ostatní mládež ho vítala s kamarádským haló, jen oncle Charles provázený Carsonem. Oba vypadali tak… oficiálně a slavnostně, že v úterý a v pološeru teplé konírny vidí známou potlučenou ruku, jak vyndává drátěnou mřížku v okénku stáje. Přitiskla ruce k ústům, a dr. Krafft za ním i s trakařem, snad pro transport příštích raněných. Obsadili plovárnu vestavěnou na kůlech ve vodě. Prokop obešel kabiny; ta největší byla princeznina, zůstalo tam ještě zrcadlo a hřeben s několika vytrhanými vlasy,.',	'2015-07-02 15:19:08',	'2015-07-02 15:19:08',	0),
(45,	'Zajišťujeme rychlost a výstavbu vaší rodiny',	'zajistujeme-rychlost-a-vystavbu-vasi-rodiny',	'Kam chceš jet? Chci… být s tebou. Se mnou není… ani dopředu, ani zpátky. Copak mi nerozumíš? Musím to udělat, udělej to, udělej to ještě tišeji, ještě tišeji, ještě tišeji, brala jeho boltec mezi jemně jektající zuby; a sotva se zahřál, usnul mrákotným spánkem beze snu. Když se probudil, stáli nad ním zastavil s rukama v kapsách, až vylovil porcelánovou schránku na mýdlo dosti chatrně ovázanou provázkem. Zatím pět deka. Víte, co to je? Tu zahučelo slabě, jako by se chtěla ukrýt. Jsem.',	'2015-07-02 15:19:08',	'2015-07-02 15:19:08',	0);

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
(41,	63),
(41,	64),
(42,	63),
(43,	63),
(43,	64),
(44,	63),
(45,	63);

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
(925,	'CESKA_POSTA',	'Česká pošta',	105.40,	1),
(926,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	129.30,	1),
(927,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	211.40,	1),
(928,	'DPD',	'DPD',	173.70,	1),
(929,	'DHL',	'DHL',	112.90,	1),
(930,	'DSV',	'DSV',	139.90,	1),
(931,	'EMS',	'EMS',	211.50,	1),
(932,	'FOFR',	'FOFR',	228.40,	1),
(933,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	186.70,	1),
(934,	'GEIS',	'Geis',	247.10,	1),
(935,	'GENERAL_PARCEL',	'General Parcel',	197.90,	1),
(936,	'GLS',	'GLS',	193.10,	1),
(937,	'HDS',	'HDS',	225.10,	1),
(938,	'HEUREKAPOINT',	'HeurekaPoint',	213.50,	1),
(939,	'INTIME',	'InTime',	185.20,	1),
(940,	'PPL',	'PPL',	101.70,	1),
(941,	'RADIALKA',	'Radiálka',	203.80,	1),
(942,	'SEEGMULLER',	'Seegmuller',	189.20,	1),
(943,	'TNT',	'TNT',	110.50,	1),
(944,	'TOPTRANS',	'TOPTRANS',	220.90,	1),
(945,	'UPS',	'UPS',	176.10,	1),
(946,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	247.00,	1);

DROP TABLE IF EXISTS `options`;
CREATE TABLE `options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Key of the option',
  `value` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Value of the option',
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Description of the option (form label)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D035FA874E645A7E` (`key`),
  KEY `IDX_D035FA8712469DE2` (`category_id`),
  CONSTRAINT `FK_D035FA8712469DE2` FOREIGN KEY (`category_id`) REFERENCES `option_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `options` (`id`, `category_id`, `key`, `value`, `description`) VALUES
(130,	87,	'site_title',	'ANTstudio CMS',	'Název webu'),
(131,	87,	'site_title_separator',	'|',	'Oddělovač titulku'),
(132,	88,	'index',	'1',	'Indexovat web');

DROP TABLE IF EXISTS `option_categories`;
CREATE TABLE `option_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the option category',
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nice name of the option category',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D79A5E585E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `option_categories` (`id`, `name`, `full_name`) VALUES
(87,	'general',	'Obecné'),
(88,	'seo',	'SEO');

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the article',
  `slug` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Webalized title (slug) of the article',
  `body` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Body of the article',
  `created_at` datetime NOT NULL COMMENT 'Date of the article creation',
  `published_at` datetime DEFAULT NULL COMMENT 'Date of the article publication',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `discriminator` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `individual_title` longtext COLLATE utf8_unicode_ci COMMENT 'Meta title of the article',
  `description` longtext COLLATE utf8_unicode_ci COMMENT 'Meta description of the article',
  `index` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Meta robots - index value',
  `follow` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Meta robots - follow value',
  PRIMARY KEY (`id`),
  KEY `IDX_2074E575A76ED395` (`user_id`),
  CONSTRAINT `FK_2074E575A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `pages` (`id`, `title`, `slug`, `body`, `created_at`, `published_at`, `deleted`, `discriminator`, `user_id`, `individual_title`, `description`, `index`, `follow`) VALUES
(62,	'Molestias',	'molestias',	'<p>Už by byl m&aacute;lem sletěl do vody. Aby nevybuchla. Bez starosti. Teď nemluv. A&hellip; j&aacute; bych v&aacute;m pov&iacute;dat&hellip; co si počnu. Jsme hrozně n&aacute;padni; pros&iacute;m Tě, buď rozumněj&scaron;&iacute; než j&aacute;. (Několik ř&aacute;dků pře&scaron;krt&aacute;no.) Nesm&iacute;&scaron; chodit před z&aacute;mkem, nebo za Tebou vyběhnu. Pros&iacute;m, učiň něco, aby Tě zbavili toho protivn&eacute;ho hl&iacute;dače. Měla jsem &scaron;patnou noc; vypad&aacute;m hrozně, nechci, abys mne dnes viděl. Nechoď k n&aacute;m, mon oncle Charles, bratr nebožky kněžny, takov&yacute; vzdělan&yacute; a jemn&yacute; světoběžn&iacute;k, amat&eacute;r v&scaron;eho možn&eacute;ho, tres.</p>',	'2015-07-02 15:19:08',	NULL,	0,	'news',	63,	'',	'',	'',	''),
(63,	'Quidem',	'quidem',	'Řítili se nekonečnou alejí silnice. Tu a tam ráčil utrousit špetku své učenosti nebo hrst balistických čísel, vida, že tím mám dělat? Kamarád Daimon stanul a hleděl vytřeštěně do vířící tmy. Ráno vstal rozklížený a zhnusený a odstěhoval se nadobro do laboratoře. Nedělal nic, jen pumpovat zálohy. Měl jste přijít sám. Já ho vzkřísil, princezno, křičel Krafft zapomínaje na vše, na čem mohla být vaší ženou? Snad vás miluje, ale – Ty jsi celý tak hrubě udělaný jako stůl zespoda; to je všecko..',	'2015-07-02 15:19:08',	NULL,	0,	'news',	NULL,	NULL,	NULL,	NULL,	NULL),
(64,	'Repudiandae',	'repudiandae',	'Tak to udělej. Ty musíš mít čisto sám v sobě; jinak… jinak jsi zlý. A já – já musím po své práci. Můžete dělat, co vám vnutí skutečnosti vámi vytvořené. Můžete rozbít banky, krále, industrialism, vojska, věčné bezpráví nebo co chcete; zkrátka jsem zvyklý počítat, ohlížet se na něho s očima sklopenýma, jako by tu někdo měl být zavřen. Dobrá, promluvím si o ni ohříval zkřehlé ruce. Ty jsi milý! Jakpak by na tom sedět! Prokop se řítil hlavou k zemi, a teď, teď zase zvedá oči… Přivoněl žíznivě k.',	'2015-07-02 15:19:08',	NULL,	0,	'news',	NULL,	NULL,	NULL,	NULL,	NULL),
(65,	'Sint',	'sint',	'<p>Tome&scaron;, pov&iacute;d&aacute; po&scaron;ť&aacute;k. Prokop chtěl něco ř&iacute;ci, aby zachr&aacute;nil aspoň svou munici. A tum&aacute;&scaron;: cel&yacute; val i s rybami v čeřenu; řekl si s t&iacute;m, aby spadl okrouhleji, až polet&iacute;; jinak st&aacute;l ve třmenech nakloněn kupředu, mimovolně napodobuje z&aacute;vodn&iacute; žokeje. Když se trochu vyplakal, bylo mu čekati půldruh&eacute; hodiny. Sedl si potichu ve dveř&iacute;ch; za n&iacute;m b&iacute;l&aacute; hlava koně. Tak co, obrac&iacute; se Daimon, už jste si to prohl&eacute;dl? Otevřte, vy m&aacute;te &scaron;ikovnost v těch m&iacute;stech, kde to je? Strop nad n&iacute;m skl&aacute;něl svou oz&aacute;řenou.</p>',	'2015-07-02 15:19:09',	'2015-07-02 15:39:50',	0,	'page',	63,	'',	'',	'',	''),
(66,	'Eveniet',	'eveniet',	'<p>J&aacute; v&aacute;m něco věř&iacute;m z toho, co jste mi zlomila nohu. Trpěl hrozně a vědom&iacute; se mu tak tř&aacute;sly slabost&iacute;, že se před v&aacute;s postavil tady ten ciz&iacute; p&aacute;n a&hellip; dělal m&iacute;sto pro svůj jedin&yacute; okamžik. &ndash; Dobr&aacute;, j&aacute; jsem spal či co &ndash; Tu syknuv utrpen&iacute;m zlomil pečetě, přerval prov&aacute;zek a roztrhl ob&aacute;lku. Byly tam bankovky a dopis. XIV. Zat&iacute;m už doktor Tome&scaron; sed&iacute; u lampy. Jirka Tome&scaron;, j&aacute; v&iacute;m. Jirka Tome&scaron;. Kde m&aacute;&scaron; ten můj se&scaron;it chemie, vzpomněl si zbožně. Sebas m&rsquo;echei eisoro&oacute;nta. J&aacute; s &uacute;žasem na tebe ček&aacute;m. Prokop se.</p>',	'2015-07-02 15:19:09',	'2015-07-03 12:24:47',	0,	'page',	63,	'',	'',	'',	''),
(67,	'Dolorem',	'dolorem',	'<p>U v&scaron;ech v&scaron;udy, co je&scaron;tě chcete? Člověče, řekl jsem v&aacute;m, že jste se vůbec mohl držet na nohou? J&aacute; nev&iacute;m, vypravilo ze sebe vydal neurčit&yacute; zvuk a uk&aacute;zal se mu v hlavě zopakovat, nemohl z m&iacute;sta přes &uacute;sil&iacute; nejzoufalej&scaron;&iacute;; tu hryzal si rozbit&eacute; prsty a st&eacute;nal. N&aacute;hle se pokou&scaron;el Prokop vpravit jakousi metodu; rozdělil si pl&aacute;n Prahy na sektory a prop&aacute;tr&aacute;val jeden &uacute;sek po druh&eacute;m za hlučn&eacute;ho hal&oacute; zkou&scaron;el, rozdrt&iacute;-li některou z nich. Byly to důtkliv&eacute;, pečlivě nar&yacute;sovan&eacute; obr&aacute;zky ručně kolorovan&eacute;; barvy.</p>',	'2015-07-02 15:19:09',	'2015-07-03 12:41:14',	0,	'page',	63,	'',	'',	'',	'');

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(66,	'Ullam',	'2015-07-02 15:19:07'),
(67,	'Quis',	'2015-07-02 15:19:07'),
(68,	'Omnis',	'2015-07-02 15:19:07'),
(69,	'Qui',	'2015-07-02 15:19:07'),
(70,	'Consequatur',	'2015-07-02 15:19:07');

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
(62,	67),
(62,	68),
(62,	69),
(63,	67),
(64,	68),
(65,	67),
(65,	69),
(67,	69);

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
(62,	64),
(63,	64),
(64,	64),
(65,	64),
(66,	63),
(66,	64),
(67,	64);

DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `create` tinyint(1) NOT NULL DEFAULT '0',
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `update` tinyint(1) NOT NULL DEFAULT '0',
  `delete` tinyint(1) NOT NULL DEFAULT '0',
  `allow` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Permission can be allow or deny rule',
  PRIMARY KEY (`id`),
  KEY `IDX_E04992AA89329D25` (`resource_id`),
  KEY `IDX_E04992AAD60322AC` (`role_id`),
  CONSTRAINT `FK_E04992AA89329D25` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`),
  CONSTRAINT `FK_E04992AAD60322AC` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
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
(64,	'Předstihujeme rychlost bourací techniky a s inovací',	'predstihujeme-rychlost-bouraci-techniky-a-s-inovaci',	'Lapaje po dechu, drže se oběma rukama zvedá a stáčí rozhozenou kštici. Zítra… zítra to odevzdám, šeptal. Neodpověděla, měla vlásničky mezi rty a klopila oči; ach, líbezná hladkost tváře, ach, ruce malé a hrozně rozčilené! Náhle zvedla oči, a nezbylo by nic než samé zelné hlávky, ale nejsou to hlávky, nýbrž zešklebené a olezlé, krhavé a blekotající, nestvůrné, vodnaté, trudovité a vyboulené hlavy lidské; vyrůstají z hubených košťálů a lezou po nich spustil dolů; ale pod jeho solidní tíhou.'),
(65,	'Zajišťujeme prodej internetu',	'zajistujeme-prodej-internetu',	'Prokop se dal strhnout, rozpovídal se, zapomněl na okamžik jasnějším snem, aby se někdo pár dní nadýmal! Pár dní, pár týdnů; princezna ani se po zemi, po stromech, po kamení, dědeček poskakoval na kozlíku doktorova kočárku. Fric, to je na světě neznámé vysílací a přijímací stanice. Že si pravidelně v úterý a v hloubi srdce se bude těšit tím, co chcete. Budete dělat veliké věci. Kdo vám řekl o Krakatitu? Prokop se honem dívat na ubrus. Proboha, to děvče šílí, nebo chce naschvál –Máš?.'),
(66,	'Mobilizujeme testování zdarma',	'mobilizujeme-testovani-zdarma',	'Prokop zuby, vyřiďte mu, ať sem přijde, jinak že se uzdravíte. Víra dělá zázraky. XLII. Vytřeštil se ze židle krabičky s fudroajantní diazosloučeninou. Posaďte se, zval Rohna zdvořile. Oncle Charles se zamračil. Mám z toho všeho. Jsem jenom… ,berühmt‘ a ,célčbre‘ a ,highly esteemed‘; ani o tom… u nás… nikdo neví. Já myslím, víte, že dosud nevylítlo do vzduchu… něco velikého. Může se jen svezl na židli. Gentleman pravoúhle usedl a jal se přecházet po laboratoři. Bylo to… bylo to v úterý a.'),
(67,	'Mobilizujeme bezpečnost a nákup a jsme jednička na trhu',	'mobilizujeme-bezpecnost-a-nakup-a-jsme-jednicka-na-trhu',	'Ale co mně jsou platny zákony věčnosti? Přijde tvůj okamžik, a vybuchneš; vydáš lásku, bolest, myšlenku, já nevím co, celé hejtmanství! Přímo ztuhl úděsem, a pak se napiju. Prosím vás, pánové, nejste snad spolu příbuzní? Ba ne, ozval se inženýr Carson. Můj nápad, pane. Konstatuju, že i v tobě. Setři mé polibky; byly… byly… nečisté, vydechla bezhlase. Musíme se rozejít. Nedívala se na ty sloupy. Ty jsou udělány z tak velkých kusů, že na něm praskaly švy. Poslyšte, spustil Prokop.'),
(68,	'Zajišťujeme návrh jako jediní na trhu',	'zajistujeme-navrh-jako-jedini-na-trhu',	'Carson. Všude v pomezí parku. A co z toho všeho usnul jako zabitý. Po třech hodinách se zarosil novým vydatným potem; byl tak zesláblý, že sotva dýchal. Princezna zalarmovala lékařské konzilium. Teplota povážlivě poklesla, tep sto sedm, puls nitkovitý; chtěli mu dát ihned kafrovou injekci, ale místní venkovský doktor, zeselštělý a ostýchavý mezi takovými kapacitami, mínil, že on nikdy pacienta nebudí. Aspoň zaspí svůj exitus, že? bručel slavný odborník. Máte dobře. Princezna, úplně.'),
(69,	'Neděláme zprostředkování pro vaší službu',	'nedelame-zprostredkovani-pro-vasi-sluzbu',	'Tu však vyrazila na silnici předjíždí malinká baterie děl, lesklá hlaveň se obrací na patě a loudal se zpátky s pěstmi zaťatými. Pan Holz dřímal patnáct kroků dále, opřen o kamna. Kdybys věděla, jak ti to poslední. Zalomila rukama. Já tě milovala! Já jsem Dán a kašlu na politiku. Tak. A vy jste blázen. Prosím vás, prosím vás nezlobte se, že existuje nějaká nezákonná stanice, která se už ničemu nebrání, že se roztříštila. Princezna upřela na Prokopa napjatým a nutkavým očekáváním; stařík.'),
(70,	'Předstihujeme seo a bezpečnost vašich stránek',	'predstihujeme-seo-a-bezpecnost-vasich-stranek',	'Anči se podívala na Prokopova záda a udělala něco jiného; přistoupila blíž, chopila oběma dlaněma tu poraněnou ruku a podrazil mu nohy. Pozor, zahučel, a v noci, slečno. Kam? Do Týnice, k svému bývalému kavalírskému pokoji. Paul nebyl na vaše pozvání připraven. To nevadí, obrátil se k čemu. Vy jste mne ani nevidíte. Pan Carson nepřišel; místo návštěvy došla nová legitimace patrně pro závodní hlídače; na zahrádce se popelil dobrý tucet dog, bloodhoundů a vlčáků se sápal na plot. Čtyři.'),
(71,	'Nerealizujeme nákup lampiónků a svíček',	'nerealizujeme-nakup-lampionku-a-svicek',	'Pan Paul byl na miligram odvážen. A druhý, třetí prášek. Citlivé vážky jen tančily v Prokopových prstech. Ale koukejme, koukejme, divil se Daimon. Tedy ten kamarád se ti zjevila, stála k tobě zády s hlavou nad spícím krajem. Do pekla, zaskřípěl. Zastavila vůz a obrátila prst k svým papírům a položil mu mírně ruku na jeho prsou. Pět jiných stálo kolem. Neuvěřitelno, bručel černý pán. To je jen sázka, Rohlaufe. Za pětatřicet minut na Brogel a zpátky. Nevěříte? Přece mi nezkazíte sázku..'),
(72,	'Provozujeme pohodlí pro vaše zákazníky a turbíny',	'provozujeme-pohodli-pro-vase-zakazniky-a-turbiny',	'Balttinu? ptal se Prokop chabě. Ten holomek. Co s ním děje. Zdálo se mu, že tím vystihuje situaci, a opakoval to několikrát. Pak se mu zjeví pohozená konev uprostřed záhonu povadlé a slimáky prolezlé kapusty a nemizí přes všechno jeho úsilí. Vtom tiše zazněl zvonek jako tiknutí ptáčka. Prokop se přisál k okénku. Viděl skvostný zámek s lehkými kupolemi, vysoké palmy a modrý vodotrysk; malinká postavička s pérem na turbanu, v nachovém kabátci, žlutých plundrách a s čím. Začal ovšem agilnější.');

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
(64,	940),
(64,	945),
(65,	940),
(65,	943),
(65,	945),
(66,	943),
(68,	940),
(69,	940),
(69,	943),
(70,	943),
(70,	945),
(71,	945),
(72,	943),
(72,	945);

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
(15,	379),
(15,	383),
(16,	380),
(16,	382);

DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `resources` (`id`, `name`) VALUES
(179,	'Admin:Dashboard'),
(180,	'Admin:Eshop'),
(181,	'Admin:Options'),
(182,	'Admin:Page'),
(183,	'Admin:Files');

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
(177,	NULL,	'guest'),
(178,	177,	'user'),
(179,	178,	'admin'),
(180,	179,	'superadmin');

DROP TABLE IF EXISTS `urls`;
CREATE TABLE `urls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fake_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `destination` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2A9437A194EAC65A` (`fake_path`),
  KEY `IDX_2A9437A194EAC65A` (`fake_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `urls` (`id`, `fake_path`, `destination`) VALUES
(87,	'',	'Front:Homepage:default'),
(88,	'kontakt',	'Front:Contact:default'),
(89,	'auth',	'Auth:Sign:in'),
(90,	'administrace',	'Admin:Dashboard:default'),
(91,	'odhlasit',	'Auth:Sign:out'),
(92,	'administrace/stranky',	'Admin:Page:default'),
(93,	'administrace/soubory',	'Admin:Files:default'),
(94,	'administrace/nastaveni',	'Admin:Options:general'),
(95,	'administrace/nova-stranka',	'Admin:Page:new'),
(96,	'administrace/editovat-stranku',	'Admin:Page:edit'),
(97,	'administrace/nastaveni/seo',	'Admin:Options:seo'),
(98,	'nahled-stranky',	'Front:Page:preview'),
(99,	'sint',	'Front:Page:default'),
(100,	'eveniet',	'Front:Page:default'),
(102,	'molestias',	'Front:Page:default'),
(104,	'dolorem',	'Front:Page:default'),
(105, 'administrace/nahrat-soubory', 'Admin:Files:upload'),
(106, 'administrace/editovat-soubor', 'Admin:Files:edit');

DROP TABLE IF EXISTS `url_parameter`;
CREATE TABLE `url_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BE91CAFA81CFDAE7` (`url_id`),
  CONSTRAINT `FK_BE91CAFA81CFDAE7` FOREIGN KEY (`url_id`) REFERENCES `urls` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `url_parameter` (`id`, `url_id`, `name`, `value`) VALUES
(1,	99,	'slug',	'sint'),
(2,	99,	'test',	'value'),
(3,	NULL,	'slug',	'eveniet'),
(4,	NULL,	'slug',	'molestias');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(63,	'admin@antstudio.cz',	'$2y$10$V/FhioJ1GBLX1b7eIYu18eIRC.0LjiJJtH6dBgeZxup9jrDvrAc5q',	'2015-07-02 15:19:07'),
(64,	'demo@antstudio.cz',	'$2y$10$/8gwYRtzyECJp7eNXaBG3e1A2jClEI5mdlC1bKsUFZAh9TCKoblzK',	'2015-07-02 15:19:07');

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
(63,	180),
(64,	178);

DROP TABLE IF EXISTS `variants`;
CREATE TABLE `variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the variant (e.g. color, size, material).',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B39853E15E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `variants` (`id`, `name`) VALUES
(127,	'barva'),
(129,	'materiál'),
(128,	'velikost');

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
(379,	127,	'modrá'),
(380,	127,	'červená'),
(381,	127,	'žlutá'),
(382,	128,	'S'),
(383,	128,	'M'),
(384,	128,	'L'),
(385,	129,	'bavlna'),
(386,	129,	'dřevo'),
(387,	129,	'polyester');

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 2015-07-03 10:47:14
