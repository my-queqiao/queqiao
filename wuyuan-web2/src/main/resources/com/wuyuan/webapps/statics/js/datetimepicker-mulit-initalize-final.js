$("#dateType").change(function(e){
		var now = new Date();
		var  dtMatter = $("#dateType").val();
		$('.date').datetimepicker('remove');
		if(dtMatter=='year' || dtMatter=='total'){
			 //如果日期选择的是年格式
			 var dt = now.getFullYear();
			 $('#endDate').val(dt);
			 now = now.setYear(now.getFullYear() - 1);
			 now = new Date(now);
			 var dt = now.getFullYear();
			 $('#startDate').val(dt);
			 $('.date').datetimepicker({
				language:  'zh-CN',
				autoclose: 1,
				startView: 4,
				minView:4,
				todayHighlight: 0,
				format: 'yyyy'
			 });		 
		}else if(dtMatter=='month' || dtMatter=='season'){
		//如果日期选择的是年月格式
			 var dt = now.getFullYear()+'-'+((now.getMonth()+1)>=10?(now.getMonth()+1):"0"+(now.getMonth()+1));
			 $('#endDate').val(dt);
			 now = now.setMonth(now.getMonth() - 1);
			 now = new Date(now);
			 var dt = now.getFullYear()+'-'+((now.getMonth()+1)>=10?(now.getMonth()+1):"0"+(now.getMonth()+1));
			 $('#startDate').val(dt);
			 $('.date').datetimepicker({
				language:  'zh-CN',
				autoclose: 1,
				startView: 3,
				minView:3,
				todayHighlight: 0,
				format: 'yyyy-mm'
			 });
		}else if(dtMatter=='day' || dtMatter=='hours'){
			//如果日期选择的是年月日格式
			 var dt = now.getFullYear()+'-';
			 dt+=((now.getMonth()+1)>=10?(now.getMonth()+1):"0"+(now.getMonth()+1))+'-';
			 dt+=(now.getDate()>=10?""+now.getDate():"0"+now.getDate());
			 $('#endDate').val(dt);
			 now = now.setDate(now.getDate() - 7);
			 now = new Date(now);
			 var dt = now.getFullYear()+'-';
			 	dt+=((now.getMonth()+1)>=10?(now.getMonth()+1):"0"+(now.getMonth()+1))+'-';
			 	dt+=(now.getDate()>=10?""+now.getDate():"0"+now.getDate());
			 $('#startDate').val(dt);
			 $('.date').datetimepicker({
				language:  'zh-CN',
				autoclose: 1,
				startView: 2,
				minView:2,
				todayBtn:1,
				todayHighlight: 1,
				format: 'yyyy-mm-dd'
			 });		
		}else if(dtMatter=='hour'){
			//如果日期选择的是年月日时格式
			 var dt = now.getFullYear()+'-';
			 dt+=((now.getMonth()+1)>=10?(now.getMonth()+1):"0"+(now.getMonth()+1))+'-';
			 dt+=(now.getDate()>=10?""+now.getDate():"0"+now.getDate())+" ";
			 dt+=(now.getHours()>=10?""+now.getHours():"0"+now.getHours())+":";
			 dt+=(now.getMinutes()>=10?""+now.getMinutes():"0"+now.getMinutes());
			 $('#endDate').val(dt);
			 now = now.setDate(now.getDate() - 7);
			 now = new Date(now);
			 var dt = now.getFullYear()+'-';
			 	dt+=((now.getMonth()+1)>=10?(now.getMonth()+1):"0"+(now.getMonth()+1))+'-';
			 	dt+=(now.getDate()>=10?""+now.getDate():"0"+now.getDate())+" ";
			 	dt+=(now.getHours()>=10?""+now.getHours():"0"+now.getHours())+":";
				dt+=(now.getMinutes()>=10?""+now.getMinutes():"0"+now.getMinutes());
			 $('#startDate').val(dt);
			$('.date').datetimepicker({
				language:  'zh-CN',
				autoclose: 1,
				startView: 2,
				minView:1,
				todayBtn:1,
				todayHighlight: 1,
				format: 'yyyy-mm-dd hh:ii'
			 });			 
		}else if(dtMatter=='minute'){
		//如果日期选择的是年月日时分格式
			var dt = now.getFullYear()+'-';
			dt+=((now.getMonth()+1)>=10?(now.getMonth()+1):"0"+(now.getMonth()+1))+'-';
			dt+=(now.getDate()>=10?""+now.getDate():"0"+now.getDate())+" ";
			dt+=(now.getHours()>=10?""+now.getHours():"0"+now.getHours())+":";
			dt+=(now.getMinutes()>=10?""+now.getMinutes():"0"+now.getMinutes());
			$('#endDate').val(dt);
			now = now.setDate(now.getDate() - 1);
			now = new Date(now);
			var dt = now.getFullYear()+'-';
			dt+=((now.getMonth()+1)>=10?(now.getMonth()+1):"0"+(now.getMonth()+1))+'-';
			dt+=(now.getDate()>=10?""+now.getDate():"0"+now.getDate())+" ";
			dt+=(now.getHours()>=10?""+now.getHours():"0"+now.getHours())+":";
			dt+=(now.getMinutes()>=10?""+now.getMinutes():"0"+now.getMinutes());
			$('#startDate').val(dt);
			$('.date').datetimepicker({
				language:  'zh-CN',
				autoclose: 1,
				startView: 2,
				minView:0,
				minuteStep:5,
				todayBtn:1,
				todayHighlight: 1,
				format: 'yyyy-mm-dd hh:ii'
			 });			 
		}
		
	});
   