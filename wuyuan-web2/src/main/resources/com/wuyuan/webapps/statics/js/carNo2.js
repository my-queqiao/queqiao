var button = $('#addr');
$(function() {
	initCarNo();
	setCarNo("桂YU1139");
});
$(document).on('click', '#codes a', function(e) {
	$("#codes a").attr("class", "btn btn-default");
	$(this).attr("class", "btn btn-default active");
	var text = $(this).text();
	button.text(text);
});

$(document).on('click', 'div[id^=ends] a', function(e) {
	$("div[id^=ends] a").attr("class", "btn btn-default");
	$(this).attr("class", "btn btn-default active");
	var text = $(this).text();
	button.text(text);
});

$('#addrs a').click(function() {
	$("#addrs a").attr("class", "btn btn-default");
	$(this).attr("class", "btn btn-default active");
	var text = $(this).text();
	button.text(text);
});

function getCarNo() {
	var addr = $("#addr").text();
	var code = $("#code").text();
	var end1 = $("#end1").text();
	var end2 = $("#end2").text();
	var end3 = $("#end3").text();
	var end4 = $("#end4").text();
	var end5 = $("#end5").text();
	return addr + code + end1 + end2 + end3 + end4 + end5;
}

function setCarNo(carNo) {
	var addr = carNo.substr(0, 1);
	var code = carNo.substr(1, 1);
	var end1 = carNo.substr(2, 1);
	var end2 = carNo.substr(3, 1);
	var end3 = carNo.substr(4, 1);
	var end4 = carNo.substr(5, 1);
	var end5 = carNo.substr(6, 1);
	$("#addr").text(addr);
	$("#code").text(code);
	$("#end").text(end1);
	$("#end").text(end2);
	$("#end").text(end3);
	$("#end").text(end4);
	$("#end").text(end5);
}

function initCarNo() {
	hide();
	$('#addr').click(function() {
		hide();
		show($("#addrs"), $("#addrs a"), $(this));
	});
	$('#code').click(function() {
		hide();
		show($("#codes"), $("#codes a"), $(this));
	});
	$("#end1").click(function() {
		hide();
		show($("#ends1"), $("#ends1 a"), $(this));
	});
	$("#end2").click(function() {
		hide();
		show($("#ends2"), $("#ends2 a"), $(this));
	});
	$("#end3").click(function() {
		hide();
		show($("#ends3"), $("#ends3 a"), $(this));
	});
	$("#end4").click(function() {
		hide();
		show($("#ends4"), $("#ends4 a"), $(this));
	});
	$("#end5").click(function() {
		hide();
		show($("#ends5"), $("#ends5 a"), $(this));
	});
}

function show(btns, btnas, btn) {
	var code = btn.text();
	button = btn;
	btnas.show();
	btnas.each(function() {
		var text = $(this).text();
		if (text == code) {
			$(this).attr("class", "btn btn-default active");
		} else {
			$(this).attr("class", "btn btn-default");
		}
	});
	btns.show();
}

function hide() {
	$("#codes").hide();
	$("#addrs").hide();
	$("#ends1").hide();
	$("#ends2").hide();
	$("#ends3").hide();
	$("#ends4").hide();
	$("#ends5").hide();
}