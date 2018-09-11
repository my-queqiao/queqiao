package com.wuyuan.webapps.biz;

import java.util.List;

import com.wuyuan.webapps.pojo.Authority;

public interface AuthorityBiz {

	void saveBatch(List<Authority> auths);

	List<Authority> getAuths(Integer userId);

}
