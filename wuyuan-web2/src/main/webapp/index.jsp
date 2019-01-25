<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- <response.sendRedirect("saolei");>尖括号内有百分号  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    	<meta charset="utf-8" />
    	<meta name="baidu-site-verification" content="uzOhkR1Gj8" />
        <title>在线扫雷</title>
        <meta name="description" 
        content="扫雷是一款大众类的益智小游戏，于1992年发行。游戏目标是在最短的时间内根据点击格子出现的数字找出所有非雷格子，同时避免踩雷，踩到一个雷即全盘皆输。">
</head>
<style type="text/css">
@media screen and (max-width: 1400px) { /*当屏幕尺寸，小于1400px时，应用下面的CSS样式*/
	#leis{
		position: relative;margin-left: 41.5%;top: 22%;height: 400px;width: 750px;
	}
	#leiShuliang{
		margin-left:41.5%;position: relative;top: 17%;color:aliceblue;font-family: 仿宋;float: left;
	}
	#jishi{
		margin-left:51%;position: relative;top: 17%;color:aliceblue;font-family: 仿宋;
	}
	#shuaxin{
		position:absolute;margin-left: 49%;top: 22%;
	}
}
@media screen and (min-width: 1400px) { /*当屏幕尺寸，大于1400px时，应用下面的CSS样式*/
	#leis{
		position: relative;margin-left: 42%;top: 22%;height: 400px;width: 750px;
	}
	#leiShuliang{
		margin-left:42%;position: relative;top: 17%;color:aliceblue;font-family: 仿宋;float: left;
	}
	#jishi{
		margin-left:49%;position: relative;top: 17%;color:aliceblue;font-family: 仿宋;
	}
	#shuaxin{
		position:absolute;margin-left: 47%;top: 22%;
	}
}
</style>
<body onselectstart="return false" style="background-color: #282C34;"><!-- 该属性阻止html双击选中事件 -->
		
		<a href="<%=request.getContextPath()%>/toLiuyanSaolei" target="_blank" 
					style="position: absolute;left: 86%;top: 5%;color: black;font-family: 仿宋;font-size: 20px;cursor:pointer;">
						留言
					</a>
		
						<!-- 
						<div style="position:absolute;margin-left: 80%;top: 30%;color: blue;font-family: 仿宋;">
							自定义地雷数量：<input id="number" style="width: 15%;" value="99" /><br />
							<input type="button" onclick="sendNumber();" value="确认" /><br/>
							<span style="color: black;">提示1：格子总数不变，为扫雷高级标准的480个</span><br/>
							<span style="color: black;">提示2：地雷数量可变，默认是99个</span>
						</div>-->
						
					<div style="position:absolute;margin-left: 80%;top: 30%;color: blue;font-family: 仿宋;">
						<input style="background-color: #282C34;" value="初级" onclick="jibie(1);" type="button"/><br>
						<input style="background-color: #282C34;" value="中级" onclick="jibie(2);" type="button"/><br>
						<input style="background-color: #282C34;" value="高级" onclick="jibie(3);" type="button"/>
					</div>
						
						<div id="shuaxin" style="">
						<img style='width: 25px;height: 25px;' src='<%=request.getContextPath()%>/statics/img/76.jpg'/>
						</div>
		<div id="jieshu" style="position: absolute;margin-left: 45%;top: 15%;color:red;font-family: 仿宋;">
			&nbsp&nbsp
		</div>
		<div id="leiShuliang" style="">
			剩余数量：0
		</div>
		<div id="jishi" style="">
			已耗时：0秒
		</div>
		
		<div id="leis" style="" >
			<!-- 展示雷区页面 -->
		</div>
		<div id="" style="position: relative;margin-left: 45%;top: 25%;" >
			<a style="color: aliceblue;" href="http://www.miitbeian.gov.cn" target="_blank">京ICP备18060161</a>
		</div>
</body>
</html>

<script src="<%=request.getContextPath()%>/statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/statics/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
	
<script>
var stopjishi = 0;//不为0时，停止计时
var jishi = 0;
var interval = setInterval(function(){
	if(stopjishi != 0){
		return;
	}
	$("#jishi").text("已耗时："+jishi++ +"秒");
},1000);
	var gradeTemp = 1;
	function jibie(grade){
		gradeTemp = grade;
		//alert(grade);
		//location.href="<%=request.getContextPath()%>/saolei";
		getLeis(grade);
		if(grade == 1) {//宽度230px
			$("#leis").width(230);
			//样式
			if(screen.width < 1400){
				$("#leis").css("margin-left","41.5%");
				$("#leiShuliang").css("margin-left","41.5%");
				$("#jishi").css("margin-left","51%");
			}
			if(screen.width >= 1400){
				$("#leis").css("margin-left","42%");
				$("#leiShuliang").css("margin-left","42%");
				$("#jishi").css("margin-left","49%");
				$("#shuaxin").css("margin-left","47%");
			}
		}
		if(grade == 2) {
			$("#leis").width(400);
			//样式
			if(screen.width < 1400){
				$("#leis").css("margin-left","35%");
				$("#leiShuliang").css("margin-left","35%");
				$("#jishi").css("margin-left","57%");
			}
			if(screen.width >= 1400){
				$("#leis").css("margin-left","38%");
				$("#leiShuliang").css("margin-left","38%");
				$("#jishi").css("margin-left","54%");
				$("#shuaxin").css("margin-left","47.5%");
			}
		}
		if(grade == 3) {
			$("#leis").width(750);
			//样式
			if(screen.width < 1400){
				$("#leis").css("margin-left","22%");
				$("#leiShuliang").css("margin-left","22%");
				$("#jishi").css("margin-left","70%");
			}
			if(screen.width >= 1400){
				$("#leis").css("margin-left","30%");
				$("#leiShuliang").css("margin-left","30%");
				$("#jishi").css("margin-left","64%");
				$("#shuaxin").css("margin-left","48%");
			}
		}
		clearInterval(interval);//结束上一次计时
		jishi = 0;//重新从0计时
		stopjishi = 0;//不停止计时，开始计时
		interval = setInterval(function(){
			if(stopjishi != 0){
				return;
			}
			$("#jishi").text("已耗时："+jishi++ +"秒");
		},1000);
		$("#jieshu").text("");//清空
	}
	$("#shuaxin").click(function(){
		//location.reload();
		jibie(gradeTemp);
	});
	function sendNumber(){
		var number = $("#number").val();
		//校验
		if (number=="") { 
	　　　　　　alert("不能为空"); 
	　　　　　　return false; 
	　　　　} 
　　　　if (!(/(^[1-9]\d*$)/.test(number))) {
　　　　　　alert("输入的不是正整数"); 
　　　　　　return false; 
　　　　}else {
		if(number>480){
			alert("数字不能过大"); 
			return false;
		}
	　 }
		$.post('<%=request.getContextPath()%>/sendNumber?number='+number,
			function(json){
				location.href = "<%=request.getContextPath()%>/saolei";
			});
	}
	var leis;
	getLeis(1);$("#leis").width(230);
	function getLeis(grade){
		$("#leis").html('');
		leis = 0;//点击等级之后，清零
		$.post('<%=request.getContextPath()%>/getLeis?grade='+grade,
				function(json){
						leis = json.leis;
						//private boolean hasLei;//此处有无雷
						//private int roundNum;//周围雷的个数。包括0个
						//private String leiIds;//周围雷的id。用,隔开
						for(var i = 1;i<=leis.length;i++){
							var hasLei = leis[i-1].hasLei;
							$("#leis").append("<button style='height: 25px;width: 25px;display:block;float:left; text-align:center;background-color:black;' "+
												"id='"+leis[i-1].id+"'"+
												"value="+leis[i-1].hasLei+":"+leis[i-1].roundNum+":"+leis[i-1].leiIds+":"+leis[i-1].roundIds+" "+
												"oncontextmenu='oct(this);'"+
												"onclick='ol(this);'"+
												"onmousemove='move(this);' "+
												"onmouseout='out(this);'>"+"口"+"</button>");
							
							
							/*if(hasLei == true){
								$("#leis").append("<span style='color:red;'>"+"雷"+"</span>");
							}else{
								$("#leis").append("<span style='color: black;'>"+leis[i-1].roundNum+"</span>");
							}*/
							var hh;
							if(grade==1)hh=9
							if(grade==2)hh=16
							if(grade==3)hh=30
							if(i % hh == 0){ //每30个就换行。
								$("#leis").append("<br />");
							}
						}
						
						leftLeiNumber();//左上角展示出来雷的总数量
				}	
		)
	}
	//阻止html默认的右键
	$("#leis").bind("contextmenu", function(){
    	return false;
	})
	//鼠标悬浮
	function move(ob){
    	$(ob).css("background-color","pink");
	}
	//鼠标悬浮移开
	function out(ob){
		
		var ob2 = $(ob).text();
		if(ob2 == "" || ob2 > 0 || ob2 == "雷" || ob2 == "×" || ob2 == "*"){ //叉号是踩到雷了
    		$(ob).css("background-color","#d6d5b6");
		}else{
    		$(ob).css("background-color","black");
		}
	
	}
	
	//双击(根本不存在双击事件，但是有左键按下、弹起事件（但也可有可无，用于提示当前方块的周围有哪8个方块用的） "ondblclick='shuangji(this)'"+)
	function shuangji(ob){
		
	}
	//鼠标单击
	function ol(ob){
		var currentText = $(ob).text();
		if(currentText == "雷" || currentText == "*"){
			return;
		}
		//                有无雷arr[0]     周围雷的数量arr[1]       周围雷的idsarr[2]      周围方块的idsarr[3]
		//"value="+leis[i-1].hasLei+":"+leis[i-1].roundNum+":"+leis[i-1].leiIds+":"+leis[i-1].roundIds+" "+
		var value = $(ob).attr("value");
		//切割字符串
		var arr=value.split(":");
		
		if(arr[0] == "true"){ //后台传的是boolean，应该是因为标签中拼字符串的缘故，拼成了"true"
			
			//排错之后显示所有雷的位置
			for(var i = 1;i<=leis.length;i++){
				//                有无雷arr[0]     周围雷的数量arr[1]       周围雷的idsarr[2]      周围方块的idsarr[3]
				//"value="+leis[i-1].hasLei+":"+leis[i-1].roundNum+":"+leis[i-1].leiIds+":"+leis[i-1].roundIds+" "+ 	
				
				var hasLei = leis[i-1].hasLei;
				var roundNum = leis[i-1].roundNum;
				if(hasLei == true){  //如果有雷的方块都有“雷”字，并且“雷”字的数量等于实际雷数，
					$("#"+i+"").text("雷");
		    		$("#"+i+"").css("color","red");
		    		$("#"+i+"").css("background-color","#d6d5b6");
				}else if(roundNum > 0){
					$("#"+i+"").text(roundNum);
					$("#"+i+"").css("color","blue");
					$("#"+i+"").css("background-color","#d6d5b6");
				}else if(roundNum == 0){
					$("#"+i+"").text("");
					$("#"+i+"").css("background-color","#d6d5b6");
				}
			}
			
    		$(ob).text("×");
    		$(ob).css("color","red");
    		$(ob).css("background-color","#d6d5b6");
    		stopjishi=1;
    		var a = $("#jishi").text();
			$("#leis").find("button").attr("disabled","disabled");
			$("#jieshu").text("×处有雷，游戏结束！");
			
		}else{
			//该方块没有雷。
			var g = arr[1];
			if(g != "0"){
				$(ob).text(g);
				$(ob).css("background-color","#d6d5b6");
			}else{
				$(ob).text("");
				$(ob).css("background-color","#d6d5b6");
			}
    		$(ob).css("color","blue");//到此点开了用户点击的方块，可以结束了。下面是为了扩展。
    		
    		//开始扩展功能
    		
    		if(arr[1] > 0 && currentText == "口"){ //当该方块显示的周围雷数量大于0时、并且当前方块未点开之前的text值为“口”，结束方法。（currentText == "口"这个条件是为了后面的闪烁用的）
    			return;//该if语句，也是结束单击产生的递归用的。
    		}
    		
    		if(arr[1] == 0){ //功能：如果该次单击的该方块roundNum为0，则展开周围无雷的方块（遇到含有roundNum不为0的就结束）
    			//拿到周围8个方块中的数字（先拿到他们的id，再根据id查找）
    			var roundIds = arr[3];
    			var roundIds2 = roundIds.split(",");
    			
    			for(var i=0;i<roundIds2.length;i++){ //遍历周围ids。1、什么时候，结束递归？现在的不能结束递归的原因是什么？
    				var id = roundIds2[i];//这是周围其中一个id
    				var value1 = $("#"+id+"").attr("value");//拿到周围一个id的value
    				var arr1=value1.split(":");//arr1[0]是周围一个id的有无雷
    				var m = $("#"+id+"").text();//周围一个id的text值
    				if(arr1[0] == "false" && m == "口"){ //无雷、并且尚未点开   
    					//单击该方块
    					$("#"+id+"").click();//测试证明会走ol()方法（自己调自己，循环递归）。
    				}
    			}
    			
    		}else if(arr[1] > 0){ //就是点到数字上了。该方块roundNum大于0。（单击时效果：几种情况，1、周围雷排完了，并且正确。2、周围有雷排错了。3、雷没有排完或者还没有排）
    			
    			//拿到该方块
    			
    			//拿到周围8个方块中的数字（先拿到他们的id，再根据id查找）
    			var roundIds = arr[3];
    			var roundIds2 = roundIds.split(",");
    			
    			var leiNumber = 0 ;
    			var kous = "";
    			
    			for(var i=0;i<roundIds2.length;i++){ //遍历周围ids。1、什么时候，结束递归？现在的不能结束递归的原因是什么？
    				var id = roundIds2[i];//这是周围其中一个id
    				var value2 = $("#"+id+"").attr("value");//拿到周围一个id的value
					//                有无雷arr[0]     周围雷的数量arr[1]       周围雷的idsarr[2]      周围方块的idsarr[3]
					//"value="+leis[i-1].hasLei+":"+leis[i-1].roundNum+":"+leis[i-1].leiIds+":"+leis[i-1].roundIds+" "+    				
    				var arr2=value2.split(":");//arr[0]是周围一个id的有无雷
    				var m = $("#"+id+"").text();//周围一个id的text值
    				if(m == "口"){
    					kous = kous+id+",";
    				}
    				if(m == "" || m > 0){ //已经点开了。不处理，跳过每次循环
    					continue;
    				}else{
    					if(arr2[0] == "true" && m == "雷"){//该方块排对了。
    						//如果全部正确的排完了，则单击剩余的方块，注意：调用单击方法
    						leiNumber++;
    					}else if(arr2[0] == "false" && m == "雷"){//排错了
    						
    						//排错之后显示所有雷的位置
    						for(var i = 1;i<=leis.length;i++){
    							//                有无雷arr[0]     周围雷的数量arr[1]       周围雷的idsarr[2]      周围方块的idsarr[3]
    							//"value="+leis[i-1].hasLei+":"+leis[i-1].roundNum+":"+leis[i-1].leiIds+":"+leis[i-1].roundIds+" "+ 	
    							
    							var hasLei = leis[i-1].hasLei;
    							if(hasLei == true){  //如果有雷的方块都有“雷”字，并且“雷”字的数量等于实际雷数，
    								$("#"+i+"").text("雷");
    					    		$("#"+i+"").css("color","red");
    					    		$("#"+i+"").css("background-color","#d6d5b6");
    							}else if(roundNum > 0){
    								$("#"+i+"").text(roundNum);
    								$("#"+i+"").css("color","blue");
    								$("#"+i+"").css("background-color","#d6d5b6");
    							}else if(roundNum == 0){
    								$("#"+i+"").text("");
    								$("#"+i+"").css("background-color","#d6d5b6");
    							}
    						}
    						
    						$("#"+id+"").text("*");
    						stopjishi=1;
    						var a = $("#jishi").text();
							$("#leis").find("button").attr("disabled","disabled");
							
							$("#jieshu").text("*处无雷，游戏结束！");
    					}
    				}
    				
    			}   
    			//已经正确排掉的雷的数量 == 该方块的周围雷数量  && 还有未点开的方块（kous中存储的就是周围尚未点击的方块id）	
    			if(leiNumber == arr[1] && kous != ""){
    				var kous2=kous.split(",");
    				for(var i=0;i<kous2.length;i++){
    					$("#"+kous2[i]+"").click();
    				}
    			}else{//闪烁，让此时text仍显示“口”的方块闪烁
    				var kous2=kous.split(",");
    				for(var i=0;i<kous2.length;i++){
    					if(i != kous2.length-1){
    						$("#"+kous2[i]+"").css("background-color","red");
    						}
    					}
    				setTimeout(function(){
    					for(var i=0;i<kous2.length;i++){
    					if(i != kous2.length-1){
    						$("#"+kous2[i]+"").css("background-color","black");
    						}
    					}
    				},100); 
    				
    				
    			}		
    		}
    		
    		
		}
		
	}
	//鼠标右键事件
	function oct(ob){
		var ob2 = $(ob).text();
		//如果格子中出现了数字，则是排雷成了，不能再更改
		if(ob2.indexOf("×") != -1 || ob2.indexOf("1") != -1 || ob2.indexOf("2") != -1 || ob2.indexOf("3") != -1 || 
		   ob2.indexOf("4") != -1 || ob2.indexOf("5") != -1 || ob2.indexOf("6") != -1 || ob2.indexOf("7") != -1 || ob2.indexOf("8") != -1){
			return;
		}
		if(ob2 == ""){
			return;
		}
		if(ob2 == "口"){	
    		$(ob).text("雷");
    		$(ob).css("color","red");
    		$(ob).css("background-color","#d6d5b6");
    		
    		var a = $("#leiShuliang").text();	
    		var a2 = a.split("：");
    		var number = a2[1];
    		
    		$("#leiShuliang").text("剩余数量："+(number-1));	
    		
		}else if(ob2 == "雷"){
    		$(ob).text("口");
    		$(ob).css("color","black");
    		var a = $("#leiShuliang").text();	
    		var a2 = a.split("：");
    		var number = a2[1];
    		
    		$("#leiShuliang").text("剩余数量："+(parseInt(number)+1));	
		}
		//每一次右键都遍历一次 var leis;
		var totalLeiNumber = 0;
		var biaojiLei = 0;
		for(var i = 1;i<=leis.length;i++){
			//                有无雷arr[0]     周围雷的数量arr[1]       周围雷的idsarr[2]      周围方块的idsarr[3]
			//"value="+leis[i-1].hasLei+":"+leis[i-1].roundNum+":"+leis[i-1].leiIds+":"+leis[i-1].roundIds+" "+ 	
			
			var hasLei = leis[i-1].hasLei;
			if(hasLei == true){  //如果有雷的方块都有“雷”字，并且“雷”字的数量等于实际雷数，
				totalLeiNumber++;//实际的雷数量
				
				var lei = $("#"+i+"").text();
				if(lei == "雷"){
					biaojiLei++; //标记的“雷”字数量
				}
			}
		}
		if(totalLeiNumber == biaojiLei){
			stopjishi = 1 ;
			var a = $("#jishi").text();
			
			//$("#jishi").text(a+"。恭喜你，胜利了！");
			var shengyu = $("#leiShuliang").text();
			if(shengyu.indexOf("-") != -1 ){
				return;//包含-，则不成功
			}
			if(shengyu.indexOf("0") != -1 ){
				//return;//包含0，则成功
				$("#jieshu").text("success！");
			}
			
			}
		
		
	}
    function leftLeiNumber(){
    	var totalLeiNumber = 0;
		for(var i = 1;i<=leis.length;i++){
			//                有无雷arr[0]     周围雷的数量arr[1]       周围雷的idsarr[2]      周围方块的idsarr[3]
			//"value="+leis[i-1].hasLei+":"+leis[i-1].roundNum+":"+leis[i-1].leiIds+":"+leis[i-1].roundIds+" "+ 	
			
			var hasLei = leis[i-1].hasLei;
			if(hasLei == true){  //如果有雷的方块都有“雷”字，并且“雷”字的数量等于实际雷数，
				totalLeiNumber++;//实际的雷数量
			}
		}
    	$("#leiShuliang").text("剩余数量："+totalLeiNumber);			
	}
		
</script>
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
