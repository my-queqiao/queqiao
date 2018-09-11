package com.wuyuan.webapps.biz;

import java.util.List;

import com.wuyuan.webapps.pojo.Liuyan;

public interface LiuyanBiz {

	void save(Liuyan ly);

	List<Liuyan> getAll();

}
