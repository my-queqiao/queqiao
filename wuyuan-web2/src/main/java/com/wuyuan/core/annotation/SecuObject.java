package com.wuyuan.core.annotation;

import java.lang.annotation.Annotation;
import java.util.List;
import java.util.Set;

import com.wuyuan.webapps.pojo.Authority;
import com.wuyuan.webapps.pojo.User;
import com.wuyuan.webapps.util.GetClassesByPackageUtil;

/**
 * 用户登录信息操作辅助类. 登录时，必须完成对该类的赋值，并放到session中。
 * @author Bean
 *
 */
public class SecuObject {

	private User user;
	private List<Authority> auths;

	public User getUser() {
		return user;
	}
	
	public List<Authority> getAuths() {
		return auths;
	}

	public SecuObject(User user,List<Authority> auths) {
		 this.user=user;
		 this.auths=auths;
	}
	public static void main(String[] args) throws InstantiationException, IllegalAccessException {
			Set<Class<?>> classes = GetClassesByPackageUtil.getClasses("com.wuyuan.core.acl");
			for (Class c:classes) {
				Annotation a = c.getAnnotations()[0];
				
				System.out.println(c.getName());
				
				String str = a.toString();
				int indexOf = str.indexOf("=");
				int indexOf2 = str.indexOf(")");
				System.out.println(str.substring(indexOf+1, indexOf2));
			}
	}
}




