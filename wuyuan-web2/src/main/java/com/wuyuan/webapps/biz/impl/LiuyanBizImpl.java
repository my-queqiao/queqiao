package com.wuyuan.webapps.biz.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wuyuan.webapps.biz.LiuyanBiz;
import com.wuyuan.webapps.mappers.gen.LiuyanMapper;
import com.wuyuan.webapps.pojo.Liuyan;
@Service
public class LiuyanBizImpl implements LiuyanBiz{
	@Autowired
	private LiuyanMapper liuyanMapper;
	
	@Override
	public void save(Liuyan ly) {
		liuyanMapper.insert(ly);
	}

	@Override
	public List<Liuyan> getAll() {
		List<Liuyan> list = liuyanMapper.selectByExample(null);
		return list;
	}

}
