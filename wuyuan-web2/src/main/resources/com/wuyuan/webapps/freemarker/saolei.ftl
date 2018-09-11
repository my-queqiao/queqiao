<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    	<meta charset="utf-8" />
        <title>留言</title>
</head>  
<body onselectstart="return false"><!-- 该属性阻止html双击选中事件 -->
		
		<a href="${request.contextPath!}/toLiuyanSaolei" target="_blank" 
					style="position: absolute;left: 86%;top: 5%;color: black;font-family: 仿宋;font-size: 20px;cursor:pointer;">
						留言
					</a>
		
		<div id="leiShuliang" style="position: relative;margin-left: 30%;top: 17%;color:blue;">
			剩余雷数量：0
		</div>
		<div id="jishi" style="position: relative;margin-left: 64%;top: 17%;color:blue;">
			已耗时：0秒
		</div>
		
		<div id="leis" style="position: relative;margin-left: 30%;top: 20%;height: 400px;width: 750px;" >
		</div>
</body>
</html>

<script src="${request.contextPath!}/statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${request.contextPath!}/statics/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
	
<script>	
	var leis;
	getLeis();
	function getLeis(){ //获取留言列表
		$.post('${request.contextPath!}/getLeis',
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
							
							
							if(i % 30 == 0){ //每30个就换行。
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
    		$(ob).css("background-color","white");
		}else{
    		$(ob).css("background-color","black");
		}
	
	}
	
	//双击(根本不存在双击事件，但是有左键按下、弹起事件（但也可有可无，用于提示当前方块的周围有哪8个方块用的） "ondblclick='shuangji(this)'"+)
	function shuangji(ob){
		
	}
	//鼠标单击
	var stopjishi = 0;
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
    		$(ob).text("×");
    		$(ob).css("color","red");
    		$(ob).css("background-color","white");
    		stopjishi=1;
    		var a = $("#jishi").text();
			$("#leis").find("button").attr("disabled","disabled");
			$("#jishi").text(a+"。踩到雷了,游戏结束！");
    		
			alert("踩到雷了,游戏结束");
		}else{
			//该方块没有雷。
			var g = arr[1];
			if(g != "0"){
				$(ob).text(g);
				$(ob).css("background-color","white");
			}else{
				$(ob).text("");
				$(ob).css("background-color","white");
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
    						$("#"+id+"").text("*");
    						stopjishi=1;
    						var a = $("#jishi").text();
							$("#leis").find("button").attr("disabled","disabled");
							$("#jishi").text(a+"。*处排错了，游戏结束！");
    						
    						alert("*处排错了，游戏结束");
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
    		$(ob).css("backgroud-color","white");
    		
    		var a = $("#leiShuliang").text();	
    		var a2 = a.split("：");
    		var number = a2[1];
    		
    		$("#leiShuliang").text("剩余雷数量："+(number-1));	
    		
		}else if(ob2 == "雷"){
    		$(ob).text("口");
    		$(ob).css("color","black");
    		var a = $("#leiShuliang").text();	
    		var a2 = a.split("：");
    		var number = a2[1];
    		
    		$("#leiShuliang").text("剩余雷数量："+(parseInt(number)+1));	
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
			
			$("#jishi").text(a+"。恭喜你，胜利了！");
			
			alert("恭喜你，胜利了！");
			
			}
		
		
	}
	var jishi = 0;
		setInterval(function(){
					if(stopjishi != 0){
						return;
					}
    					$("#jishi").text("已耗时："+jishi++ +"秒");
    				},1000);
    				
    var totalLeiNumber = 0;
    function leftLeiNumber(){
		for(var i = 1;i<=leis.length;i++){
			//                有无雷arr[0]     周围雷的数量arr[1]       周围雷的idsarr[2]      周围方块的idsarr[3]
			//"value="+leis[i-1].hasLei+":"+leis[i-1].roundNum+":"+leis[i-1].leiIds+":"+leis[i-1].roundIds+" "+ 	
			
			var hasLei = leis[i-1].hasLei;
			if(hasLei == true){  //如果有雷的方块都有“雷”字，并且“雷”字的数量等于实际雷数，
				totalLeiNumber++;//实际的雷数量
			}
		}
    	$("#leiShuliang").text("剩余雷数量："+totalLeiNumber);			
	}
		
</script>
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        