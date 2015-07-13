<?php

use App\Macros\BootstrapMacros;
use Tester\Assert;

require __DIR__ . '/../bootstrap.php';

$compiler = new Latte\Compiler;
BootstrapMacros::install($compiler);

// {row}...{/row}
Assert::same("<?php echo '<div class=row>' ?>", $compiler->openMacro('row')->openingCode);
Assert::same("<?php echo '</div>' ?>", $compiler->closeMacro('row')->closingCode);

// {col}...{/col}
Assert::exception(function () use ($compiler) {
	$compiler->openMacro('col')->openingCode;
}, \Latte\CompileException::class, 'Col arguments cannot be empty');

// {col-lg-12}, {col-lg 12}, {col lg-12}, {col lg 12}
Assert::same("<?php echo '<div class=col-lg-12>' ?>", $compiler->expandMacro('col', '-lg-12')->openingCode);
Assert::same("<?php echo '<div class=col-md-6>' ?>", $compiler->expandMacro('col', '-md 6')->openingCode);
Assert::same("<?php echo '<div class=col-xs-4>' ?>", $compiler->expandMacro('col', ' xs-4')->openingCode);
Assert::same("<?php echo '<div class=col-sm-10>' ?>", $compiler->expandMacro('col', ' sm 10')->openingCode);

// {col-12-lg}, {col-12 lg}, {col 12-lg}, {col 12 lg}
Assert::same("<?php echo '<div class=col-lg-12>' ?>", $compiler->expandMacro('col', '-12-lg')->openingCode);
Assert::same("<?php echo '<div class=col-md-6>' ?>", $compiler->expandMacro('col', '-6 md')->openingCode);
Assert::same("<?php echo '<div class=col-xs-4>' ?>", $compiler->expandMacro('col', ' 4-xs')->openingCode);
Assert::same("<?php echo '<div class=col-sm-10>' ?>", $compiler->expandMacro('col', ' 10 sm')->openingCode);
