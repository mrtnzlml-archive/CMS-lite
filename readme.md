Instalace
=========
- Nainstalovat GIT (http://git-scm.com/)
- `https://github.com/mrtnzlml/ANT.git`
- Nainstalovat Composer (http://getcomposer.org/)
- `composer install`
- Vytvořit složky (v rootu webu) `log` a `temp` s možností zápisu
- Přejmenovat `config.local.neon.dist` (v app/config) na `config.local.neon` a nastavit

Idea
====
V `app` je jádro aplikace, sem by se nejspíš nemělo zasahovat.
K tomu je určena složka `libs`, kde jsou rozšíření DI kontejneru.
Ty se registrují v `config.neon`, CoreExtension se toho pak chytí a napojí to do aplikace.
To co má kam napojit já dáno přes providery (interface), které je podle potřeby nutné implementovat.
Více lze vykoukat z toho, jak jsou některé rozšíření již napsané.
Takto je možné přidat jak business logiku (to hlavně), tak přepsat předdefinované šablony (viz `libs/Drym`).

Work in progress...