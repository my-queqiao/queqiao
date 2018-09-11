<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    	<meta charset="utf-8" />
        <title>留言</title>
</head>  
<body>
	<textarea id="liuyan" style="position: absolute;top: 5%;left: 10%;line-height: 20px;" rows="5" cols="100" placeholder="限制200字以内"></textarea>
	<input style="position: absolute;top: 18%;left:25%" type="button" onclick="leave();" value="确认留言" />
	
	<ul id="leaveMsg" style="position: absolute;color:;line-height: 25px;background-color: ;
    							left: 0%;top: 25%;height: 60%;width:90%;overflow:auto;">
               		
    </ul>
	
</body>
</html>

<script src="${request.contextPath!}/statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${request.contextPath!}/statics/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
	
<script>	
	function leave(){
		var ly = $("#liuyan").val();
		if(ly == ""){
			alert("不能为空");
			return;
		}
		//保存留言
		$.post('${request.contextPath!}/liuyanSaolei','liuyan='+ly,
				function(json){
					if(json.result == true){
						alert(json.msg);
						//刷新页面
						location.href="${request.contextPath!}/toLiuyanSaolei"
					}else{
						alert("留言失败");
					}
				}	
		)
	}
	getLeaveMsg();
	function getLeaveMsg(){ //获取留言列表
		$.post('${request.contextPath!}/getLeaveMsgSaolei',
				function(json){
					if(json.result == true){
						var lys = json.data;
						for(var i = 0;i<lys.length;i++){
							
							$("#leaveMsg").append("<li style='color:;'>"+lys[i].liuyan+"    "+lys[i].timeString+"</li>");
						}
						
					}else{
						alert("获取留言列表失败");
					}
				}	
		)
	}
</script>
        