var number, type, startDate;
function changeAmount() {
	number = $("#number").val();
	type = $("#priceType").val();
	var price = $("#" + type).val();
	var totalPrice = number * price;
	$("#receivableAmount").val(totalPrice);
	$("#requestAmount").val(totalPrice);
}

function changeDate(mothType) {
	var startDate = $("#startDate").val();
	var start = new Date(startDate);
	if(mothType == null){
		var mType = $("#priceType").val();
		var _type;
		if(mType=='free'){
		   _type = 'd';
		}else{
		   _type = 'M';
		}
		mothType = _type;
	}
	var end = getNeedDate(start, mothType, getMonth());
	var endDate = dateFormat(end, 7);
	$("#endDate").val(endDate);
}
function getMode() {
	var mode = 1;
	if ("month" == type) {
		mode = 0;
	} else if ("quarter" == type) {
		mode = 1;
	} else if ("halfYear" == type) {
		mode = 2;
	} else if ("year" == type) {
		mode = 3;
	}else if ("doubleMouth" == type) {
		mode = 4;
	} else if ("free" == type) {
		mode = 5;
	}else {
		mode = 0;
	}
	return mode;
}
function getMonth() {
	var months = 1;
	if ("month" == type) {
		months = number;
	} else if ("doubleMouth" == type) {
		months = number * 2;
	}else if ("quarter" == type) {
		months = number * 3;
	} else if ("halfYear" == type) {
		months = number * 6;
	} else if ("year" == type) {
		months = number * 12;
	} else {
		months = number;
	}
	return months;
}

function changePrice(url) {
	var param = {
		parkId : $("#parkId").val(),
		priceId: $("#priceId").val()
	};
	$.post(url,param, function(data) {
				if (data.result) {
					memberPrice = data.data.memberPrice;
					$("#month").val(memberPrice.month);
					$("#quarter").val(memberPrice.quarter);
					$("#halfYear").val(memberPrice.halfYear);
					$("#year").val(memberPrice.year);
					$("#doubleMouth").val(memberPrice.doubleMouth);
					$("#free").val(memberPrice.free);
					changeAmount();
				}
			});
}



function getMemberPriceByParkId(url) {
	var param = {
		parkId : $("#parkId").val(),
	};
	$.post(url,param, function(data) {
				if (data.result) {
					memberPrice = data.data.memberPrice;
					$("#month").val(memberPrice.month);
					$("#quarter").val(memberPrice.quarter);
					$("#halfYear").val(memberPrice.halfYear);
					$("#year").val(memberPrice.year);
					$("#doubleMouth").val(memberPrice.doubleMouth);
					$("#free").val(memberPrice.free);
					changeAmount();
				}
			});
}

function getPriceName(url,parkId){
    $.post(url,"parkId="+parkId,function(data){
          var _obj =document.getElementById('priceId');
          _obj.options.length=0;
          var prices = data.data.memberPrices;
          for(var i=0;i<prices.length;i++){
             _obj.options.add(new Option(prices[i].name,prices[i].id));
          }
          var index = obj.selectedIndex;
          $("#priceId").val(obj.options[index].value);
    });	
}



