<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="${request.contextPath!}/statics/css/bootstrap-table/bootstrap-table.css"/>
	<link href="${request.contextPath!}/statics/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    
	
    
</head>

<style type="text/css">
@media screen and (max-width: 1400px) { /*当屏幕尺寸，小于1400px时，应用下面的CSS样式*/
	
}
@media screen and (min-width: 1400px) { /*当屏幕尺寸，大于1400px时，应用下面的CSS样式*/

}
body {
    //background-color: #7f9dc3;
    //background-color: pink;
  width: 100%;
  height:auto;
  background:url("${request.contextPath!}/statics/img/cover.jpg") no-repeat;
  background-size: 100%;
}
.welcome{
    margin-top: 20px;
    margin-left: 38%;
    margin-right: auto;
    color: lightslategrey;
    font-family: 仿宋;
    font-weight: 800;
    position: absolute;
}
#chat{
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



.show { 
background: transparent; 
text-align: center; 
z-index: 2; 
width: 400px; 
height: 400px; 
} 

.title {
background: #C0C0C0; 
width: 400px 
} 

</style>
<body id="container">
					<h1 class="welcome">欢迎访问，一二三四五六七</h1>
					<div style="position: absolute;left: 4%;top: 10%;    color: chocolate;">
						欢迎，${userName}
					</div>
					<a href="${request.contextPath!}/toLiuyan?userName=${userName}" target="_blank" style="position: absolute;left: 96%;top: 2%;color: aliceblue;font-family: 仿宋;font-size: 20px;cursor:pointer;">
						留言
					</a>
				
					<!-- 用bootstrap展示列表 -->
<section class="content" style="width: 70%;position: absolute;left: 15%;top: 10%;  color: lightyellow;  font-family: 仿宋;">
					<table id="myDatatable" data-toggle="table" data-url="${request.contextPath!}/user/getOtherUser?userName=${userName}"
						data-side-pagination="server" data-show-refresh="true" data-show-toggle="false" data-show-columns="false"
						data-pagination="true" data-search="true"  data-field-text="根据用户名查询"
						data-page-list="[10, 25, 50, 100, 200]">
						<thead>
							<tr>
							    <!-- <th data-checkbox="true"></th> -->
								<th data-field="userName" data-formatter="userNameFormatter" data-events="operateEvents" data-align="left">用户名</th>
								<th data-field="gender" data-align="left" data-sortable="false" >性别</th>
							    <th data-field="address" data-align="left" data-sortable="false">所在地</th>
								<th data-field="birthplace" data-align="left"  data-sortable="false">出生地</th>
							    <th data-field="birthday" data-align="left" data-sortable="false">生日</th>
								<th data-field="education" data-align="left"  data-sortable="false">学历</th>
								<th data-field="industry" data-align="left"  data-sortable="false">行业</th>
								<th data-field="position" data-align="left"  data-sortable="false">职位</th>
								<th data-field="online" data-formatter="onlineFormatter" data-align="center"  data-sortable="false">是否在线</th>
								<th data-field="recentOnline2" data-align="left"  data-sortable="false">最近上线</th>
								<th data-field="declaration" data-align="left"  data-sortable="false">想说的话</th>
								<th  data-events="operateEvents" data-align="center" data-formatter="operateFormatter" data-sortable="true">操作</th>
							</tr>
						</thead>
					</table>
					</section>
<!--聊天浮动窗口-->
<div id = "chuangkou">
<div id="preWin" style="top: 50%;position: absolute;left: 64%;border: 1px solid #333333;" class="show">
    <div id="title" class="title"> 
		<input id="talkTo" type="button" style="position: relative;width: 91%;height: 8%;line-height: 20px;left: -4%;background-color: burlywood;" value="点击在线聊天，可以与其聊天"/>
			<span style="position: absolute;left: 92%;" onClick="closePreWin();">关闭</span> 
	</div>
	<div id="pre">
						
							<ul id="receive" style="position: absolute;color:green;line-height: 25px;text-align:center;text-align:left;background-color: darkseagreen;
    							left: 0%;top: 7%;height: 76.4%;width:100%;overflow:auto;">
               		
               				</ul>
						
						
		<textarea id="xinxi" style="position: absolute;top: 83.5%;left: 0%;line-height: 20px;" rows="3" cols="40" value="fs"></textarea>
		<input style="position: absolute;top: 88%;left:78%" type="button" onclick="echo();" value="Enter 发送" />
	</div>
</div>
</div> 
	<!--右下角的龙猫-->
	<img id="cat" onclick="openTalk();" src="${request.contextPath!}/statics/img/timg.gif" style="top: 60%;position: absolute;left: 85%;width: 14%;" hidden>
	<span id="cat2" style="top: 60%;position: absolute;left: 85%;width: 13%;color:red;font-family: 仿宋;font-weight: 800;">
		
	</span>
	</body>
</html>
<script type="text/javascript">
	var Newpage=${Newpage!'1'}
	var colentpage=Newpage;
</script>
	<script src="${request.contextPath!}/statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="${request.contextPath!}/statics/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${request.contextPath!}/statics/js/plugins/bootstrap-table/bootstrap-table.js"></script>
    <script type="text/javascript" src="${request.contextPath!}/statics/js/lizi.js"></script>
    <script src="${request.contextPath!}/statics/js/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript">

function operateFormatter(value, row, index) {
      return ["<a class='liaotian' style='color:#43a4f5;' href='javascript:;'>在线聊天</a>&nbsp| "+
      "<a class='xinjian' style='color:#43a4f5;' href='javascript:;'>离线信件</a>" ].join("");
}
var talkTo;
    function openPicture(obj){
    //obj.text 店长
    	$("#"+obj.text+"").show();
    	$("#"+obj.text+"").click(function(){
    		//alert("dfdfdfd");
    	});
    }
    function closePicture(obj){
    	$("#"+obj.text+"").hide();
    }
window.operateEvents = {
        'click .liaotian': function (e, value, row, index) {
				//alert(row.userName);
				talkTo = row.userName;
				$("#talkTo").val("与 "+row.userName+" 聊天中。。。");
				$("#chuangkou").show();
				$("#xinxi").focus();//让鼠标聚焦在该标签
				
        }, 
        'click .xinjian': function (e, value, row, index) {
				alert("尚未开通");
        }
	}

	function userNameFormatter(value, row, index) {
      return ["<a class='userName' style='color:#43a4f5;position: absolute;width: 9%;' onmouseover='javascript:openPicture(this);' onmouseout='closePicture(this)'>"+
 "<img id='"+value+"' style='position:absolute;left:-220%;width:240px;height:240px;display:none;' src='${request.contextPath!}/statics/img/"+value+"/1.jpg'>"+value+"</a>"].join("");
	}
	function onlineFormatter(value, row, index) {
		if(value == "在线"){
      		return ["<span style='color: red;font-family: 仿宋;font-weight: 800;font-size: 20px;'>"+"在线"+"</span>"].join("");
		}else{
      		return ["<span style='color: black;font-family: 仿宋;font-weight: 800;font-size: 20px;'>"+"离线"+"</span>"].join("");
		}
	}
	function onlineFormatterFeiqi(value, row, index) {
		if(value == '在线'){
      		return ["<span style='color: red;font-family: 仿宋;font-weight: 800;font-size: 20px;'>"+value+"</span>"].join("");
		}else{
			return ["<span style='color: black;font-family: 仿宋;font-weight: 800;font-size: 20px;'>"+value+"</span>"].join("");
		}
	}

$("#chuangkou").hide();
$("#cat").show();
//下面是聊天功能
function closePreWin(){  //关闭聊天窗口
       //preWin.style.display = "none"; 
       $("#chuangkou").hide();
       $("#cat").show();
} 
     a();
      function a(){  
            $(".title").mousedown(function(e){ //e鼠标事件  
              
                $(this).css("cursor","move");//改变鼠标指针的形状  
                  
                var offset = $(this).offset();//DIV在页面的位置  
                var x = e.pageX - offset.left;//获得鼠标指针离DIV元素左边界的距离  
                var y = e.pageY - offset.top;//获得鼠标指针离DIV元素上边界的距离  
                $(document).bind("mousemove",function(ev){ //绑定鼠标的移动事件，因为光标在DIV元素外面也要有效果，所以要用doucment的事件，而不用DIV元素的事件  
                  
                    $(".show").stop();//加上这个之后  
                      
                    var _x = ev.pageX - x;//获得X轴方向移动的值
                    var _y = ev.pageY - y;//获得Y轴方向移动的值
                      
                    $(".show").animate({left:_x+"px",top:_y+"px"},10);  
                });  
                  
            });  
              
            $(document).mouseup(function() {  
                $(".title").css("cursor","default");  
                $(this).unbind("mousemove");  
            })  
        }; 
        
	//出现新内容时，滚动条，自动滚到最底部。
	function gun(){
                    var div = document.getElementById('receive');
                    div.scrollTop = div.scrollHeight;
                }
    function openTalk(){//打开聊天窗口
    	$("#chuangkou").show();
    	$("#xinxi").focus();//让鼠标聚焦在该标签
    	$("#cat2").text("");
    }
	
	
	//以下是ws
		var ws = null;  
        var url = null;  
        var transports = []; 
         //updateUrl('/queqiao/websocket'); //给出ws服务端url
         //connect(); //连接ws服务端
         //setTimeout("echoFirst();",1000);//延时2000毫秒后，触发。等待与ws服务端连接成功（2秒时间经过测试足够连接成功了）。
         
        function setConnected(connected) {  
            //document.getElementById('connect').disabled = connected;  
            //document.getElementById('disconnect').disabled = !connected;  
            //document.getElementById('echo').disabled = !connected;
        }  
  
        function connect() {  
            //alert("url????:"+url);  
            if (!url) {  
                alert('Select whether to use W3C WebSocket or SockJS');
                return;  
            }  
  
            ws = (url.indexOf('sockjs') != -1) ?   
                new SockJS(url, undefined, {protocols_whitelist: transports}) : new WebSocket(url);  
  
            ws.onopen = function () {  //连接ws服务端
                //setConnected(true);  
                //log('Info: connection opened.'); 
            };  
            ws.onmessage = function (event) {  //接收ws服务端的消息。
                //log('Received接收: ' + event.data); 
                
                //  "defa5d41-6177-4803-90a9-c43437614ea6欢迎"+userName+"，您已上线"
                var tou = event.data.indexOf("defa5d41-6177-4803-90a9-c43437614ea6欢迎");
                if(tou != -1 ){ //应该是 0 ，即存在。（查看是否在线的消息）
                	var douhao = event.data.indexOf("，");
                	var huanying = event.data.indexOf("迎");
                	var uname = event.data.substring(huanying+1,douhao);
                	//alert("uname:"+uname);
                	$("#"+uname+"").text("在线"); //这种设置在线的方式，其他用户看不到该用户的状态。因为其他用户根本不会执行这个js方法。（达不到目的，只能该用户自己看看）。需要一个全局变量来实现。
                	$("#"+uname+"").css({color:"red"}); 
                }else{
                	//聊天消息
                	$("#receive").append("<li style='color:red;'>"+event.data+"</li>");
               	 	if($("#chuangkou").is(":hidden")){
									$("#cat2").text("您有新消息，点我查看（可以保存对方的最近24小时之内的消息）");
									//setInterval(function(){ $("#cat2").fadeOut(100).fadeIn(100); },50); 
								}
                 
                	gun();
                }
                
            };  
            ws.onclose = function (event) {  
                //setConnected(false);  
                //log('Info: connection closed.');  
                //log(event);  
            };  
        }  
  
        function disconnect() {  
            if (ws != null) {  
                ws.close();  
                ws = null;  
            }  
            setConnected(false);  
        }  
  
        function echo() {  
            if (ws != null) {  
                //var message = document.getElementById('message').value;  
                //log('Sent: ' + message);  
                
        var sendTo = talkTo;//发送给 sendTo
		if(null == sendTo || "" == sendTo){
			alert("请先选择用户");
			return;
		}
                
                
        var message = $("#xinxi").val();
		if(null == message || "" == message){
			alert("消息不能为空");
			return;
		}
                ws.send("${userName}defa5d41-6177-4803-90a9-c43437614ea6"+sendTo+":"+message);
                $("#receive").append("<li>我： "+message+"</li>");
                $("#xinxi").val("");
                $("#xinxi").focus();//让鼠标聚焦在该标签
                gun();
            } else {  
                alert('connection not established, please connect.(与服务端连接未建立，请刷新页面重试)');
            }  
        }  
        function echoFirst() {  
            if (ws != null) {  
                 
                ws.send("${userName}:上线了");
                setTimeout("echoFirst();",10000);//每十秒发送一次，用于监测用户是否在线。（服务端只要收到这条消息，就说明用户在线。）
            } else {  
                alert('connection not established, please connect.(与服务端连接未建立，请刷新页面重试)');  
            }  
        }  
  
        function updateUrl(urlPath) {
        
        //alert("updateUrl(urlPath):"+urlPath); 
         
            if (urlPath.indexOf('sockjs') != -1) {  
                url = urlPath;  
                document.getElementById('sockJsTransportSelect').style.visibility = 'visible';  
            }  
            else {  
              if (window.location.protocol == 'http:') {  
                  url = 'ws://' + window.location.host + urlPath;  
              } else {  
                  url = 'wss://' + window.location.host + urlPath;  
              }  
              //document.getElementById('sockJsTransportSelect').style.visibility = 'hidden';  
            }  
        }  
  
        function updateTransport(transport) {  
            alert("????"+transport);  
          transports = (transport == 'all') ?  [] : [transport];  
        }  
          
        /**function log(message) {  
            var console = document.getElementById('console');  
            var p = document.createElement('p');  
            p.style.wordWrap = 'break-word';  
            p.appendChild(document.createTextNode(message));  
            console.appendChild(p);  
            while (console.childNodes.length > 25) {  
                console.removeChild(console.firstChild);  
            }  
            console.scrollTop = console.scrollHeight;  
        }  */
	document.onkeydown = function(e) { //按回车发送消息
			    var e = e || event;
			    if(e.keyCode == 13) {
			　 　 setTimeout(function(){
			            echo();
			        },0);
			        e.preventDefault ? e.preventDefault() : (e.returnValue = false);
			    }
			}
	//跟随鼠标移动的粒子效果
	$(".sketch").css({width: '100%', height: '100%'});
	// 服务器暂存最近10分钟之内的聊天记录。（解决刷新页面时，消息不见的问题。） 后台将消息放入一个全局变量中，每次刷新页面时，ajax请求这些数据。
	//  $("#receive").append("<li style='color:red;'>"+event.data+"</li>");
	recentMsg();
	function recentMsg(){
		$.post('${request.contextPath!}/recentMsg','userName=${userName}',
				function(json){
					if(json.data != ""){ //data是一个list集合
					
						 for(var i=0; i<json.data.length; i++) {
      							$("#receive").append("<li style='color:red;'>"+json.data[i].msg+"</li>");
      						}
      
					}else{
						
					}
				}	
		)
	}
	//留言
	function liuyan(){
		
	}
</script>
        