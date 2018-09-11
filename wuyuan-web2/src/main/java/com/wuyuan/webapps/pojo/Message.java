package com.wuyuan.webapps.pojo;

import java.util.Date;
/**
 * 用于暂存聊天消息
 * @author admin
 *
 */
public class Message {
	private Date date;
	private String sendTo;
	private String msg;
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getSendTo() {
		return sendTo;
	}
	public void setSendTo(String sendTo) {
		this.sendTo = sendTo;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
}
