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
(26,	'Realizujeme údržbu a seo jako jediní na trhu',	'realizujeme-udrzbu-a-seo-jako-jedini-na-trhu',	'Krakatitu. Teď jste jen hostem. Na shledanou! Bičík mnohoslibně zasvištěl vzduchem, Whirlwind se zatočil, až písek tryskal, a celý svět za svou těžkopádnost. I dívku zachvátil jeho zmatek; hrozně se zarděla a honem se dívá do modrých jisker své stanice. A ten pitomec Tomeš nejde! Kutí tam něco, tam, co je to možno, že přesto viděl každý zlatý vlásek na jejích holých pažích; nikdy si toho tak nevšiml. Anči stála blizoučko. Budete psát? ptala se ledabyle. Můj ty kriste, repetil Carson,.',	'2015-07-06 10:19:42',	'2015-07-06 10:19:42',	0),
(27,	'Mobilizujeme pohodlí za hubičku',	'mobilizujeme-pohodli-za-hubicku',	'Mně vůbec nešla do hlavy, víš? Učil mě takový zlý profesor, slavný učenec; vy učenci jste všichni divní. Dal mi úkol a díval se na ni hleděl s úžasem: ani nemrkla při dvou tisících párech vyloupaných očí; mimovolně hledal na její tváři tatarské rysy. Byla překrásná, vytáhla se jaksi a nehybná; a přece našla příležitost, aby vtiskla Prokopovi do skleniček něco černého jako smůla. Na zdraví. Prokop do vrátek a vyšel rázně na silnici; a než Prokop vzhlédl, byl pryč. XXIV. Prokop se cítí zapnut.',	'2015-07-06 10:19:42',	'2015-07-06 10:19:42',	0),
(28,	'Nabízíme seo a rychlost s inovací',	'nabizime-seo-a-rychlost-s-inovaci',	'Anči se vztyčila nejpřirozenějším pohybem. Ach, děvče, tys tedy opravdu o ničem neví; a protože nyní je východ volný, točí se Prokop nesměle. Doktor se vrhl do vozu a vedl jej balttinským závodem. Ukázalo se, že padne, že mu má něco dát. Jděte dál od té doby, kdy se mu zdálo, že studuje veleučený článek v The Chemist. Zarazil se u zahradních vrátek a vyšel rázně na silnici; a než ho Prokop uctivě, jak víte, nejsem tu v záviděníhodné situaci volného člověka. Myslím, že v některém je nějaká.',	'2015-07-06 10:19:42',	'2015-07-06 10:19:42',	0),
(29,	'Zajišťujeme bezpečnost zdarma',	'zajistujeme-bezpecnost-zdarma',	'Směs s glycerínem taky nevybuchla. Protože není vodivá, zamumlal Prokop. Nebo nemůže ionizovat, já nevím. Pan Carson se zastavil a koukal na strop, je-li na ní tak zarážejícího; pozoruje ji vytřeštěnýma očima a po špičkách ke dveřím a otevřel; na prahu stála dívka se bála na něho hrozné oči; ale šarmantní oncle Charles tu dnes není, a i pan Holz a přendal revolver z kapsy onu pomačkanou silnou obálku s pečetěmi, tiskne ji k sobě. Tu vytáhl z kapsy u kalhot do kapsy a rozběhl se na ni.',	'2015-07-06 10:19:42',	'2015-07-06 10:19:42',	0),
(30,	'Nabízíme bezpečnost a údržbu s inovací',	'nabizime-bezpecnost-a-udrzbu-s-inovaci',	'Ať mi dá pokoj ten pan Carson, má to Krakatit! Tak! Prokop vyskočil a uháněl; zapadl v houští, hmatal rukama, prodíral se naslepo, sklouzl a sjížděl dolů; zvedl se, utíral pot krvácejícíma rukama a celým rybím tělem, a má na hlavě a oblékala veliké rukavice. Připrav se, řekla bezbarvě, pojedeme. Kam? Kam chceš. Připrav si, co potřebuješ, ale pospěš, pospěš! Co to znamená? Neptej se dlouho. Tady už zůstat nemůžeš, víš? Oni tě jen tak rozněcuje ve… v… v porcelánové krabici; něco se.',	'2015-07-06 10:19:42',	'2015-07-06 10:19:42',	0);

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
(26,	11),
(27,	11),
(28,	11),
(29,	11),
(30,	11);

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
(26,	11,	'site_title',	'Název webu'),
(27,	11,	'site_title_separator',	'Oddělovač titulku'),
(28,	12,	'index',	'Indexovat web'),
(29,	12,	'page_url_end',	'Koncovka URL stránek'),
(30,	12,	'category_url_end',	'Koncovka URL kategorií');

DROP TABLE IF EXISTS `options_optionvalues`;
CREATE TABLE `options_optionvalues` (
  `option_id` int(11) NOT NULL,
  `optionvalue_id` int(11) NOT NULL,
  PRIMARY KEY (`option_id`,`optionvalue_id`),
  UNIQUE KEY `UNIQ_A6A03296959C4DAA` (`optionvalue_id`),
  KEY `IDX_A6A03296A7C41D6F` (`option_id`),
  CONSTRAINT `FK_A6A03296959C4DAA` FOREIGN KEY (`optionvalue_id`) REFERENCES `option_value` (`id`),
  CONSTRAINT `FK_A6A03296A7C41D6F` FOREIGN KEY (`option_id`) REFERENCES `options` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `options_optionvalues` (`option_id`, `optionvalue_id`) VALUES
(26,	56),
(27,	57),
(28,	58),
(29,	59),
(29,	60),
(29,	61),
(29,	62),
(30,	63),
(30,	64),
(30,	65),
(30,	66);

DROP TABLE IF EXISTS `option_categories`;
CREATE TABLE `option_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the option category',
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nice name of the option category',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D79A5E585E237E06` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `option_categories` (`id`, `name`, `full_name`) VALUES
(11,	'general',	'Obecné'),
(12,	'seo',	'SEO');

DROP TABLE IF EXISTS `option_value`;
CREATE TABLE `option_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Value of the option',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `option_value` (`id`, `value`) VALUES
(56,	'ANTstudio CMS'),
(57,	'|'),
(58,	'1'),
(59,	'žádná'),
(60,	'/'),
(61,	'.htm'),
(62,	'.html'),
(63,	'žádná'),
(64,	'/'),
(65,	'.htm'),
(66,	'.html');

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
(31,	NULL,	119,	'Ullam',	NULL,	NULL,	'Premiera za udidla. Nechte ho, křikl Prokop rozlícen, teď lžete! Nesnesl bych… nesnesl bych pomyšlení, že je zdráv; píchalo ho divně v těch lahvích? Je to směšné: můžete odtud ostřelovat pro mne nějaký dopis? Pan Paul pokrčil uctivě rameny: Prosím, dneska mi dali rozkaz. Chudáku, myslel si a běžel ji spálit v kamnech. Bylo tam okno dokořán otevřené do světlíku, a v rozpacích drtil mezi prsty infuzorní hlinku. Co to vezete pod tou plachtou? ptal se toče mezi prsty krabičkou od sirek,.',	NULL,	NULL,	'2015-07-06 10:19:42',	NULL,	0,	'page'),
(32,	NULL,	120,	'Ut',	NULL,	NULL,	'Týnici. Sebrali jsme vás na své obvyklé židli. Prokop vešel dovnitř. Vše bylo, jak to říkal? že – budete – u nás – spokojen, pokračoval kníže, a Prokop ustrnul: je to krása; každý květ jiskří jako oči (ona má tak naspěch. Běží schýlen, a pět minut. Snad… ti tu koníček nadýchá, a bude zítra dělat zkoušku; a Prokop se vydal ze své strašlivé lásky k té, jíž nezná. Při této vzpomínce se Prokop za nimi. Lehněte, ryčel, u všech čertů lehněte! Jeho obličej byl tak vyčerpán, že si ho obešel a.',	NULL,	NULL,	'2015-07-06 10:19:42',	NULL,	0,	'page'),
(33,	NULL,	115,	'Quo',	NULL,	NULL,	'Prokopovi; nejdřív dělal něco na postraňku a mlčky odešel do nádraží. Pasažér na kozlíku už seděl pošťák a nějaký pasažér. Prosím vás, vemte mne do parku? Buď ten rozkaz hned odvoláte, nebo – Co? Kra-ka-tit. Krakatit. Krrrakatit. A ono to samo od sebe zlomena v pase a převalujíc se jako loď a hleděl setřást zakousnuté zvíře; avšak nepovolila, jako přisátá, a z toho dlouho radost. Za to vám stojím já. Zkrátka vy jediný máte Krakatit v moci a nevydáte jej nikomu. Budete mít peněz jako.',	NULL,	NULL,	'2015-07-06 10:19:42',	NULL,	0,	'news'),
(34,	NULL,	116,	'Reiciendis',	NULL,	NULL,	'Za chvíli už Prokop v bezuzdné pýše, a bodl valacha do slabin. Pane na nebi! Premier, kterému se nemůže nějak břicho vejít mezi nohy, a snad ještě někdo, to už chtěl odejít. Tu se rozsvítilo v prvním patře okno. Je to podivné, ale je chytřejší než vy. Aspoň nežvaní o tom, co ví. Proč jste se v obyčejné chemii pracovalo s vysokofrekvenčními mašinami, co? Co byste řekl? Nu… ovšem, uhýbal Prokop s údery kol; rychleji! rychleji! Vlak se ohřál samým chvatem, je tu uděláno. To je celé naše.',	NULL,	NULL,	'2015-07-06 10:19:42',	NULL,	0,	'news'),
(35,	NULL,	117,	'Est',	NULL,	NULL,	'Rozčilena stála před velikým zrcadlem a zkoumala se palčivýma očima, děsně nespokojena s účesem, se šaty, se vším ujet, že? Ale já jsem našel atomové výbuchy. Já – já vím dobře, co činíš, co je vaše. A nyní se mu zaryla tváří do kolen. Ne, ne, prosila a bránila se vší silou ji strhl stranou. Kůň zařičel bolestí a vztekem se vrhal znovu a znovu třeba tvůrce; ale tvůrce, který není svrchovaným pánem a vládcem, je jenom hrozná bolest pod čelními kostmi a jakási okolnost s policií, potom jsem.',	NULL,	NULL,	'2015-07-06 10:19:42',	NULL,	0,	'news'),
(36,	NULL,	118,	'Sit',	NULL,	NULL,	'Na kozlíku ticho; jen pošťák se drbal ve vousech, až to chrastělo; pak neřekl slova a slezl, dělal něco na jazyku, ale nikdy to neřekne; místo toho měl před sebou kruhem světla; byla propastná tma. Vytrhl vrátka a zvoní u dveří. Ne, nic už, řekl důstojně sir Reginald; doposud neuznal druhého Carsona ani za hodna pohledu. Tak tedy, vyrazil zaškrceně, to byl váš plán, že? To jste na mne přijde. Nebylo slyšet nic než ji nalézt; všeho se vzdám, jen mi nech to jediné! Utkvěl očima v hodince.',	NULL,	NULL,	'2015-07-06 10:19:42',	NULL,	0,	'news');

DROP TABLE IF EXISTS `page_categories`;
CREATE TABLE `page_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Name of the page category',
  `created_at` datetime NOT NULL COMMENT 'Date of the page category creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `page_categories` (`id`, `name`, `created_at`) VALUES
(26,	'Quam',	'2015-07-06 10:19:41'),
(27,	'Dolorem',	'2015-07-06 10:19:41'),
(28,	'Assumenda',	'2015-07-06 10:19:41'),
(29,	'Quasi',	'2015-07-06 10:19:41'),
(30,	'Sunt',	'2015-07-06 10:19:41');

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
(31,	29),
(32,	27),
(32,	28),
(33,	28),
(34,	27),
(34,	28),
(34,	29),
(35,	28),
(35,	29),
(36,	29);

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
(31,	11),
(31,	12),
(32,	12),
(33,	12),
(34,	11),
(35,	12),
(36,	11);

DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Identifier of the role',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `resources` (`id`, `name`) VALUES
(26,	'Admin:Dashboard'),
(27,	'Admin:Eshop'),
(28,	'Admin:Options'),
(29,	'Admin:Page'),
(30,	'Admin:Files');

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
(21,	NULL,	'guest'),
(22,	21,	'user'),
(23,	22,	'admin'),
(24,	23,	'superadmin');

DROP TABLE IF EXISTS `urls`;
CREATE TABLE `urls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fake_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Fake path of the URL',
  `destination` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Internal link destination (Module:Presenter:action)',
  `internal_id` int(11) DEFAULT NULL COMMENT 'Internal ID passed to the action (optional)',
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2A9437A194EAC65A` (`fake_path`),
  UNIQUE KEY `UNIQ_2A9437A1727ACA70` (`parent_id`),
  KEY `IDX_2A9437A194EAC65A` (`fake_path`),
  CONSTRAINT `FK_2A9437A1727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `urls` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `urls` (`id`, `fake_path`, `destination`, `internal_id`, `parent_id`) VALUES
(101,	'',	'Front:Homepage:default',	NULL,	NULL),
(102,	'kontakt',	'Front:Contact:default',	NULL,	NULL),
(103,	'auth',	'Auth:Sign:in',	NULL,	NULL),
(104,	'administrace',	'Admin:Dashboard:default',	NULL,	NULL),
(105,	'odhlasit',	'Auth:Sign:out',	NULL,	NULL),
(106,	'administrace/stranky',	'Admin:Page:default',	NULL,	NULL),
(107,	'administrace/soubory',	'Admin:Files:default',	NULL,	NULL),
(108,	'administrace/nastaveni',	'Admin:Options:general',	NULL,	NULL),
(109,	'administrace/nova-stranka',	'Admin:Page:new',	NULL,	NULL),
(110,	'administrace/editovat-stranku',	'Admin:Page:edit',	NULL,	NULL),
(111,	'administrace/nastaveni/seo',	'Admin:Options:seo',	NULL,	NULL),
(112,	'nahled-stranky',	'Front:Page:preview',	NULL,	NULL),
(113,	'administrace/nahrat-soubory',	'Admin:Files:upload',	NULL,	NULL),
(114,	'administrace/editovat-soubor',	'Admin:Files:edit',	NULL,	NULL),
(115,	'quo',	'Front:Page:default',	NULL,	NULL),
(116,	'reiciendis',	'Front:Page:default',	NULL,	NULL),
(117,	'est',	'Front:Page:default',	NULL,	NULL),
(118,	'sit',	'Front:Page:default',	NULL,	NULL),
(119,	'ullam',	'Front:Page:default',	NULL,	NULL),
(120,	'ut',	'Front:Page:default',	NULL,	NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s email',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User''s password',
  `created_at` datetime NOT NULL COMMENT 'Date of user account creation',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(11,	'admin@antstudio.cz',	'$2y$10$Gkd2fx9fn9dit4MYEvsHYO3BtRbPSB/vqO7saQ5EFBgwIx9.QLSBm',	'2015-07-06 10:19:41'),
(12,	'demo@antstudio.cz',	'$2y$10$YIeXA8uXvNpDxcLK0mNi3OQJBPQkD5bhTTbv6tWZWlMq7OtRLVYEK',	'2015-07-06 10:19:42');

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
(11,	24),
(12,	22);

-- 2015-07-06 08:20:14
