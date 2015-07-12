$(function () {

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

});
