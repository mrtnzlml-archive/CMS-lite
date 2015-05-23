<?php

namespace App;

use App\Components\Css\Providers\ICssProvider;
use App\Components\Error404\Providers\IError404TemplateProvider;
use App\Components\Js\Providers\IJsProvider;
use App\Components\Meta\Providers\IMetasProvider;

interface ITemplateProvider extends ICssProvider, IError404TemplateProvider, IJsProvider, IMetasProvider
{

}
