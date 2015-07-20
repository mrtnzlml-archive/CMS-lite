$(function () {
	"use strict";

	$('#selectAll').change(function () {
		var checkboxes = $(this).closest('form').find(':checkbox');
		if ($(this).is(':checked')) {
			checkboxes.prop('checked', true);
		} else {
			checkboxes.prop('checked', false);
		}
	});

	Nette.toggle = function (id, visible) {
		var el = $('#' + id);
		if (visible) {
			el.slideDown();
		} else {
			el.slideUp();
		}
	};

});
