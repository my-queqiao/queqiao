package com.wuyuan.webapps.biz.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wuyuan.webapps.biz.AuthorityBiz;
import com.wuyuan.webapps.mappers.gen.AuthorityMapper;
import com.wuyuan.webapps.mappers.gen.UserRelAuthorityMapper;
import com.wuyuan.webapps.pojo.Authority;
import com.wuyuan.webapps.pojo.AuthorityExample;
import com.wuyuan.webapps.pojo.UserRelAuthority;
import com.wuyuan.webapps.pojo.UserRelAuthorityExample;
@Service
public class AuthorityBizImpl implements AuthorityBiz{
	@Autowired
	private AuthorityMapper authorityMapper;
	@Autowired
	private UserRelAuthorityMapper userRelAuthorityMapper;
	
	@Override
	public void saveBatch(List<Authority> auths) {
		List<Authority> list = authorityMapper.selectByExample(null);
		List<Authority> xiangtong = new ArrayList<Authority>();
		//保存auths不再list中的部分
		for(Authority auth:auths){
			for(Authority li:list){
				if(auth.getResource().equals(li.getResource())){
					xiangtong.add(auth);
					continue;
				}
			}
		}
		for(Authority auth:xiangtong){//移除
			auths.remove(auth);
		}
		for(Authority auth:auths){//保存
			authorityMapper.insert(auth);
		}
		
		
	}

	@Override
	public List<Authority> getAuths(Integer userId) {
		UserRelAuthorityExample urae = new UserRelAuthorityExample();
		urae.createCriteria().andUserIdEqualTo(userId);
		List<UserRelAuthority> userRelAuthoritys = userRelAuthorityMapper.selectByExample(urae);
		List<Integer> ids = new ArrayList<Integer>();
		for(UserRelAuthority ura:userRelAuthoritys){
			ids.add(ura.getAuthorityId());
		}
		
		AuthorityExample e = new AuthorityExample();
		e.createCriteria().andIdIn(ids);
		List<Authority> auths = authorityMapper.selectByExample(e);
		
		return auths;
	}

}
