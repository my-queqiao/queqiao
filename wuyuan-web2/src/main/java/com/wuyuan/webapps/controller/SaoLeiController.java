package com.wuyuan.webapps.controller;

import java.util.ArrayList;
import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wuyuan.core.annotation.SecurityIgnoreHandler;
import com.wuyuan.webapps.pojo.Lei;
/**
 * 前言：因为游戏有固定的行数、列数，1、我可以得到当前被单击的方块的周围方块ids。2、知道周围方块有无雷，及其雷在哪个方块。3、所属数据是全的，我只需要在前端实现游戏的点击功能而已。
 * 扫雷：1、先和前端约定好固定的行列，才能计算该方块周围的方块的id，和周围的雷的数量
 * 		2、每个方块中包含的数据：当前方块有无雷、当前方块周围的id、当前方块周围雷的id。后台只负责生成、统计好这些数据，然后发往前端，由前端js完成各个功能。
 * 
 * @author admin
 *
 */
@Controller
@RequestMapping("")
public class SaoLeiController {
	//废弃
	@SecurityIgnoreHandler
	@RequestMapping("saolei")
	public String saolei(){
		return "saolei4444";
	}
	/**
	 * 每行30个，共16行，共480个方块。雷的数量99
	 */
	@SecurityIgnoreHandler
	@RequestMapping("getLeis")
	@ResponseBody
	public JSONObject sl(HttpSession session,int grade){
		int fangkuaiNum = 0;
		int leisNum = 0;
		if(grade == 1) {
			fangkuaiNum=9*9;
			leisNum = 10;
		}
		if(grade == 2) {
			fangkuaiNum=16*16;
			leisNum = 40;
		}
		if(grade == 3) {
			fangkuaiNum=16*30;
			leisNum = 99;
		}
		JSONObject json = new JSONObject();
		List<Lei> leis = new ArrayList<Lei>();
		//1、生成480个方块，都无雷，周围雷的数量为0
		for(int i=1;i<=fangkuaiNum;i++){
			Lei lei = new Lei();
			lei.setId(i);
			lei.setHasLei(false);
			lei.setRoundNum(0);
			leis.add(lei);
		}
		//2、随机布雷。方法：遍历480个方块，
		int number = 0;//用户输入的雷个数
		if(number > fangkuaiNum){//防止有人恶意输入数字
			number = 0;
		}
		int count = 0;//雷数量计数
		if(session.getAttribute("sendNumber") != null){
			number = (Integer)session.getAttribute("sendNumber");
		}
		//bulei(leis, number,count);
		bulei(leis, leisNum,count);
		/*
		 * 3、计算周围雷的个数，存储周围雷的id
		 *  private int roundNum;//周围雷的个数。包括0个
			private String leiIds;//周围雷的id。用,隔开
			private boolean hasLei;//此处有无雷
		 */
		//more(leis);
		more(leis,grade);
		//4、测试，返回给前端，展示看看
		json.put("leis", leis);
		return json;
	}
	/**
	 * 计算周围8个方块中雷的个数，只存储周围有雷的方块的id.
	 */
	public void more(List<Lei> leis,int grade){
		/*private int roundNum;//周围雷的个数。包括0个
		private String leiIds;//周围雷的id。用,隔开
		private boolean hasLei;//此处有无雷
		 */
		int totalNum = 0;//方块总数
		int everyHangNum = 0;//每行的方块个数
		int moHang = 0;//totalNum - everyHangNum
		if(grade == 1) {
			totalNum=9*9;
			everyHangNum = 9;
			moHang = 9*9-9;
		}
		if(grade == 2) {
			totalNum=16*16;
			everyHangNum = 16;
			moHang = 16*16-16;
		}
		if(grade == 3) {
			totalNum=16*30;
			everyHangNum = 30;
			moHang = 16*30-30;
		}
		for(Lei lei:leis){
			int leiNumber=0;//周围8个方块雷的数量
			StringBuffer sb = new StringBuffer();//周围有雷的方块的id
			int currentId = lei.getId();//该方块的id（1-400）
			//查询正上方的方块（特殊位置id：31）
			if(currentId > everyHangNum && leis.get(currentId-everyHangNum-1).isHasLei() == true){//1、上存在。2有雷（该方块的id比其索引大1）
				leiNumber++;
				sb.append(currentId-everyHangNum);
				sb.append(",");
			}
			//查询左上（特殊位置id：31）
			if(currentId > everyHangNum && (currentId-everyHangNum-1)%everyHangNum != 0 && leis.get(currentId-everyHangNum-1-1).isHasLei() == true){
				//1：上存在 ，2：上左不能被30整除(目的是排除左上没有格子的格子，比如第31、61个格子：减30再减1，再对30取余，正好被整除、余数是0，证明他左上没有格子，所以就被排除了。)，3、上左有雷
				leiNumber++;
				sb.append(currentId-everyHangNum-1);
				sb.append(",");
			}
			//查询右上（特殊位置id：60）
			if(currentId > everyHangNum && (currentId-everyHangNum)%everyHangNum != 0 && leis.get(currentId-everyHangNum+1-1).isHasLei() == true){//1：上存在 ，2：上不能被30整除，3、上右有雷
				leiNumber++;
				sb.append(currentId-everyHangNum+1);
				sb.append(",");
			}
			//查询正下（特殊位置id：451）
			if(currentId <= moHang && leis.get(currentId+everyHangNum-1).isHasLei() == true){//1、下方存在方块。2、下方有雷
				leiNumber++;
				sb.append(currentId+everyHangNum);
				sb.append(",");
			}
			//查询左下（特殊位置id：421）
			if(currentId <= moHang && (currentId+everyHangNum-1)%everyHangNum != 0 && leis.get(currentId+everyHangNum-1-1).isHasLei() == true){//1、下方存在方块。2、左下不能被30整除。3、左下有雷
				leiNumber++;
				sb.append(currentId+everyHangNum-1);
				sb.append(",");
			}
			//查询右下（特殊位置id：450）
			if(currentId <= moHang && (currentId+everyHangNum)%everyHangNum != 0 && leis.get(currentId+everyHangNum+1-1).isHasLei() == true){//1、首先下方方块小于等于480。2、下方方块不能被30整除
				leiNumber++;
				sb.append(currentId+30+1);
				sb.append(",");
			}
			//查询左（特殊位置id：31）
			if(currentId >= 1 && (currentId-1)%everyHangNum != 0 && leis.get(currentId-1-1).isHasLei() == true){//1、当前方块大于等于1。2、当前左边的方块不能被30整除
				leiNumber++;
				sb.append(currentId-1);
				sb.append(",");
			}
			//查询右（特殊位置id：30）
			if(currentId+1 <= totalNum && (currentId)%everyHangNum != 0 && leis.get(currentId+1-1).isHasLei() == true){//1、右边的方块小于等于480。2、当前方块不能被30整除。
				leiNumber++;
				sb.append(currentId+1);
				sb.append(",");
			}
			if(leiNumber > 0){//该方块周围有雷
				//去除最后一个逗号
				String sb2 = sb.toString();
				String sb3 = sb2.substring(0, sb2.length()-1);
				//保存周围雷的数量和ids
				lei.setRoundNum(leiNumber);
				lei.setLeiIds(sb3);
			}else{//无雷
				lei.setRoundNum(0);
				lei.setLeiIds("");
			}
			/*
			 * 再统计当前方块周围的所有id
			 */
			StringBuffer sb4 = new StringBuffer();//周围有雷的方块的id
			//查询正上方的方块（特殊位置id：31）
			if(currentId > everyHangNum ){//当前方块只要id>30，正上方就一定存在方块
				sb4.append(currentId-everyHangNum);
				sb4.append(",");
			}
			//查询左上（特殊位置id：31）
			if(currentId > everyHangNum && (currentId-everyHangNum-1)%everyHangNum != 0 ){//1：上存在 ，2：上左不能被30整除，
				sb4.append(currentId-everyHangNum-1);
				sb4.append(",");
			}
			//查询右上（特殊位置id：60）
			if(currentId > everyHangNum && (currentId-everyHangNum)%everyHangNum != 0 ){//1：上存在 ，2：上不能被30整除，
				sb4.append(currentId-everyHangNum+1);
				sb4.append(",");
			}
			//查询正下（特殊位置id：451）
			if(currentId <= moHang ){//1、下方存在方块。
				sb4.append(currentId+everyHangNum);
				sb4.append(",");
			}
			//查询左下（特殊位置id：421）
			if(currentId <= moHang && (currentId+everyHangNum-1)%everyHangNum != 0 ){//1、下方存在方块。2、左下不能被30整除。
				sb4.append(currentId+everyHangNum-1);
				sb4.append(",");
			}
			//查询右下（特殊位置id：450）
			if(currentId <= moHang && (currentId+everyHangNum)%everyHangNum != 0 ){//1、首先下方方块小于等于480。2、下方方块不能被30整除
				sb4.append(currentId+everyHangNum+1);
				sb4.append(",");
			}
			//查询左（特殊位置id：31）
			if(currentId >= 1 && (currentId-1)%everyHangNum != 0 ){//1、当前方块大于等于1。2、当前左边的方块不能被30整除
				sb4.append(currentId-1);
				sb4.append(",");
			}
			//查询右（特殊位置id：30）
			if(currentId+1 <= totalNum && (currentId)%everyHangNum != 0 ){//1、右边的方块小于等于480。2、当前方块不能被30整除。
				sb4.append(currentId+1);
				sb4.append(",");
			}
			String sb5 = sb4.toString();
			String sb6 = sb5.substring(0, sb5.length()-1);//去除最后一个逗号，
			//保存周围的ids
			lei.setRoundIds(sb6);
		}
	}
	/**
	 * 随机布雷 99个雷(高级)。
	 * @param leis
	 */
	public void bulei(List<Lei> leis,int number,int count){
		//int jishu = 0;
		int shuliang = 0;
		if(number == 0){
			shuliang = 99;//高级
		}else{
			shuliang = number;
		}
		for(Lei lei:leis){
			int random = (int)(Math.random()*10+1);//【1，11）
			double random2 = (int)(Math.random()*10);//【0，10）
			/*
			 * 480个方块的id：1-480，对随机数取余，再用该余数和另外一个随机数比较。
			 */
			if(lei.getId() % random == random2 && lei.isHasLei() == false){
				count++;
				lei.setHasLei(true);
				
				if(count == shuliang){
					return;
				}
			}
		}
		//测试得出，第一次布雷不足99个，大概需要三次布雷
		if(count >= shuliang){
			return;
		}else{
			bulei(leis, number,count);//此时number的值是多少？注意可能有错误
		}
	}
	
	@SecurityIgnoreHandler
	@RequestMapping("sendNumber")
	@ResponseBody
	public JSONObject sl(Integer number,HttpSession session){
		JSONObject json = new JSONObject();
		session.setAttribute("sendNumber", number);
		return json;
	}
	/**
	 * 备注代码
	 */
	public void more22(List<Lei> leis,int grade){
		/*private int roundNum;//周围雷的个数。包括0个
		private String leiIds;//周围雷的id。用,隔开
		private boolean hasLei;//此处有无雷
		 */
		for(Lei lei:leis){
			int leiNumber=0;//周围8个方块雷的数量
			StringBuffer sb = new StringBuffer();//周围有雷的方块的id
			int currentId = lei.getId();//该方块的id（1-400）
			//查询正上方的方块（特殊位置id：31）
			if(currentId > 30 && leis.get(currentId-30-1).isHasLei() == true){//1、上存在。2有雷（该方块的id比其索引大1）
				leiNumber++;
				sb.append(currentId-30);
				sb.append(",");
			}
			//查询左上（特殊位置id：31）
			if(currentId > 30 && (currentId-30-1)%30 != 0 && leis.get(currentId-30-1-1).isHasLei() == true){
				//1：上存在 ，2：上左不能被30整除(目的是排除左上没有格子的格子，比如第31、61个格子：减30再减1，再对30取余，正好被整除、余数是0，证明他左上没有格子，所以就被排除了。)，3、上左有雷
				leiNumber++;
				sb.append(currentId-30-1);
				sb.append(",");
			}
			//查询右上（特殊位置id：60）
			if(currentId > 30 && (currentId-30)%30 != 0 && leis.get(currentId-30+1-1).isHasLei() == true){//1：上存在 ，2：上不能被30整除，3、上右有雷
				leiNumber++;
				sb.append(currentId-30+1);
				sb.append(",");
			}
			//查询正下（特殊位置id：451）
			if(currentId <= 450 && leis.get(currentId+30-1).isHasLei() == true){//1、下方存在方块。2、下方有雷
				leiNumber++;
				sb.append(currentId+30);
				sb.append(",");
			}
			//查询左下（特殊位置id：421）
			if(currentId <= 450 && (currentId+30-1)%30 != 0 && leis.get(currentId+30-1-1).isHasLei() == true){//1、下方存在方块。2、左下不能被30整除。3、左下有雷
				leiNumber++;
				sb.append(currentId+30-1);
				sb.append(",");
			}
			//查询右下（特殊位置id：450）
			if(currentId <= 450 && (currentId+30)%30 != 0 && leis.get(currentId+30+1-1).isHasLei() == true){//1、首先下方方块小于等于480。2、下方方块不能被30整除
				leiNumber++;
				sb.append(currentId+30+1);
				sb.append(",");
			}
			//查询左（特殊位置id：31）
			if(currentId >= 1 && (currentId-1)%30 != 0 && leis.get(currentId-1-1).isHasLei() == true){//1、当前方块大于等于1。2、当前左边的方块不能被30整除
				leiNumber++;
				sb.append(currentId-1);
				sb.append(",");
			}
			//查询右（特殊位置id：30）
			if(currentId+1 <= 480 && (currentId)%30 != 0 && leis.get(currentId+1-1).isHasLei() == true){//1、右边的方块小于等于480。2、当前方块不能被30整除。
				leiNumber++;
				sb.append(currentId+1);
				sb.append(",");
			}
			if(leiNumber > 0){//该方块周围有雷
				//去除最后一个逗号
				String sb2 = sb.toString();
				String sb3 = sb2.substring(0, sb2.length()-1);
				//保存周围雷的数量和ids
				lei.setRoundNum(leiNumber);
				lei.setLeiIds(sb3);
			}else{//无雷
				lei.setRoundNum(0);
				lei.setLeiIds("");
			}
			/*
			 * 再统计当前方块周围的所有id
			 */
			StringBuffer sb4 = new StringBuffer();//周围有雷的方块的id
			//查询正上方的方块（特殊位置id：31）
			if(currentId > 30 ){//当前方块只要id>30，正上方就一定存在方块
				sb4.append(currentId-30);
				sb4.append(",");
			}
			//查询左上（特殊位置id：31）
			if(currentId > 30 && (currentId-30-1)%30 != 0 ){//1：上存在 ，2：上左不能被30整除，
				sb4.append(currentId-30-1);
				sb4.append(",");
			}
			//查询右上（特殊位置id：60）
			if(currentId > 30 && (currentId-30)%30 != 0 ){//1：上存在 ，2：上不能被30整除，
				sb4.append(currentId-30+1);
				sb4.append(",");
			}
			//查询正下（特殊位置id：451）
			if(currentId <= 450 ){//1、下方存在方块。
				sb4.append(currentId+30);
				sb4.append(",");
			}
			//查询左下（特殊位置id：421）
			if(currentId <= 450 && (currentId+30-1)%30 != 0 ){//1、下方存在方块。2、左下不能被30整除。
				sb4.append(currentId+30-1);
				sb4.append(",");
			}
			//查询右下（特殊位置id：450）
			if(currentId <= 450 && (currentId+30)%30 != 0 ){//1、首先下方方块小于等于480。2、下方方块不能被30整除
				sb4.append(currentId+30+1);
				sb4.append(",");
			}
			//查询左（特殊位置id：31）
			if(currentId >= 1 && (currentId-1)%30 != 0 ){//1、当前方块大于等于1。2、当前左边的方块不能被30整除
				sb4.append(currentId-1);
				sb4.append(",");
			}
			//查询右（特殊位置id：30）
			if(currentId+1 <= 480 && (currentId)%30 != 0 ){//1、右边的方块小于等于480。2、当前方块不能被30整除。
				sb4.append(currentId+1);
				sb4.append(",");
			}
			String sb5 = sb4.toString();
			String sb6 = sb5.substring(0, sb5.length()-1);//去除最后一个逗号，
			//保存周围的ids
			lei.setRoundIds(sb6);
		}
	}
	
	
	public static void main(String[] args) {
		String a ="a,b,c,";
		System.out.println(a.length());
		System.out.println(a.substring(0, 6));
	}
}
