<?php

use App\Macros\BootstrapMacros;
use Tester\Assert;

require __DIR__ . '/../bootstrap.php';

$compiler = new Latte\Compiler;
BootstrapMacros::install($compiler);

// {row}...{/row}
Assert::same("<?php echo '<div class=\"row\">' ?>", $compiler->openMacro('row')->openingCode);
Assert::same("<?php echo '</div>' ?>", $compiler->closeMacro('row')->closingCode);

// {row my classes}...{/row}
Assert::same("<?php echo '<div class=\"row my classes\">' ?>", $compiler->expandMacro('row', 'my classes')->openingCode);

// {col}...{/col}
Assert::exception(function () use ($compiler) {
	$compiler->openMacro('col')->openingCode;
}, \Latte\CompileException::class, 'Col arguments cannot be empty');

// {col-lg-12}, {col-lg 12}, {col lg-12}, {col lg 12}
Assert::same("<?php echo '<div class=\"col-lg-12\">' ?>", $compiler->expandMacro('col', '-lg-12')->openingCode);
Assert::same("<?php echo '<div class=\"col-md-6\">' ?>", $compiler->expandMacro('col', '-md 6')->openingCode);
Assert::same("<?php echo '<div class=\"col-xs-4\">' ?>", $compiler->expandMacro('col', ' xs-4')->openingCode);
Assert::same("<?php echo '<div class=\"col-sm-10\">' ?>", $compiler->expandMacro('col', ' sm 10')->openingCode);

// {col-lg12-md11-sm10-xs-9}, {col l12m11s10x9}, {col l12 m11 s10 x9}
Assert::same("<?php echo '<div class=\"col-lg-12 col-md-11 col-sm-10 col-xs-9\">' ?>", $compiler->expandMacro('col', '-lg12-md11-sm10-xs-9')->openingCode);
Assert::same("<?php echo '<div class=\"col-lg-12 col-md-11 col-sm-10 col-xs-9\">' ?>", $compiler->expandMacro('col', 'l12m11s10x9')->openingCode);
Assert::same("<?php echo '<div class=\"col-lg-12 col-md-11 col-sm-10 col-xs-9\">' ?>", $compiler->expandMacro('col', ' l12 m11 s10 x9')->openingCode);
