$(function () {
	"use strict";
	$.nette.init();

	$('.tags').selectize({
		plugins: ['restore_on_backspace', 'remove_button'],
		delimiter: ',',
		persist: false,
		create: function (input) {
			return {
				value: input,
				text: input
			}
		}
	});

	$(initialize);
	$(document).bind('ajaxSuccess', initialize);
});

function initialize() {

	//FIXME: možná také odesílat až po kliknutí na uložit, aby nedocházalo k nechtěným změnám na produkci
	$('.dd').nestable({
		maxDepth: 100
	}).on('change', function (event) {
		var list = event.length ? event : $(event.target);
		var output = list.data('output');
		var data = {};
		data[list.data('control-prefix') + '-json'] = JSON.stringify(list.nestable('serialize'));
		$.nette.ajax({
			url: list.data('ajax-handle'),
			type: 'post',
			data: data
		});
	});

	// generuje URL na zaklade zadavaneho titulku
	$('input[data-slug-to]').keyup(function () {
		var slugId = $(this).data('slug-to');
		var val = $(this).val();
		$('#' + slugId).val(make_url(val));
	});

	// přidává config dialog k odkazům s data-confirm atributem
	$('body').on('click', '[data-confirm]', function (e) {
		var question = $(this).data('confirm');
		if (!confirm(question)) {
			e.stopImmediatePropagation();
			e.preventDefault();
		}
	});

	// zbývající počet znaků
	$('[data-countdown-to]').keyup(function () {
		var countdownId = $(this).data('countdown-to');
		var countdownMax = $(this).data('countdown-max');
		var val = $(this).val().length;
		var remaining = countdownMax - val > 0 ? countdownMax - val : 0;
		$('#' + countdownId).html(remaining);
	});

	$('[data-toggle="tooltip"]').tooltip({
		'delay': {show: 700, hide: 100}
	});

	$("#tipsNums").click(function () {
		$("#tipsContent").fadeToggle(500, function () {
		});
	});

	$(".exitTips").click(function (event) {
		event.preventDefault();
		$("#tipsContent").hide();
	});

	$('.dropdown-toggle').click(function () {
		$(this).next('.dropdown-menu').slideToggle(500);
	});

	$('.open-nav').click(function () {
		$('#content').toggleClass('closeMenu');
	});

	var hash = window.location.hash;
	hash && $('ul.nav a[href="' + hash + '"]').tab('show');
	$('.nav-tabs a').click(function (e) {
		$(this).tab('show');
		var scrollmem = $('body').scrollTop();
		window.location.hash = this.hash;
		$('html,body').scrollTop(scrollmem);
	});

}

var nodiac = {
	'á': 'a',
	'č': 'c',
	'ď': 'd',
	'é': 'e',
	'ě': 'e',
	'í': 'i',
	'ň': 'n',
	'ó': 'o',
	'ř': 'r',
	'š': 's',
	'ť': 't',
	'ú': 'u',
	'ů': 'u',
	'ý': 'y',
	'ž': 'z'
};
/** Vytvoření přátelského URL
 * @param s string řetězec, ze kterého se má vytvořit URL
 * @return string řetězec obsahující pouze čísla, znaky bez diakritiky, podtržítko a pomlčku
 * @copyright Jakub Vrána, http://php.vrana.cz/
 */
function make_url(s) {
	s = s.toLowerCase();
	var s2 = '';
	for (var i = 0; i < s.length; i++) {
		s2 += (typeof nodiac[s.charAt(i)] != 'undefined' ? nodiac[s.charAt(i)] : s.charAt(i));
	}
	return s2.replace(/[^a-z0-9_]+/g, '-').replace(/^-|-$/g, '');
}
