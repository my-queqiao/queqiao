var abbreviations = [ "京", "津", "沪", "渝", "冀", "豫", "云", "辽", "黑", "湘", "皖",
		"鲁", "新", "苏", "浙", "赣", "鄂", "桂", "甘", "晋", "蒙", "陕", "吉", "闽", "贵",
		"粤", "青", "藏", "川", "宁", "琼" ];
var addrChecked = "京";
var addrId = $('#addr');
var codeId = $('#code');
var codes = [ "A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N",
		"P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ];
var codeChecked = 'A';
$.fn.initCarNo = function(option) {
	var carNo = option.carNo;

	if(carNo == null || carNo == ""){
		carNo = '京A';
	}
	
	addrId = $(this).children("#addr");
	addrChecked = addrId.text();
	codeId = $(this).children("#code");
	codeChecked = codeId.text();

	$(this).setCarNo(carNo);
	var addrHtml = ContentMethodAddr();
	var codeHtml = ContentMethodCode();
	init(addrId, addrHtml);
	init(codeId, codeHtml);
}
$(document).on('click', '#addrs a', function(e) {
	var addr = $(this).text();
	addrId.text(addr);
	addrChecked = addr;
	var addrHtml = ContentMethodAddr();
	addrId.popover('destroy');
	init(addrId, addrHtml);
	$("#codes a").attr("class", "btn btn-default");
	$(this).attr("class", "btn btn-default active");
});

$(document).on('click', '#codes a', function(e) {
	var code = $(this).text();
	codeId.text(code);
	codeChecked = $(this);
	var codeHtml = ContentMethodCode();
	codeId.popover('destroy');
	init(codeId, codeHtml);
	$("#codes a").attr("class", "btn btn-default");
	$(this).attr("class", "btn btn-default active");
});

function init(element, content) {
	element.popover({
		trigger : 'manual',
		// 触发方式
		placement : 'bottom',
		// top, bottom, left or right
		html : true,
		// 为true的话，data-content里就能放html代码了
		content : content,
	}).on("mouseenter", function() {
		var _this = this;
		$(this).popover("show");
		$(this).siblings(".popover").on("mouseleave", function() {
			$(_this).popover('hide');
		});
	}).on("mouseleave", function() {
		var _this = this;
		setTimeout(function() {
			if (!$(".popover:hover").length) {
				$(_this).popover("hide")
			}
		}, 100);
	});
}

function ContentMethodAddr() {
	var addr = addrId.text();
	$('#addrs a').each(function() {
		var text = $(this).text();
		if (text == addr) {
			$(this).attr("class", "btn btn-default active");
		} else {
			$(this).attr("class", "btn btn-default");
		}
	});
	var addrs = $('#addrshide').html();
	return addrs;
}

function ContentMethodCode(txt) {
	var code = codeId.text();
	$('#codes a').each(function() {
		var text = $(this).text();
		if (text == code) {
			$(this).attr("class", "btn btn-default active");
		} else {
			$(this).attr("class", "btn btn-default");
		}
	});
	var codes = $('#codeshide').html();
	return codes;
}

$.fn.getCarNo = function() {
	var addr = $("#addr").text();
	var code = $("#code").text();
	var end = $("#end").val();
	return addr + code + end;
}

$.fn.setCarNo = function(carNo) {
	var addr = carNo.substr(0, 1);
	var code = carNo.substr(1, 1);
	var end = carNo.substr(2, 6);
	$("#addr").text(addr);
	$("#code").text(code);
	$("#end").val(end);
}
