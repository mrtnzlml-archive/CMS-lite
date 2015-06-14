$(function () {
	"use strict";

	$('#selectAll').change(function () {
		//TODO: closest form, not table
		var checkboxes = $(this).closest('table').find(':checkbox');
		if ($(this).is(':checked')) {
			checkboxes.prop('checked', true);
		} else {
			checkboxes.prop('checked', false);
		}
	});

});
