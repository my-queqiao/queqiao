<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <script src="${request.contextPath!}/statics/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${request.contextPath!}/statics/css/bootstrap.min.css" />
    <script src="${request.contextPath!}/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${request.contextPath!}/statics/js/city.min.js"></script>
</head>  

<style type="text/css">
body {
    background-color: #f8f6e9;
}
.welcome{
    margin-top: 50px;
    margin-left: 37%;
    margin-right: auto;
    color: #f95daf;
}
.mycenter{
    margin-top: 0px;
    margin-left: auto;
    margin-right: auto;
    height: 350px;
    width:1000px;
    padding: 5%;
    padding-left: 5%;
    padding-right: 5%;
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
#gender{
    position: relative;
    left: 10%;
    top: 7px;
}
</style>
	<h1 class="welcome">欢迎访问，一二三四五六七</h1>
	
            <div class="mycenter">
            <div class="mysign">
                <div class="col-lg-11 text-center text-info">
                    <h2>注册用户  （*必填）</h2>
                </div>
                <div class="col-lg-10">
                	<label  style="color:#f95daf;position: absolute;top: 35%;left: 3%;width: 10%;">账户名：</label>
                    <input type="text" class="form-control" id="username" name="username" required autofocus/>
                	<label id="username1" style="color:red;position: absolute;top: 35%;left: 110%;width: 20%;">*</label>
                </div>
                <div class="col-lg-10"></div>
                <div class="col-lg-10">
                	<label  style="color:#f95daf;position: absolute;top: 35%;left: 3%;width: 10%;">密码：</label>
                    <input type="password" class="form-control" id="password" name="password"  required autofocus/>
                    <label id="password1" style="color:red;position: absolute;top: 35%;left: 110%;width: 20%;">*</label>
                </div>
                <div class="col-lg-10">
                	<label  style="color:#f95daf;position: absolute;top: 35%;left: 3%;width: 10%;">性别：</label>
                    <select name="gender" id="gender" class="form-control">
    					<option value="">性别</option>
						<option value="男">男</option>
						<option value="女">女</option>
   					</select>
                    
                    <label id="gender1" style="color:red;position: absolute;top: 35%;left: 110%;width: 20%;">*</label>
                </div>
                <div class="col-lg-10">
                	<label  style="color:#f95daf;position: absolute;top: 35%;left: 3%;width: 10%;">居住地：</label>
							<div style="position: relative;    left: 8%;    top: 10px;">
							<div class="col-sm-5" style="width: 20%;">
								<select type="text" id="s_province" name="s_province"  class="form-control" >
								</select>
							</div>
							<div class="col-sm-5" style="width: 20%;">
								<select type="text" id="s_city" name="s_city"  class="form-control" >
								</select>
							</div>
                    		</div>
                    <label id="address1" style="color:red;position: absolute;top: 48%;left: 50%;width: 20%;">*</label>
                </div>
                <div class="col-lg-10">
                	<label  style="color:#f95daf;position: absolute;top: 35%;left: 3%;width: 10%;">出生地：</label>
                    <input type="text" class="form-control" id="birthplace" name="username"  required autofocus/>
                </div>
                <div class="col-lg-10">
                	<label  style="color:#f95daf;position: absolute;top: 35%;left: 3%;width: 10%;">生日：</label>
                    <input type="text" class="form-control" id="birthday" name="username" required autofocus/>
                </div>
                <div class="col-lg-10">
                	<label  style="color:#f95daf;position: absolute;top: 35%;left: 3%;width: 10%;">学历：</label>
                    <input type="text" class="form-control" id="education" name="username"  required autofocus/>
                </div>
                <div class="col-lg-10">
                	<label  style="color:#f95daf;position: absolute;top: 35%;left: 3%;width: 10%;">行业：</label>
                    <input type="text" class="form-control" id="industry" name="username"  required autofocus/>
                </div>
                <div class="col-lg-10">
                	<label  style="color:#f95daf;position: absolute;top: 35%;left: 3%;width: 10%;">职位：</label>
                    <input type="text" class="form-control" id="position" name="username"  required autofocus/>
                </div>
                <div class="col-lg-10">
                	<label  style="color:#f95daf;position: absolute;top: 35%;left: 3%;width: 10%;">收入：</label>
                    <input type="text" class="form-control" id="income" name="username"  required autofocus/>
                </div>
                <div class="col-lg-10">
                	<input type="text" id="code" name="code" class="mytxt" placeholder="验证码"/>
                           <img  id="img1" src="${request.contextPath!}/check.jpg" onclick="refresh()"> 
                    <label id="code1" style="color:red;position: absolute;top: 35%;left: 110%;width: 20%;">*</label>
                </div>
                <br/>
                <div class="col-lg-10">
                    <button style="color: rebeccapurple;" type="button" onclick="register()" class="btn btn-success col-lg-12">提交</button>
                </div>
            </div>
        </div>
	
</html>                

<script>

	 function refresh() {  
	    var url =  "${request.contextPath!}/check.jpg?number="+Math.random();  
	    $("#img1").attr("src",url);  
	} 
	
	init_city(); //省市二级联动。
	function register(){
		var b = validate();
		if(b == false){
			return;
		}
		var username = $("#username").val();
		var password = $("#password").val();
		var gender = $("#gender").val();
		
		
		var province = $("#s_province").val();
		var city = $("#s_city").val();
		var address = province+"-"+city;
		
		var birthplace = $("#birthplace").val();
		var birthday = $("#birthday").val();
		var education = $("#education").val();
		var industry = $("#industry").val();
		var position = $("#position").val();
		var income = $("#income").val();
		var code = $("#code").val();
		
		$.post('${request.contextPath!}/register','username='+username+'&password='+password+
				'&gender='+gender+'&address='+address+'&birthplace='+birthplace+'&birthday='+birthday+'&education='+education+'&industry='+industry+
				 '&position='+position+'&income='+income+'&code='+code,
				function(data){
					if(data.checkCode == "success"){
						
					}else if(data.checkCode == "验证码错误"){
						alert(data.checkCode);
					}else if(data.result == false){
						alert(data.msg);
					}else if(data.result == true){
						alert(data.msg);
						//跳转到展示好友列表   等等  页面
						window.location.href="${request.contextPath!}/toIndex?userName="+username
					}
				}	
		)
	}
	function validate(){
		var username = $("#username").val();
		var password = $("#password").val();
		var gender = $("#gender").val();
		var code = $("#code").val();
		
		var province = $("#s_province").val();
		var city = $("#s_city").val();
		
		if(username == ""){
			$("#username1").html("不能为空");
			return false;
		}
		if(password == ""){
			$("#password1").html("不能为空");
			return false;
		}
		if(gender == ""){
			$("#gender1").html("性别为必选项");
			return false;
		}
		if(province == "省份" || city == "地级市"){
			$("#address1").html("省市为必选项");
			return false;
		}
		if(code == ""){
			$("#code1").html("验证码为必选项");
			return false;
		}
		
	}
	
	
</script>
        