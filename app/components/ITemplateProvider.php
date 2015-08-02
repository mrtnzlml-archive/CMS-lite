<?php

namespace App;

use App\Components\ContactForm\Providers\IContactFormTemplateProvider;
use App\Components\Css\Providers\ICssProvider;
use App\Components\Error404\Providers\IError404TemplateProvider;
use App\Components\Footer\Providers\IFooterTemplateProvider;
use App\Components\Js\Providers\IJsProvider;
use App\Components\MainMenu\Providers\IMainMenuTemplateProvider;

interface ITemplateProvider extends ICssProvider, IError404TemplateProvider, IJsProvider, IMainMenuTemplateProvider,
	IContactFormTemplateProvider, IFooterTemplateProvider
{

}
