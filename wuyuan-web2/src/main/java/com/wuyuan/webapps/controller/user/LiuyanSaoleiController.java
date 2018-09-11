package com.wuyuan.webapps.controller.user;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wuyuan.core.acl.IndexRank;
import com.wuyuan.core.acl.LiuyanRank;
import com.wuyuan.core.annotation.SecurityAccessCheckable;
import com.wuyuan.core.annotation.SecurityIgnoreHandler;
import com.wuyuan.webapps.biz.LiuyanBiz;
import com.wuyuan.webapps.pojo.Liuyan;
@Controller
@RequestMapping("/")
public class LiuyanSaoleiController {
	@Autowired
	private LiuyanBiz liuyanBiz;
	
	@SecurityIgnoreHandler
	@SecurityAccessCheckable(resource=LiuyanRank.class)
	@RequestMapping("toLiuyanSaolei")
	public String toLiuyan(){
			return "liuyanSaolei";
	}
	@SecurityIgnoreHandler
	@SecurityAccessCheckable(resource=LiuyanRank.class)
	@RequestMapping("liuyanSaolei")
	@ResponseBody
	public JSONObject liuyan(String liuyan){
		Liuyan ly = new Liuyan();
		ly.setLiuyan(liuyan);
		ly.setTime(new Date());
		liuyanBiz.save(ly);
		JSONObject json = new JSONObject();
		json.put("result", true);
		json.put("msg", "留言成功");
		return json;
	}
	@SecurityIgnoreHandler
	@SecurityAccessCheckable(resource=LiuyanRank.class)
	@RequestMapping("getLeaveMsgSaolei")
	@ResponseBody
	public JSONObject getLeaveMsg(){
		List<Liuyan> lys = liuyanBiz.getAll();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(Liuyan ly:lys){
			ly.setTimeString(df.format(ly.getTime()));
		}
		JSONObject json = new JSONObject();
		json.put("result", true);
		json.put("data", lys);
		return json;
	}
}
