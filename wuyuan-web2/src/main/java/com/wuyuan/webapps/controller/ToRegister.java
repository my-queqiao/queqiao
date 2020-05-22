package com.wuyuan.webapps.controller;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketAddress;
import java.net.SocketException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.concurrent.locks.ReentrantLock;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wuyuan.webapps.biz.UserBiz;
import com.wuyuan.webapps.util.CaptchaUtil;
import com.wuyuan.webapps.pojo.User;

/**
 * 用户注册
 */
@Controller
@RequestMapping("/")
public class ToRegister {
	@Autowired
	private UserBiz userBiz;
	
	@RequestMapping("toRegister")
	public String toIndex(){
		return "register";
	}
	@RequestMapping("register")
	@ResponseBody
	public JSONObject register(String username,String password,String gender,String address
			,String birthplace,String birthday,String education,String industry,String position
			,String income,String code,HttpSession session){
		JSONObject json = new JSONObject();
		
		User user = userBiz.findByName(username);
		if(null != user){//该用户名已经注册了
			json.put("result", false);
			json.put("msg", "该用户名已被注册了");
			return json;
		}else{
			
			String checkCode = checkCode(session, code);
			if(checkCode == "success"){//处理验证码
				session.setAttribute("code", "90A3233df");//由于session中可以存放该验证码一段时间，如果不置空、更改，可能有人利用这个验证码频繁注册。
			}else{
				json.put("checkCode", "验证码错误");
				return json;
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			User user2 = new User();
			user2.setUserName(username);
			user2.setPassword(password);
			user2.setGender(gender);
			user2.setAddress(address);
			user2.setBirthplace(birthplace);
			try {
				if(null!=birthday && !"".equals(birthday)){
					user2.setBirthday(sdf.parse(birthday));
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			user2.setEducation(education);
			user2.setIndustry(industry);
			user2.setPosition(position);
			user2.setIncome(income);
			user2.setOnline("离线");
			user2.setRecentOnline(new Date());
			user2.setCreateTime(new Date());
			userBiz.add(user2);
			//json.put("data", user2);
			json.put("result", true);
			json.put("msg", "注册成功");
			
			MyConstants.security.put(username, session);//利用全局变量，设置一个访问首页的权限。
			return json;
		}
	}
	
	/**
	 * 创建登录验证码，放到session中。     问题：有软件可以识别图片中的验证码。解决：验证码加上提示语，如2、3位置的字符颠倒输入、或者如有数字则加减等。
	 * （可想办法实现。这样的话，想破解，就需要程序理解这些话，这应该比较困难。
	 * 如果输入验证码错误，则该验证码失效，不给程序一次次测试的机会）
	 * @param request
	 * @param response
	 */
	@RequestMapping("/check.jpg")
	public void createCode(HttpServletRequest request, HttpServletResponse response){
		CaptchaUtil util = CaptchaUtil.Instance();  
        // 将验证码输入到session中，用来验证  
        String code = util.getString();  
        request.getSession().setAttribute("code", code);
        // 输出打web页面  
        try {
			ImageIO.write(util.getImage(), "jpg", response.getOutputStream());
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/** 
     * 验证码验证 
     *  
     * @param session 
     * @param code 
	 * @return 
     */  
    private String checkCode(HttpSession session, String code) {  
        String codeSession = (String) session.getAttribute("code");  
        if (StringUtils.isEmpty(codeSession)) {  
           // log.error("没有生成验证码信息");  
            throw new IllegalStateException("ERR-01000");  
        }  
        if (StringUtils.isEmpty(code)) {  
            //log.error("未填写验证码信息");  
            //throw new BussinessException("ERR-06018");  
        }  
        if (codeSession.equalsIgnoreCase(code)) {//忽略大小写  
            // 验证码通过
        	return "success";
        } else {  
            //log.error("验证码错误");  
            //throw new BussinessException("ERR-06019");  
        }
		return "fail";  
    }
    /**
     * 程序自动注册用户。 （防止这种做法：只需要注册成功一次之后，将该session对应的验证码删掉就可以了。）
     */
    public void autoRegister(){
    	HttpClient httpClient = new HttpClient();
		Integer a = 0;
		while(true){
			Map<String, String> params = new HashMap<String, String>();
			params.put("username", "re1"+a.toString());
			params.put("password", "45");
			params.put("gender", "?");
			params.put("code", "jbix");
			//params.put("address", "北京市-昌平区");
			String url = "http://39.106.188.246:8080/queqiao/register";
			//String res = HttpClientUtil.getInstance().httpPost(url, params);
			//String res = httpClient.httpPost(url, params);
			
			Map<String, String> headMap = new HashMap<String, String>();
			//headMap.put("Content-Type", "application/json"); 
			//headMap.put("charset", "UTF-8");
			//headMap.put("User-Agent", "Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36");
			headMap.put("Cookie", "JSESSIONID=043B08A87BDAB2AEA1F2D56CC5E43C42");//头中放入这个，就模拟了浏览器的session。（大概tomcat服务器就根据这个cookie来判断是哪个session的）
			
//			String res = httpClient.httpPost(url, params, headMap);
//			new HttpMethod
//			httpClient.executeMethod(method);
//			System.out.println("res:"+res);
			a++;
		}
    }
    
}



















