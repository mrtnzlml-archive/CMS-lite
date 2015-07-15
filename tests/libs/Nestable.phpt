<?php

use Navigation\Nestable;
use Tester\Assert;

require __DIR__ . '/../bootstrap.php';

Assert::same(
	[1 => 1, 2 => [3 => 3, 4 => 4, 5 => [6 => 6, 7 => 7, 8 => 8,], 9 => 9, 10 => 10,], 11 => 11, 12 => 12,],
	Nestable::resolveJson('[{"id":1},{"id":2,"children":[{"id":3},{"id":4},{"id":5,"children":[{"id":6},{"id":7},{"id":8}]},{"id":9},{"id":10}]},{"id":11},{"id":12}]')
);

Assert::same(
	[13 => 13, 14 => 14, 15 => [16 => 16, 17 => 17, 18 => 18,],],
	Nestable::resolveJson('[{"id":13},{"id":14},{"id":15,"children":[{"id":16},{"id":17},{"id":18}]}]')
);
