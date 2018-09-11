package com.wuyuan.webapps.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.TextMessage;  
import org.springframework.web.socket.WebSocketSession;  
import org.springframework.web.socket.handler.TextWebSocketHandler;  

import com.wuyuan.webapps.pojo.Message;
public class WebsocketEndPoint extends TextWebSocketHandler {  
    @Override  
    protected void handleTextMessage(WebSocketSession session,TextMessage message) throws Exception {  
        super.handleTextMessage(session, message);  
        /**
         * session中含有发给谁的url。 可以用userName对应其自己的session，保存起来。再根据message含有的信息，判断发给谁。
         * 
         * 浏览器客户端，每次进入聊天页面时，自动执行一个方法（发送消息到ws服务端，服务端保存userName：session）。 
         * 
         * 聊天时，每条消息携带发送者、接收者姓名即可。
         */
        /**
         * 店长defa5d41-6177-4803-90a9-c43437614ea6店长:3 received at server （前者from携带消息，发送信息。 根据后者sendTo找到对应的session）
         */
        String payload = message.getPayload();
        if(!payload.contains("defa5d41-6177-4803-90a9-c43437614ea6")){//1、上线。保存userName对应session到全局静态map中。
        	int indexOf = payload.indexOf(":");
        	String userName = payload.substring(0, indexOf);
        	
        	//判断用户是否在线。方法：用一个静态全局map变量，存储<userName,当前时间>。然后在获取用户列表方法，遍历list，用户时间小于当前时间15秒的online为离线。
        	MyConstants.online.put(userName, new Date());
        	
        	MyConstants.map.put(userName, session);//用于存储该用户对应的ip、端口。
        	//TextMessage returnMessage = new TextMessage("defa5d41-6177-4803-90a9-c43437614ea6欢迎"+userName+"，您已上线");
        	//session.sendMessage(returnMessage);
        }else{//2、聊天
        	String[] split = payload.split("defa5d41-6177-4803-90a9-c43437614ea6");
    		//String sub = str.substring(0, indexOf);
    		System.out.println(split[0]+"----"+split[1]);
    		int indexOf = split[1].indexOf(":");
    		
    		String sendTo = split[1].substring(0, indexOf);
    		String from = split[0];
    		String msg = split[1].substring(indexOf+1);
    		
    		/*WebSocketSession session2 = (WebSocketSession)MyConstants.map.get(sendTo);
    		TextMessage returnMessage = new TextMessage(from+"："+msg);
    		session2.sendMessage(returnMessage);*/
    		Object object = MyConstants.map.get(sendTo);
    		if(null != object ){
    			WebSocketSession session2 = (WebSocketSession)object; //session中含有接收一方的ip、端口。
    			String msg2 = from+"："+msg;
    			TextMessage returnMessage = new TextMessage(msg2);
    			
    			//解决刷新页面时，消息不见的问题。 方法：将接收方的消息存放到静态list集合中(根据sendTo判断发送给谁，date消息只保留24个小时之内的，开一个线程删除数据。)，刷新时请求这些数据。
    			Message msgTemp = new Message();
    			msgTemp.setDate(new Date());
    			msgTemp.setSendTo(sendTo);
    			msgTemp.setMsg(msg2);
    			MyConstants.message.add(msgTemp); //将保存对方信息放到这儿，大概可以使用户离线状态下，还可以收到消息（在线之后）
    			
    			session2.sendMessage(returnMessage);
    		}else{
    			TextMessage returnMessage = new TextMessage("该用户"+sendTo+"，无法找到");
    			session.sendMessage(returnMessage);
    		}
        }
        
        
        /*TextMessage returnMessage = new TextMessage(message.getPayload()+" received at server"); 
        System.out.println(returnMessage);
        session.sendMessage(returnMessage); */
        
        
    }
    public static void main(String[] args) {
		String str = "店长defa5d41-6177-4803-90a9-c43437614ea6店长:3:df";
		String[] split = str.split("defa5d41-6177-4803-90a9-c43437614ea6");
		//String sub = str.substring(0, indexOf);
		System.out.println(split[0]+"----"+split[1]);
		int indexOf = split[1].indexOf(":");
		
		String sub = split[1].substring(0, indexOf);
		System.out.println(sub);
		
		String xinxi = split[1].substring(indexOf+1);
		System.out.println(xinxi);
		
	}
}  