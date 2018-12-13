package com.wuyuan.core.supports.spring;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wuyuan.webapps.util.NetworkUtil;

/**
 * 编码拦截器
 * @author Bean
 *
 */
public class InterceptorCharset extends HandlerInterceptorAdapter {

	private static Logger logger = Logger.getLogger(InterceptorCharset.class);

	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {

		if (logger.isDebugEnabled()) {
			logger.debug("========Interceptor-preHandle:Do Something here...");
			logger.debug("Interceptor-Handler:" + handler);
		}
		
		String requestURI = request.getRequestURI();
		StringBuffer requestURL = request.getRequestURL();
		String contextPath = request.getContextPath();
		/*System.out.println("requestURI:"+requestURI); //    /wuyuan-web/toIndex
		System.out.println("requestURL:"+requestURL);   //    http://localhost:9999/wuyuan-web/toIndex
		System.out.println("contextPath:"+contextPath); //  /wuyuan-web*/		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String ipAddress = NetworkUtil.getIpAddress(request);
		logger.error("ipAddress:"+ipAddress); //119.85.165.142
		/**
		 * 如果同一个ip，恶意频繁访问先不用管了。则return false，阻止访问。如何实现？     
		 * 先解决，恶意注册。  办法：同一个ip，每分钟只能注册一次。每天只能注册。。（加一个验证码算了）
		 */
		
		
		
		/*System.out.println("ipAddress:"+ipAddress);
		System.out.println("过滤器，进来了吗？");*/
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request,HttpServletResponse response, Object handler,ModelAndView modelAndView) throws Exception {}

	@Override
	public void afterCompletion(HttpServletRequest request,HttpServletResponse response, Object handler, Exception ex) throws Exception {}
}
