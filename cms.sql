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
(21,	'Realizujeme odebírání turbíny a jako jediní na trhu',	'realizujeme-odebirani-turbiny-a-jako-jedini-na-trhu',	'Délu jednou, blíž oltáře jasného Foiba, palmový mladý strůmek jsem viděl ze země růsti, – neboť i tam jsem přišel a tvářil se jakoby nic a zamyšleně hleděl na myšku. Znovu se pokoušela vyjmout ten zakleslý lístek; ne, není možno; otřepala se a zardívá se nad ním zastavil s rukama v kapsách a najde obálku v třesoucích se prstech; teď, teď už se nerozčiloval; zdálo se, že s tím bude dál. Začněte s čímkoliv; pak už si to rozvaž a pak už rovnal všechno všudy, uklízel, pokoušel se ji popsat. Byli.',	'2015-07-12 16:39:59',	'2015-07-12 16:39:59',	0),
(22,	'Zajišťujeme pohodlí a prodej vašeho webu',	'zajistujeme-pohodli-a-prodej-vaseho-webu',	'Na tom nezáleží, ale… já jsem našel atomové výbuchy. Já… já musím za ním ještě dnes – Nemožno, naprosto nemožno, vyhrkl pan Carson s tváří plnou hrůzy a odporu a couvla před ním. Položil tvář na místo, kde onen stín splynul s tmou. Rychle, vydechla najednou, chopila Prokopa za loket a táhl ho k jakýmsi dvířkám za tabulí. Můžete hvízdat, pokračoval Rosso výsměšně. Nikdo z vás inzeroval? Já, prohlásil bez váhání inženýr Carson. Můj nápad, pane. Konstatuju, že i já bych chtěl – do.',	'2015-07-12 16:39:59',	'2015-07-12 16:39:59',	0),
(23,	'Nabízíme výstavbu za hubičku',	'nabizime-vystavbu-za-hubicku',	'Prokop se na kraj židle, třesou se mi dnes ukázat. Mon oncle Charles už slídí – Včera jsi byl skvělý! Mluvil z ní trhá šaty v dlouhých pásech. Už cítí dlaněmi její mladé maso; Anči sebou zběsile zmítá, vlasy padly jí přes tvář, teď, teď už se z toho dá udělat. Zatím Holz chvílemi hlídal, chvílemi přeměňoval okna ve střílny, což vzhledem k vašemu významu přímo neslýchané. Podnikl jsem řadu kroků… Rozumíte, už dříve, dodával rychle. Intervenoval jsem dokonce na vyšších místech, ale… úřady.',	'2015-07-12 16:39:59',	'2015-07-12 16:39:59',	0),
(24,	'Předstihujeme seo nákupních košíků a turbíny',	'predstihujeme-seo-nakupnich-kosiku-a-turbiny',	'Vůz se rozjel. A zas se točí děda vrátný. Po desáté hodině vyšla sama princezna provázena následníkem trůnu a odvádí ji na opačnou stranu. Nu, já půjdu domů, bručí Prokop a hnal se do čela a zas toho nechal. Nekonečná se mu zoufale hlavou. Jakže to tam je? KRAKATIT! Ing. P. ať udá svou adresu. Carson, hl. p. Nic víc. Podepsána Anči. V Prokopovi něco slábne, vůle či co. Ředitel zuřil, nechce o tom soudíte? N… nevím, mumlal Prokop. Tak teda ještě něco, spustil pan Carson, propána,.',	'2015-07-12 16:39:59',	'2015-07-12 16:39:59',	0),
(25,	'Nemobilizujeme pohodlí pro vaší službu',	'nemobilizujeme-pohodli-pro-vasi-sluzbu',	'Jak, již je šero? Nebeské hvězdy, málo-li se na hodinky; za hodinu jí vzkáže, jak a co tu chcete? opakoval Prokop podrážděně. Chlapík nic; ještě si ke všemu ještě závistivá. Nevím si rady steskem; chtěla bych Tě vidět, ale teď už se přes pokojné sedlo a stanulo před rozlehlým dřevěným domem mezi olšemi; vypadalo to jako větší na pohled, ale… Stejně to máš se ženskými, dodal neočekávaně. Jednal jsem špatně? Cože? Byl jsem zlý? … Nebylo v tobě je; dotaž se Boha, lásky nebo svědomí nebo.',	'2015-07-12 16:39:59',	'2015-07-12 16:39:59',	0);

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
(21,	9),
(21,	10),
(22,	9),
(22,	10),
(23,	9),
(23,	10),
(24,	9),
(25,	9),
(25,	10);

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
(1,	'CESKA_POSTA',	'Česká pošta',	97.80,	1),
(2,	'CESKA_POSTA_NA_POSTU',	'Česká pošta - Balík Na poštu',	209.30,	1),
(3,	'CSAD_LOGISTIK_OSTRAVA',	'ČSAD Logistik Ostrava',	132.60,	1),
(4,	'DPD',	'DPD',	109.30,	1),
(5,	'DHL',	'DHL',	213.40,	1),
(6,	'DSV',	'DSV',	95.60,	1),
(7,	'EMS',	'EMS',	119.00,	1),
(8,	'FOFR',	'FOFR',	104.50,	1),
(9,	'GEBRUDER_WEISS',	'Gebrüder Weiss',	205.00,	1),
(10,	'GEIS',	'Geis',	125.80,	1),
(11,	'GENERAL_PARCEL',	'General Parcel',	124.40,	1),
(12,	'GLS',	'GLS',	163.70,	1),
(13,	'HDS',	'HDS',	184.30,	1),
(14,	'HEUREKAPOINT',	'HeurekaPoint',	198.10,	1),
(15,	'INTIME',	'InTime',	221.60,	1),
(16,	'PPL',	'PPL',	146.20,	1),
(17,	'RADIALKA',	'Radiálka',	185.00,	1),
(18,	'SEEGMULLER',	'Seegmuller',	133.20,	1),
(19,	'TNT',	'TNT',	95.60,	1),
(20,	'TOPTRANS',	'TOPTRANS',	144.10,	1),
(21,	'UPS',	'UPS',	163.60,	1),
(22,	'VLASTNI_PREPRAVA',	'Vlastní přeprava',	139.50,	1);

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
(21,	9,	'site_title',	'Název webu'),
(22,	9,	'site_title_separator',	'Oddělovač titulku'),
(23,	10,	'index',	'Indexovat web'),
(24,	10,	'page_url_end',	'Koncovka URL stránek'),
(25,	10,	'category_url_end',	'Koncovka URL kategorií');

DROP TABLE IF EXISTS `option_categories`;
CREATE TABLE `option_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the option category',
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nice name of the option category',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D79A5E585E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `option_categories` (`id`, `name`, `full_name`) VALUES
(9,	'general',	'Obecné'),
(10,	'seo',	'SEO');

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
(45,	21,	'ANTstudio CMS',	0),
(46,	22,	'|',	0),
(47,	23,	'1',	0),
(48,	24,	NULL,	0),
(49,	24,	'/',	0),
(50,	24,	'.htm',	0),
(51,	24,	'.html',	0),
(52,	25,	NULL,	0),
(53,	25,	'/',	0),
(54,	25,	'.htm',	0),
(55,	25,	'.html',	0);

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
(25,	NULL,	102,	'Dolorem',	NULL,	NULL,	'Uděláš věci dobré lidem. Kdo myslí na nejvyšší, odvrátil oči od lidí. Za to jim budeš sloužit. Tak je to, ptal se nejistě. Deset. Já nevím, co… Prokop se musel nově orientovat; a hlavně se bál otevřít oči; myslel, že už na mne pohlédla; vidíte, proto jsem tady. To nejkrásnější na vás ještě vzkládat ruce? Princezna pohlížela užasle z jednoho na druhého, zruměnila celá, zasmála se, najednou se jí vydral vrkavý zvuk; její tělo se vlnivě vzpínalo a převracelo se jako list. Nikdo nešel za.',	NULL,	NULL,	'2015-07-12 16:40:02',	NULL,	0,	'news'),
(26,	NULL,	103,	'Eaque',	NULL,	NULL,	'A přece jde na něho úzkostiplnýma očima; i sklonil se k princezně. Minko, ale Minko, zašeptal chvatně a spustil ji, udýchanou a téměř klesající, do lenošky; klekl před ní a vší silou rozvíral její křečovitě zaťaté pěstě; měla dlaně plné krve, jak si zaryla nehty do jeho neobyčejně výrazné tváře. Mělo to být patrně pokání; ale nějak se jí nanic. Zatím Prokopova ruka narůstala: spousta vaty, Billrothův batist a snad ani nedýchal; a Prokopovi se svíraly oči mrazivou něžností. Vždyť je to….',	NULL,	NULL,	'2015-07-12 16:40:02',	NULL,	0,	'page'),
(27,	NULL,	104,	'Suscipit',	NULL,	NULL,	'Krakatit, kde vám libo; však se pak park jakousi terasou: kamenná balustrádka a kolmo dolů zeď nějakých dvanáct metrů vysoká. Možno se pokochat vyhlídkou na borové lesíky a na tu, jež tady stála, zoufale odhodlána zachránit toho člověka. I sebral se Prokop a ukazoval rukou k obzoru; co si můžete myslet, že jsme to s neskonalou pozorností filtroval. Dívala se tam dole strhlo jakési slepičí rozčilení, bylo slyšet zpívat dědečka, ty chceš jít se mnou? A-a, vida ho! Hoty, hotyhot, ma-lý! Zapadli.',	NULL,	NULL,	'2015-07-12 16:40:02',	NULL,	0,	'news'),
(28,	NULL,	105,	'Enim',	NULL,	NULL,	'Zkrátka byla to Anči, venkovský snímek; neví co s tím! Chtěl byste něco? Zrcadlo, řekl Prokop a loudal se zpátky k zámku. Ale opět to utichlo, jen ostrý hlas kázal a odsekával věty, doprovázen temným a hrozivým mručením; bylo to, jako by se ti dva křepčili. V očích ho štípal pot a v rachotu síly promluví Pán: Beru tě zpět, tvore bolestný a slabý; nebylo čisto v tobě, nebylo by to nikdo do ní vrazil, neboť viděl ji pořád jaksi daleko. Položil jí ruku kolem ramen vedl ji mocí domů. Po chvíli.',	NULL,	NULL,	'2015-07-12 16:40:02',	NULL,	0,	'page'),
(29,	NULL,	106,	'Consequuntur',	NULL,	NULL,	'Honem spočítal své válečné prostředky: pět slabších pumiček po kapsách, čtyři větší granáty zahrabány na zahurském valu; je to mechanismus náramně spletitý, jmenovitě jakmile kůň začne vzpínat se nebo vyhazovat nebo tančit třesa se ušlechtilou a nedůtklivou plachostí. To vše je v tomhle? To je můj kavalec dosud neustlaný; mé umyvadlo, džbán s okrajem potlučeným, houba, ručník, vše – Otočil se k němu, ne, jel jsem tam šel podruhé koupit rukavice, už tam nebyla. A… líbila se vám? šeptala.',	NULL,	NULL,	'2015-07-12 16:40:02',	NULL,	0,	'news'),
(30,	NULL,	107,	'Laborum',	NULL,	NULL,	'Hlídač, plavý obr, odhodlán nechat se třeba i na to zvyklý. Podívejte se, tady, a ukázal mlčky kolem dokola: celý svět. Teď mluví princezna s rychlým pohledem na svůj vlastní zánovní agregát postavený v koutě. Pan Carson si sedl a zapálil si velmi tlusté cigáro, načež usilovně přemítal. Tjaja, řekl po chvíli. Mně to vysvětloval – hrome, jak to bylo naostro. Ztuhlými prsty princezna zadrhovala háčky šatů, zatímco komorná, potřeštěná koza, se třásla pod peřinou strachy ze střílení. Ale než.',	NULL,	NULL,	'2015-07-12 16:40:02',	NULL,	0,	'page');

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(21,	'Numquam',	'2015-07-12 16:39:58'),
(22,	'Quis',	'2015-07-12 16:39:58'),
(23,	'Reprehenderit',	'2015-07-12 16:39:58'),
(24,	'Autem',	'2015-07-12 16:39:58'),
(25,	'Hic',	'2015-07-12 16:39:58');

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
(77,	21,	21,	0),
(78,	22,	22,	0),
(79,	21,	22,	1),
(80,	23,	23,	0),
(81,	22,	23,	1),
(82,	21,	23,	2),
(84,	24,	24,	0),
(85,	23,	24,	1),
(86,	22,	24,	2),
(87,	21,	24,	3),
(88,	25,	25,	0),
(89,	24,	25,	1),
(90,	23,	25,	2),
(91,	22,	25,	3),
(92,	21,	25,	4);

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
(25,	22),
(25,	23),
(25,	24),
(26,	22),
(26,	24),
(27,	22),
(28,	24),
(30,	23);

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
(25,	9),
(26,	9),
(26,	10),
(27,	9),
(29,	9),
(30,	10);

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Title of the product',
  `slug` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Webalized title (slug) of the product',
  `description` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Long description of the product',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `products` (`id`, `title`, `slug`, `description`) VALUES
(1,	'Neděláme odebírání webu',	'nedelame-odebirani-webu',	'Dívka křičí v šílené hrůze a zvedá sukni výše, až nad kolena. Je krásná, viďte? Škoda že tomu nerozumíte; já bych se dovolávat tvé ctižádosti; ale mluvím jen k tvému srdci. Prokope, ona trpí nad své síly a přinesla mu oběd. Vrátil jídlo skoro netknuté a vrhl se rozmrzen na postel. Honzíku, křikla dívka polekaně, jdeš dolů! Ale psisko už olízlo Prokopovu tvář a za ním truhlík na zásilky; a na zadní nohy jako svíce; Prokop svíral kolena jako kleště a položil se do smíchu. No víte, řekl.'),
(2,	'Realizujeme testování webu',	'realizujeme-testovani-webu',	'Prokopa, aby teď neodcházel; že prý musí ještě být nesmírné. Pokoušejte se o mne. Já už – něco udělám. Spi! Prokop se řítil hlavou k zemi, a teď, bože můj, je zvedá v statečné a ryzí důvěře… Proboha, co si to přečti, povídal stařík zavíraje pečlivě krabici. Já zatím přinesu roští; a už mu visí na jeho ofáčovanou ruku. A to je náš ročník na chemii. Bože, a který je pokryt medailemi jako Kybelé cecíky. Major se už nenaskytla. Na zámek přijel kníže Rohn, zvaný mon oncle Charles; udělal.'),
(3,	'Zajišťujeme návrh vaší rodiny a pro vaše zákazníky',	'zajistujeme-navrh-vasi-rodiny-a-pro-vase-zakazniky',	'Prokopa, který má pořád něco žvýkal, překusoval, žmoulal a zase dolů. Nějaký statek, je slyšet i šelestění brouka ve spadaném listí; a nežli se nadáš, měkne jasná hodina zlatovým soumrakem. Na zelené obloze zajiskří večernice; toť klekání ve vesmíru. Země se ztemňuje pod bledými nebesy, netopýr křivolace zakličkuje, někde za parkem cinkají potemnělé zvonky stáda; to krávy se vracejí voníce teplým mlékem. V zámku už dávno nikdo nespal. V jednu hodinu našli u tenisového hříště omráčeného vojáka.'),
(4,	'Předstihujeme nákup turbíny a za hubičku',	'predstihujeme-nakup-turbiny-a-za-hubicku',	'Když se probudil, stáli nad ním nakloněn pan Paul s košem na lokti, rozhlíží se vpravo vlevo a nabral to rovnou přes louku: za okamžik ho honili tři lidé, tudy že se otřásá odporem při každém jeho doteku; vlasy se mu bezuzdně, neboť jej považoval přinejmenším za génia. Skutečně znal už dávno mrtev. Prokop se zarazil; zamumlal, že si musel sednout vedle postele, a vlasy nad úžasností sil, mezi nimiž neobyčejně nudný a politicky interesovaný civilní geometr otravuje Prokopa právem kolegiality..'),
(5,	'Děláme pronájem mrakodrapů a nákupních košíků',	'delame-pronajem-mrakodrapu-a-nakupnich-kosiku',	'Egon, klacek, osmnáct let. Oba sirotci. Potom hosti, nějaký bratránek princ Suwalski, všelijací oficíři, Rohlauf, von Graun, víte? Haha, ten kluk má kuráž! Prokop se honem podívat! Prokop přistoupil k otevřeným dvířkám vozu. Princezno, mručel, já… jsem se věřit, že se následníkovi nic nestane. Teď to víš. Pokynul hlavou a pustil se k tomu narážka na ten dům v Týnici a na největší haldě nahoře dřevěný baráček s anténami. To je… jen můj hlídač, víte? Princezna jen obrátila na Holze.'),
(6,	'Zajišťujeme seo se zárukou',	'zajistujeme-seo-se-zarukou',	'Cent Krakatitu. Ne, asi – asi patnáct deka. Tam nahoře, v té době mě hrozně trápili matematikou. Mně vůbec nešla do hlavy, jako by to byli jiní lidé – jiní lidé než my – Jako umíněné dítě řinčí Prokop svým chřestítkem. Je tam rozlámaná lžička, prsten a bezejmenná látka. Pan Holz se pustili do zpěvu válečných písní. Každý sice zpíval jiným jazykem a docela jinou písničku, ale zdálky, zejména potmě za šelestění drobného deště, to splývalo v souzvuk dosti strašlivý a chmurný. Někdo v zámku plane.'),
(7,	'Nenabízíme výstavbu internetu',	'nenabizime-vystavbu-internetu',	'Prokop a hleděl je setřást; nebyl tedy raněn. Jen na obzoru se blýská širokými žlutými plameny; ale ulevující bouře se ještě nespustila. Vystřízlivělý Prokop se kvapně ohlédl. Kdo? Byl už tak zvyklý křičet… vadit se… s pacienty… Látka jí bohužel došla; zato – jako sloup – až mně sirka spálila prsty. A pryč – přes pole – potmě – na Břevnov nebo do Střešovic – Aa někde mě napadlo to slovo. Krakatoe. Krakatit. Kra-ka-tit. Nene, tak to drží dohromady… Pan Carson s tváří zastřenou závojem..'),
(8,	'Neděláme bezpečnost nákupních košíků',	'nedelame-bezpecnost-nakupnich-kosiku',	'Naproti tomu však nasadil mu Carson přímo do laboratoře ženu s dvěma staršími, až po bradu, a upírala na něho hlubokýma, upřenýma očima; studené mžení jí zrosilo závoj i kožišinku. Byl jste ke mně nezapomenutelně laskav ve chvíli, kdy jsem k nim nezachoval pěkně. Skutečně také na další anonce docházelo odpovědí stále méně, zato však byly pořád hrozivější. Za druhé mám velikou radost, že tu jsem zavřen? Pan Paul vrazil do dveří: Poroučí pán něco? Prokop se rozlíceně otočil. Člověče, ruce.'),
(9,	'Realizujeme návrh vašich stránek a bourací techniky',	'realizujeme-navrh-vasich-stranek-a-bouraci-techniky',	'Já – já chci svou obálku. Opakoval to ustavičně, začal zuřit, i zavolala Paula. Paul se šetrně uklonil a zůstal ovšem stát. Poslyšte, Paul, začal zas Prokop kousaje špičku doutníku, děkuju vám. Neznal jste tady nějakého Tomše? Pan Paul se rozpomněl na jakousi silnou, usmolenou a převázanou obálku; kde honem je? Našel ji v náruči, kdybys tušila to… to, co vám z žádného zájmu nezpovídal, odbyl ho Prokop mohl přinejmenším skolit, stáhl mu pásek u vesty, ustoupil a Daimon skočil k plotu..');

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
(2,	19),
(3,	16),
(3,	19),
(4,	16),
(4,	19),
(5,	16),
(6,	16),
(6,	19),
(6,	21),
(7,	16),
(7,	19),
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
(21,	'Admin:Dashboard'),
(22,	'Admin:Eshop'),
(23,	'Admin:Options'),
(24,	'Admin:Page'),
(25,	'Admin:Files');

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
(17,	NULL,	'guest'),
(18,	17,	'user'),
(19,	18,	'admin'),
(20,	19,	'superadmin');

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
(87,	NULL,	'',	'Front:Homepage:default',	NULL),
(88,	NULL,	'kontakt',	'Front:Contact:default',	NULL),
(89,	NULL,	'auth',	'Auth:Sign:in',	NULL),
(90,	NULL,	'administrace',	'Admin:Dashboard:default',	NULL),
(91,	NULL,	'odhlasit',	'Auth:Sign:out',	NULL),
(92,	NULL,	'administrace/stranky',	'Admin:Page:default',	NULL),
(93,	NULL,	'administrace/soubory',	'Admin:Files:default',	NULL),
(94,	NULL,	'administrace/nastaveni',	'Admin:Options:general',	NULL),
(95,	NULL,	'administrace/nova-stranka',	'Admin:Page:new',	NULL),
(96,	NULL,	'administrace/editovat-stranku',	'Admin:Page:edit',	NULL),
(97,	NULL,	'administrace/nastaveni/seo',	'Admin:Options:seo',	NULL),
(98,	NULL,	'nahled-stranky',	'Front:Page:preview',	NULL),
(99,	NULL,	'administrace/nahrat-soubory',	'Admin:Files:upload',	NULL),
(100,	NULL,	'administrace/editovat-soubor',	'Admin:Files:edit',	NULL),
(101,	NULL,	'administrace/eshop/zbozi',	'Admin:Eshop:default',	NULL),
(102,	NULL,	'dolorem',	'Front:Page:default',	25),
(103,	NULL,	'eaque',	'Front:Page:default',	26),
(104,	NULL,	'suscipit',	'Front:Page:default',	27),
(105,	NULL,	'enim',	'Front:Page:default',	28),
(106,	NULL,	'consequuntur',	'Front:Page:default',	29),
(107,	NULL,	'laborum',	'Front:Page:default',	30);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(9,	'admin@antstudio.cz',	'$2y$10$heaKxWCpeqJ8w0PwvjpF7u7i7EyuIqs5AZ.nmBYoY29MYbwNKmeCO',	'2015-07-12 16:39:58'),
(10,	'demo@antstudio.cz',	'$2y$10$J7vN9YJXwcjhs70CzuDEGuPJ6DBdGPIt.O/uwltSPRa6amZPMQKq.',	'2015-07-12 16:39:58');

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
(9,	20),
(10,	18);

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

-- 2015-07-12 14:40:31
