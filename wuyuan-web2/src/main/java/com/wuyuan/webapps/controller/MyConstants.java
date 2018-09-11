package com.wuyuan.webapps.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wuyuan.webapps.pojo.Message;

/**
 * 常量
 * @author admin
 *
 */
public interface MyConstants {
 /* session中属性的记录，可以写到这儿
  * session.setAttribute(username+"Authority", secuObject);
	session.setAttribute("currentUserName", user.getUserName());
	*/	
	//注意，map键是唯一的。
	static Map<String,Object> map =	new HashMap<String, Object>();//聊天功能存放<userName,session>（每个用户对应的ip、端口）
	static Map<String,Object> security =	new HashMap<String, Object>();//控制进入首页的权限
	static Map<String,Object> online =	new HashMap<String, Object>();//查看用户是否在线
	
	//static Map<Date, HashMap<String,Object>> message =	new HashMap<Date, HashMap<String,Object>>();//暂存用户聊天记录
	static List<Message> message =	new ArrayList<Message>();//暂存用户聊天记录
	
}
