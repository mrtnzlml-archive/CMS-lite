**README**: [Instalace](https://github.com/antstudiocz/CMS/wiki/Instalace)

Idea
====
V `app` je jádro aplikace, sem by se nejspíš nemělo zasahovat.
K tomu je určena složka `libs`, kde jsou rozšíření DI kontejneru.
Ty se registrují v `config.neon`, CoreExtension se toho pak chytí a napojí to do aplikace.
To co má kam napojit já dáno přes providery (interface), které je podle potřeby nutné implementovat.
Více lze vykoukat z toho, jak jsou některé rozšíření již napsané.
Takto je možné přidat jak business logiku (to hlavně), tak přepsat předdefinované šablony (viz `libs/Versatile`).

Work in progress...
