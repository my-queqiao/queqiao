package com.wuyuan.webapps.controller.user;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketAddress;
import java.net.SocketException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.concurrent.locks.ReentrantLock;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wuyuan.core.acl.IndexRank;
import com.wuyuan.core.annotation.SecurityAccessCheckable;
import com.wuyuan.webapps.biz.UserBiz;
import com.wuyuan.webapps.pojo.User;

/**
 * 用户
 */
@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserBiz userBiz;
	@SecurityAccessCheckable(resource=IndexRank.class)
	@RequestMapping("getOtherUser")
	@ResponseBody
	public Map<String, Object> getOtherUser(int page,int rows,String userName,String search){
		JSONObject json = new JSONObject();
		Map<String, Object> map = userBiz.getAll(page,rows,search,userName);
		/*json.put("result",true);
		for(User user:users){
		}
		json.put("data", users);*/
		return map;
	}
	@RequestMapping("offline")
	@ResponseBody
	public JSONObject offline(){
		System.out.println("会离线吗？                           会离线吗？");
		return null;
	}
	@RequestMapping("talk")
	public String df(){
		
		return "talk";
	}
}










