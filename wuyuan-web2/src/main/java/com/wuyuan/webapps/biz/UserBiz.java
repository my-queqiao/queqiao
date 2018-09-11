package com.wuyuan.webapps.biz;

import java.util.List;
import java.util.Map;

import com.wuyuan.webapps.pojo.User;

public interface UserBiz {

	User findByName(String username);

	void add(User user2);

	Map<String, Object> getAll(int page, int rows,String search,String userName);

	User findByNameAndPassword(String username, String password);

	void updateByUserName(String username);

}
