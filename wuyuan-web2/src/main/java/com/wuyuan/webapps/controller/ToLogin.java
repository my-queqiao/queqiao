package com.wuyuan.webapps.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.annotation.Annotation;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketAddress;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.locks.ReentrantLock;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wuyuan.core.annotation.SecuObject;
import com.wuyuan.core.annotation.SecurityIgnoreHandler;
import com.wuyuan.webapps.biz.AuthorityBiz;
import com.wuyuan.webapps.biz.UserBiz;
import com.wuyuan.webapps.pojo.Authority;
import com.wuyuan.webapps.pojo.User;
import com.wuyuan.webapps.util.GetClassesByPackageUtil;

/**
 * 跳转到登录页面
 */
@Controller
@RequestMapping("/")
public class ToLogin {
	@Autowired
	private UserBiz userBiz;
	@Autowired
	private AuthorityBiz authorityBiz;
	/**
	 * 跳转到index页面（聊天页面）。
	 * @return
	 */
	@SecurityIgnoreHandler
	@RequestMapping("toLogin")
	public String toLogin(){
		
		/*HttpSession session = request.getSession();
		ServletContext servletContext = session.getServletContext();
		String realPath = servletContext.getRealPath("");*///F:\workspacesvn\wuyuan-web\src\main\webapp
		
		return "login";
	}
	@SecurityIgnoreHandler
	@RequestMapping("login")
	@ResponseBody
	public JSONObject register(String username,String password,HttpSession session){
		JSONObject json = new JSONObject();
		
		User user = userBiz.findByNameAndPassword(username,password);
		if(null != user){//存在该用户名
			json.put("result", true);
			json.put("msg", "登录成功");
			//更新最近上线时间
			userBiz.updateByUserName(username); //是否在线的更改没有用，可以去掉。
			//利用全局变量，设置一个访问首页的权限。
			MyConstants.security.put(username, session);
			
			/*2018年3月2日15:26:46 加入权限验证，
			 * 1、用户登录时，获取该用户的权限集合，用户id对应resource集合。
			 * 2、当用户访问某个url时，查看该url的安全权限注解是否在上面的集合中。
			 */
			List<Authority> auths = new ArrayList<Authority>();
			Set<Class<?>> classes = GetClassesByPackageUtil.getClasses("com.wuyuan.core.acl");
			for (Class c:classes) {
				Authority auth = new Authority();
				Annotation a = c.getAnnotations()[0];
				String resource = c.getName();
				String str = a.toString();
				int indexOf = str.indexOf("=");
				int indexOf2 = str.indexOf(")");
				String name = str.substring(indexOf+1, indexOf2);
				auth.setName(name);
				auth.setResource(resource);
				auths.add(auth);
			}
			//保存权限
			authorityBiz.saveBatch(auths);
			//通过中间表，获取该用户对应的权限集合。并放到session中。
			List<Authority> auths2 = authorityBiz.getAuths(user.getId());
			SecuObject secuObject = new SecuObject(user, auths2);
			session.setAttribute(username+"Authority", secuObject);
			session.setAttribute("currentUserName", user.getUserName());
			return json;
		}else{
			
			json.put("result", false);
			json.put("msg", "用户名或密码错误");
			return json;
		}
	}
	@SecurityIgnoreHandler
	@RequestMapping(value="/_permission_denied")
	public String _permissionDenied(
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			Model model
			) {
		return "/default_permission_denied";
	}

	@SecurityIgnoreHandler
	@RequestMapping(value="/_permission_undefined")
	public String _permissionUndefined(
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session,
			Model model
			) {
		return "/default_permission_undefined";
	}
	public static void main(String[] args){   
  
        jxl.Workbook readwb = null;   
  
        	try {
        	
            String filePath = "C:\\Users\\Joshua\\Desktop\\网点清单.xls";   
            File file = new File("C:\\Users\\Joshua\\Desktop\\网点清单.xls"); 
            Workbook wb = Workbook.getWorkbook(file); // 从文件流中获取Excel工作区对象（WorkBook）  
            Sheet sheet = wb.getSheet(0); // 从工作区中取得页（Sheet）  
            
            for (int i = 0; i < sheet.getRows(); i++) {   //外for是遍历每一行。
                if(i == 0){ //跳过列标题，从第二列读数据
                	continue;
                }
            	
            	for (int j = 0; j < sheet.getColumns(); j++) {  //内for循环，是遍历行中的每一列。
            		Cell cell = sheet.getCell(j, i); 
            		System.out.println(cell.getContents());
            	}
            }
        }catch(IOException e){
        	e.printStackTrace();
        } catch (BiffException e) {
			e.printStackTrace();
		}
        }  

}










