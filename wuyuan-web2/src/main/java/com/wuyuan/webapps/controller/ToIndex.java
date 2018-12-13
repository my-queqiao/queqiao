package com.wuyuan.webapps.controller;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketAddress;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.Timer;
import java.util.TimerTask;
import java.util.UUID;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.locks.ReentrantLock;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wuyuan.core.acl.IndexRank;
import com.wuyuan.core.annotation.SecurityAccessCheckable;
import com.wuyuan.webapps.biz.UserBiz;
import com.wuyuan.webapps.pojo.Message;
import com.wuyuan.webapps.pojo.Message2;

/**
 * 2018年1月22日15:31:08 
 * @author lz
 * 第二版。不用udp，直接用jetty服务器转发用户之间的消息。（消息存放于静态的全局变量、队列中）废弃
 * 第三版。用websocket实现。
 */
@Controller
@RequestMapping("/")
public class ToIndex {
	/*static{ //项目启动时，执行一个定时器：MyConstants.message中的消息，删除其中24小时之前的消息。
		Timer timer = new Timer();
		timer.schedule(new TimerTask() {
			
			@Override
			public void run() {
				System.out.println("定时器清理消息开始清理。。"+new Date());
				List<Message> msgs = MyConstants.message;
				List<Message> msgs2 = new ArrayList<Message>();
				for(Message m:msgs){
					long msgTime = m.getDate().getTime();
					long nowTime = new Date().getTime();
					if(msgTime < nowTime-24*60*60*1000){
						msgs2.add(m);
					}
				}
				msgs.removeAll(msgs2);//移除消息中，24小时之前的消息。
			}
		}, new Date(), 1*60*60*1000L);// 延迟一秒执行，以后每隔一秒执行一次。（部署时执行，每小时执行一次）
	}*/
	@Autowired
	private UserBiz userBiz;
	
	/*@RequestMapping("toLaxian")
	public String toWs(String userName,Model model){
		return "include/laxian";
	}*/

	
	/**
	 * 跳转到index页面（聊天页面）。
	 * @return
	 */
	@SecurityAccessCheckable(resource=IndexRank.class)
	@RequestMapping("toIndex")
	public String toIndex(String userName,Model model,HttpSession session){//这是浏览器传过来的session
		
		//权限
		HttpSession sessionValue = (HttpSession)MyConstants.security.get(userName);//这个是该用户登录时对应的session。（如果相等则证明登录过了，不相等则没登录或者使用了其他人的账号）
		if(session.equals(sessionValue)){
			model.addAttribute("userName", userName);
			return "indexNew";
		}else{
			return "security";
		}
		
	}
	/**
	 * 解决用户刷新页面时，消息不见的问题。（暂存消息）
	 * @param userName
	 * @return
	 */
	@SecurityAccessCheckable(resource=IndexRank.class)
	@RequestMapping("recentMsg")
	@ResponseBody
	public JSONObject recentMsg(String userName){
		JSONObject json = new JSONObject();
		try {
			List<Message> list = MyConstants.message;
			System.out.println("集合中有消息吗："+list);
			List<Message2> res = new ArrayList<Message2>();//遍历拿到该用户的消息。
			if(null != list && !list.isEmpty()){
				for(Message msg:list){
					if(msg.getSendTo().equals(userName)){
						Message2 msg2 = new Message2();
						msg2.setMsg(msg.getMsg());
						res.add(msg2);
					}
				}
				json.put("data", res);
				System.out.println("res:"+res);
			}else{
				json.put("data", "");
			}
			
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			json.put("data", "");
			return json;
		}
	}
	
	
	
	
	/**
	 * @param msg   废弃（以下的方法都废弃了，暂不删除。）
	 * @return
	 */
	@RequestMapping("sendMsg")
	@ResponseBody
	public void sendMsg(HttpSession session,String userName,String sendTo,String msg){
		System.out.println("msg:"+msg);
		System.out.println("sendTo:"+sendTo);//发送给sendTo
		String rt = null;
		
		try {
			Object object = MyConstants.map.get(sendTo);
			if(null != object){
				
				BlockingQueue<String> sendToQueue = (BlockingQueue<String>)object;
				msg = userName+" ： "+msg; //谁发的消息，消息挂上谁的名字。
				sendToQueue.add(msg);
				System.out.println("sendToQueue:"+sendToQueue);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**  
	 * 发给浏览器。（只能用浏览器轮询了。）    废弃
	 * @param session
	 * @return
	 * 解决显示用户是否在线的问题：
	 * 1、开一个线程，定时往每一个用户的队列中存放一个空串消息。一分钟后，如果这条消息还在，说明该用户已经离线了（更新user表中用户状态即可）。
	 */
	@RequestMapping("receiveMsg")
	@ResponseBody
	public JSONObject receiveMsg(HttpSession session,String userName){
		JSONObject json = new JSONObject();
		try {
			//用户每调用一次这个方法，就设置一次在线(增加了io，不太好，暂不这样做。)
			Object object = MyConstants.map.get(userName);
			if(null != object){
				BlockingQueue<String> queue = (BlockingQueue<String>)object;
				while(true){//保持住长连接用的。 
					if(!queue.isEmpty()){
						String reply  = queue.take();
						json.put("msg", reply);
						return json;
					}
					//while死循环占用大量cpu，但是加上睡眠，占用的明显很小了。（睡眠放在if语句外面，不知道为什么偶然会发生接收不到消息的情况。）
					Thread.currentThread().sleep(500);
				}
			}
			return json;
				
			} catch (Exception e) {
				e.printStackTrace();
				return json;
			}
		
	}
	/**
	 * 用户上线。  废弃
	 * @param msg
	 * @param session
	 * @param from
	 * @return
	 */
	@RequestMapping("online")
	@ResponseBody
	public JSONObject online(HttpSession session,String userName){
		JSONObject json = new JSONObject();
		System.out.println(userName+":上线了");
		try {
				BlockingQueue<String> queue = new LinkedBlockingQueue<String>();//每次进入该页面，都给该用户一个新的队列。
				MyConstants.map.put(userName, queue);
				/**为每个用户提供一个永久的队列，这样用户可以收到离线消息（如果服务器重启，队列消失，这个功能也会暂时失效）*/
				
			/**下面这段代码存在一个问题。当页面刷新时，会出现接收不到一条数据的情况。（重新进入该页面时，都会发生这个问题）
			 * 因为：刷新前再调用receiveMsg方法，而且再pending等待中（即使刷新了页面，这个请求还是要回应，只是刷新后的页面接收不到了。）
			 * 如下，用原来的队列，则刷新页面后，接收到的消息会进入原来的队列，其中一条消息会给了刷新前的最后一次receiveMsg请求（这就导致刷新后的页面接收消息时，丢失一条）。
			 * 
			 * 解决办法：
			 * 1、每次进入该页面，给该用户一个新的队列（看receiveMsg方法，刷新前最后一次调用receiveMsg方法，这个请求还在旧的队列中拿消息，不会干扰新队列）。
			 * 但这样做，也产生一个新问题，用户离线消息收不到了。
			 */ 
			 /* Object object = MyConstants.map.get(userName);
			if(null == object){
				BlockingQueue<String> queue = new LinkedBlockingQueue<String>();//阻塞队列，什么意思？
				MyConstants.map.put(userName, queue);
			}*/
			/**页面每隔5分钟请求一下online方法(每次请求，服务端更新用户表)。而数据库，根据最近上线时间（上线时间小于当前时间6分钟的，即设置为离线）*/
			userBiz.updateByUserName(userName);
			json.put("result", true);
			json.put("msg", "您已上线");
			return json;
			
		} catch (Exception e) {
			e.printStackTrace();
			json.put("result", false);
			json.put("msg", "您上线时遇到未知错误，可尝试重新登录");
			return json;
		}
	}
	public static void main(String[] args) {
		List<Integer> list = new ArrayList<Integer>();
		List<Integer> list2 = new ArrayList<Integer>();
		list.add(1);
		list.add(2);
		list.add(3);
		list2.add(3);
		System.out.println(list);
		System.out.println(list2);
		boolean b = list.removeAll(list2);
		System.out.println(list);
	}
}



















