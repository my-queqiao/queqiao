<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    	<meta charset="utf-8" />
        <title>用户登录</title>
        <script src="${request.contextPath!}/statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="${request.contextPath!}/statics/css/bootstrap.min.css" />
        <script src="${request.contextPath!}/statics/js/bootstrap.min.js"></script>
</head>  

<style type="text/css">
body {
    background:url(../static/img/login_bg_0.jpg) #f8f6e9;
}
.welcome{
    margin-top: 80px;
    margin-left: 38%;
    margin-right: auto;
    color: #f95daf;
}
.mycenter{
    margin-top: 100px;
    margin-left: auto;
    margin-right: auto;
    height: 350px;
    width:500px;
    padding: 5%;
    padding-left: 5%;
    padding-right: 5%;
}
.mycenter mysign{
    width: 440px;
}
.mycenter input,checkbox,button{
    margin-top:2%;
    margin-left: 10%;
    margin-right: 10%;
}
.mycheckbox{
    margin-top:10px;
    margin-left: 40px;
    margin-bottom: 10px;
    height: 10px;
}

</style>
	<h1 class="welcome">欢迎访问，一二三四五六七</h1>
	<form action="login.php" method="post">
            <div class="mycenter">
            <div class="mysign">
                <div class="col-lg-11 text-center text-info">
                    <h2>请登录</h2>
                </div>
                <div class="col-lg-10">
                    <input type="text" class="form-control" id="username" name="username" placeholder="请输入账户名" required autofocus/>
                </div>
                <div class="col-lg-10"></div>
                <div class="col-lg-10">
                    <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码" required autofocus/>
                </div>
                <!-- <div class="col-lg-10"></div>
                <div class="col-lg-10 mycheckbox checkbox">
                    <input type="checkbox" class="col-lg-1">记住密码</input>
                </div> -->
                <div class="col-lg-10"></div>
                <div class="col-lg-10">
                    <button type="button" onclick="login()" class="btn btn-success col-lg-12">登录</button>
                </div>
                <br/>
                <div class="col-lg-10">
                    <button style="color: rebeccapurple;" type="button" onclick="toRegister()" class="btn btn-fail col-lg-12">注册账号</button>
                </div>
            </div>
        </div>
        </form>
	
</html>                

	
<script>	
	function toRegister(){
		location.href="${request.contextPath!}/toRegister"
	}
	function login(){
		var username = $("#username").val();
		var password = $("#password").val();
		$.post('${request.contextPath!}/login','username='+username+'&password='+password,
				function(data){
					if(data.result == false){
						alert(data.msg);
					}else if(data.result == true){
						//alert(data.msg);
						//跳转到展示好友列表   等等  页面
						location.href="${request.contextPath!}/toIndex?userName="+username
						
						
						
					}
				}	
		)
	}
	
</script>
        