<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <script src="${request.contextPath!}/statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${request.contextPath!}/statics/css/bootstrap-table/bootstrap-table.css"/>
	<link href="${request.contextPath!}/statics/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	
    
</head>

<style type="text/css">
@media screen and (max-width: 1400px) { /*当屏幕尺寸，小于1400px时，应用下面的CSS样式*/
	
}
@media screen and (min-width: 1400px) { /*当屏幕尺寸，大于1400px时，应用下面的CSS样式*/

}
body {
    //background-color: #f8f6e9;
    background-color: pink;
}
.welcome{
    margin-top: 45px;
    margin-left: 38%;
    margin-right: auto;
    color: #f95daf;
}
#userList{
	    position: absolute;
    	width: 80%;
   	 	left: 18%;
   	 	top: 200px;
}
#gender{
	position: relative;
    left: 160px;
    top: -155px;
}
#user{
    position: relative;
    left: 10px;
    top: -90px;
}
#talk{
    position: relative;
    left: -85px;
    top: -20px;
    cursor:pointer;
}
.zaixian{
    position: relative;
    left: 145px;
    top: -113px;
}
#shangcidenglu{
    position: relative;
    left: 116px;
    top: -63px;
}
#chat
{
    position:absolute;
    width:400px;
    height:450px;
    border:1px solid #333333;
    background-color:#f1f1f1;
    text-align:center;
    line-height:400%;
    font-size:13px;
    left:78%;
    top:300px;
}
#top{
    height: 125px;
    background-color: pink;
    top: 0px;
    position: absolute;
    width: 100%;
}
</style>
<body>
				<div id="top">
					<h1 class="welcome">欢迎访问，一二三四五六七</h1>
					<div style="position: absolute;left: 4%;top: 10%;">
						welcome，${userName}
					
					</div>
				</div>
			<!--
				<div style="position: absolute;
    						left: 8%;
    						top: 25%;" id="userList">
					<span>用户列表，单击用户后可与其聊天</span><br />
				</div>
					
                <ul id="receive" style="position: absolute;color:red;
    							left: 30%;
   								top: 25%;">
               		
                </ul>
                <div style="    position: absolute;
    							left: 60%;
   								top: 3%;">
               		<input style="width: 100%;" id="xinxi" type="text" />
               		<input id="btn-xinxi" type="button" value="请先选择用户" onclick="send();" />
               		<input id="btn-xinxi2"  hidden/>
                </div> 
          -->
					<ul  id="userList">
						
					</ul>
					<div id="chat" hidden>
						<input style="position: relative;width: 10%;height: 8%;line-height: 4px;left: 75%;" type="button" onclick="yincang();" value="隐藏" />
						<input id="talkTo" type="button" style="position: relative;width: 60%;height: 8%;line-height: 4px;left: -24%;background-color: bisque;" />
						
							<ul id="receive" style="position: absolute;color:red;line-height: 25px;text-align:center;text-align:left;
    							left: 0%;top: 12%;height: 300px;width:398px;overflow:auto;">
               		
               				</ul>
						
						
						<textarea id="xinxi" style="height: 80px;position: relative;top: 70%;left: -6%;line-height: 20px;" rows="3" cols="40"></textarea>
						<input style="position: relative;top: 72%;" type="button" onclick="send2();" value="发送" />
					</div>
	</body>					
</html>
<script type="text/javascript">
	var Newpage=${Newpage!'1'}
	var colentpage=Newpage;
</script>
	
    <script type="text/javascript" src="${request.contextPath!}/statics/js/plugins/bootstrap-table/bootstrap-table.js"></script>
<script type="text/javascript">
	
	//下面这个方法，是自动执行的。（获取用户列表）
	$.post('${request.contextPath!}/user/getOtherUser?page=1&rows=10',
		function(data){
			$("#userList").append("<li>总计："+data.total+" 人</li>");
				var rows = data.rows;
				for(var i =0;i<rows.length;i++){
				$("#userList").append("<li style='float:left;width: 30%;'>"+
						"<img style='width: 150px;height: 200px;' src='${request.contextPath!}/statics/img/"+rows[i].userName+"/1.jpg'/>"+
						"<span id='user'>"+rows[i].userName+"</span><br/>"+
						"<span id='gender'>"+rows[i].gender+"</span>"+
						"<span class='zaixian' id="+rows[i].userName+">"+rows[i].online+"</span>"+
						"<span id='shangcidenglu'>"+"最近登录："+rows[i].recentOnline2+"</span>"+
						"<span id='talk'>"+"<a onclick='openwin(\""+rows[i].userName+"\")'>聊天<a>"+"</span>"+
						"</li>");
				}
				$("#${userName}").html("<span style='color:#f95daf;'>在线</span>");//确保列表展示完，再执行。
		});
		
	//打开聊天窗口
	var talkTo;
	function openwin(obj) {
		//alert("obj:"+obj);
		talkTo = obj;
		$("#talkTo").val("与 "+obj+" 聊天中。。。");
}   
    //用于显示“提示已上线”的消息
    openwin2();                   //进去该页面时，开启聊天窗口
	function openwin2() {
		$("#chat").show();
		//可拖曳悬浮框		
var _move=false;//移动标记
var _x,_y;//鼠标离控件左上角的相对位置
    $("#chat").click(function(){
        //点击（松开后触发）
        }).mousedown(function(e){
        _move=true;
        _x=e.pageX-parseInt($("#chat").css("left"));
        _y=e.pageY-parseInt($("#chat").css("top"));
        $("#chat").fadeTo(20, 0.25);//点击后开始拖动并透明显示
    });
		$(document).mousemove(function(e){
        if(_move){
            var x=e.pageX-_x;//移动时根据鼠标位置计算控件左上角的绝对位置
            var y=e.pageY-_y;
            $("#chat").css({top:y,left:x});//控件新位置
        }
    }).mouseup(function(){
    _move=false;
    $("#chat").fadeTo("fast", 1);//松开鼠标后停止移动并恢复成不透明
	});
}   
    //隐藏聊天窗口，（暂没有作用）。 
	function yincang() {  
		$("#chat").hide();

    }    
		//发送聊天信息
    	function send2(){
	
		var sendTo = talkTo;//发送给 sendTo
		var msg = $("#xinxi").val();
		if(null == sendTo || "" == sendTo){
			alert("请先选择用户");
			return;
		}
		if(null == msg || ""==msg){
			alert("消息不能为空");
			return;
		}
		$("#receive").append("<li>我： "+msg+"</li>");
		
				$.post('${request.contextPath!}/sendMsg',"msg="+msg+"&sendTo="+sendTo+"&userName=${userName}",
						function(data){
							$("#xinxi").val("");
							//alert(data);
						});
		gun();
	}
	//出现新内容时，滚动条，自动滚到最底部。
	function gun(){
                    var div = document.getElementById('receive');
                    div.scrollTop = div.scrollHeight;
                }	
	//刚进入首页的用户，自动上线。 关闭该页面时，可以设置下线吧？
	online2();
	function online2(){
		$.post('${request.contextPath!}/online',"userName=${userName}",
						
						function(data){
								receive2();
							if(data.result == false){
								$("#receive").append("<li style='color:green;'>"+data.msg+"</li>");
							}else if(data.result == true){
								$("#receive").append("<li style='color:green;'>"+data.msg+"</li>");
							}
						});
	}	
	
	//用于轮询，接收消息
	function receive2(){
	
		$.post('${request.contextPath!}/receiveMsg',"userName=${userName}",
						
						function(data){
							//$("#receive").html(data.msg);
							if(data.msg != ""){
								$("#receive").append("<li style='color:green;'>"+data.msg+"</li>");
								gun();
							}
							setTimeout("receive2();",100)//延时100毫秒后，触发
						});
	}	
		
		
	
</script>
        