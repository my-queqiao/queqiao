package com.wuyuan.webapps.biz.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wuyuan.core.supports.mybatis.pagination.PageContext;
import com.wuyuan.core.supports.mybatis.pagination.Pagination;
import com.wuyuan.webapps.biz.UserBiz;
import com.wuyuan.webapps.controller.MyConstants;
import com.wuyuan.webapps.mappers.gen.UserMapper;
import com.wuyuan.webapps.pojo.User;
import com.wuyuan.webapps.pojo.UserExample;
@Service
public class UserBizImpl implements UserBiz{
	@Autowired
	UserMapper userMapper;

	public User findByName(String username) {
		UserExample e = new UserExample();
		e.createCriteria().andUserNameEqualTo(username);
		List<User> list = userMapper.selectByExample(e);
		if(!list.isEmpty()){
			return list.get(0);
		}else{
			return null;
		}
	}

	public void add(User user2) {
		userMapper.insert(user2);
	}

	public Map<String, Object> getAll(int page,int rows,String search,String userName) {
		Map<String, Object> map = new HashMap<String, Object>();
		Pagination<?> pagin = PageContext.initialize(page, rows);
		UserExample e = new UserExample();
		if(null != search){
			e.createCriteria().andUserNameLike("%"+search+"%");
		}
		
		List<User> list = userMapper.selectByExample(e,pagin.getRowBounds());
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(User user:list){
			String recentOnline = df.format(user.getRecentOnline());
			user.setRecentOnline2(recentOnline);
			Object object = MyConstants.online.get(user.getUserName());
			if(null != object){
				Date date = (Date)object;
				if(date.getTime() <= (new Date().getTime()-15*1000)){ //用户对应的时间小于（当前时间-15秒），则为离线。
					user.setOnline("离线");
				}else{
					user.setOnline("在线");
				}
			}else{
				user.setOnline("离线");
			}
			if(user.getUserName().equals(userName)){//当前登录的该用户直接设为在线，不管ws是否已经连接。
				user.setOnline("在线");
			}
		}
		map.put("rows", list);
		map.put("total", pagin.getTotalRows());
		return map;
	}

	public User findByNameAndPassword(String username, String password) {
		UserExample e = new UserExample();
		e.createCriteria().andUserNameEqualTo(username).andPasswordEqualTo(password);
		List<User> list = userMapper.selectByExample(e);
		if(!list.isEmpty()){
			return list.get(0);
		}else{
			return null;
		}
	}

	@Override
	public void updateByUserName(String username) {
		UserExample e = new UserExample();
		e.createCriteria().andUserNameEqualTo(username);
		User user = new User();
		user.setRecentOnline(new Date());
		user.setOnline("在线");
		userMapper.updateByExampleSelective(user, e);
	}
	
	
}
