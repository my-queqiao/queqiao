
/**
 * 格式化日期
 * @param dateTime
 * @param flag
 * @returns {String}
 */
function dateFormat(dateTime , flag){
	var year = dateTime.getFullYear();
	var month = formatDateElement(dateTime.getMonth()+1);
	var date = formatDateElement(dateTime.getDate());
	var hour = formatDateElement(dateTime.getHours());
	var minute = formatDateElement(dateTime.getMinutes());
	var second = formatDateElement(dateTime.getSeconds());
	if(flag == 1){
		return year + '-' + month + '-' + date + ' ' + hour + ':' + minute + ':' + second;
	}else if(flag == 2){
		return hour + ":" + minute + ":" + second;
	}else if(flag == 3){
	    return year + "年" + month + "月";
	}else if(flag == 4){
	    return year + "年" + month + "月" + date + "日";
	}else if(flag == 5){
	    return year + "年" + month + "月" + date + "日   " + hour +"时";
	}else if(flag == 6){
	    return year + "年";
	}else{
		return year + '-' + month + '-' + date;
	}
}

function getNeedDate(date,type,i){
	if(date == null){
		date = new Date();
	}
	var newDate = date;
	date = "";
	i = parseInt(i);
	if("y" == type){
		//add a year 
		newDate.setYear(newDate.getYear() + i); 
	}else if("M" == type){
		//add a month 
		newDate.setMonth(newDate.getMonth() + i); 
		newDate.setDate(newDate.getDate()-parseInt(1));
	}else if("d" == type){
		//add a day to the date 
		newDate.setDate(newDate.getDate() + i); 
	}else if("h" == type){
		//add a day to the date 
		newDate.setHour(newDate.getHour() + i); 
	}else if("m" == type){
		//add a day to the date 
		newDate.setMinutes(newDate.getMinutes() + i); 
	}else if("week" == type){
		//add a week 
		newDate.setDate(newDate.getDate() + i); 
	}
	return newDate;
}

function GetDateDiff(startDate,endDate){  
    var startTime = startDate.getTime();     
    var endTime = endDate.getTime();     
    var dates = Math.abs((startTime - endTime))/(1000*60*60*24);     
    return  dates;    
}

function GetDateNoAbsDiff(startDate,endDate){  
	var startTime = startDate.getTime();     
	var endTime = endDate.getTime();     
	var dates = (endTime - startTime)/(1000*60*60*24);     
	return  dates;    
}

/**
 * 日期格式中小于10的前面加0
 * @param element
 */
function formatDateElement(element){
	if(element < 10){
		return '0'+element;
	}else{
		return element;
	}
}