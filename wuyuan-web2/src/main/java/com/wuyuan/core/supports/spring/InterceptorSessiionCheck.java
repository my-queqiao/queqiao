package com.wuyuan.core.supports.spring;

import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wuyuan.core.annotation.SecuObject;
import com.wuyuan.core.annotation.SecurityAccessCheckable;
import com.wuyuan.core.annotation.SecurityIgnoreHandler;
import com.wuyuan.webapps.pojo.Authority;

/**
 * URL权限验证拦截器
 * 
 * @author Bean
 *
 */
public class InterceptorSessiionCheck extends HandlerInterceptorAdapter {

	private static Logger logger = Logger.getLogger(InterceptorSessiionCheck.class);
	private String loginUrl;
	private List<String> uncheckUrls;
	private List<String> uncheckRegexUrls;
	private String SESSIONOUT = "";

	@SuppressWarnings("unused")
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 对微信访问路劲不做拦截

		if (handler instanceof HandlerMethod) {

			HandlerMethod handlerMethod = (HandlerMethod) handler;

			if (logger.isDebugEnabled()) {
				logger.info("Request:" + request.getRequestURL());
			}
			// 忽略
			if (handlerMethod.getMethodAnnotation(SecurityIgnoreHandler.class) != null) {
				if (logger.isDebugEnabled()) {
					logger.info(SecurityIgnoreHandler.class.getName());
				}
				return true;
			}
			// 如果会话已不存在
			/* session.setAttribute(username+"Authority", secuObject);
			 * session.setAttribute("currentUserName", user.getUserName());
			 */
			String userName = (String) request.getSession().getAttribute("currentUserName");
			SecuObject secuObj = (SecuObject)request.getSession().getAttribute(userName+"Authority");
			
			if (secuObj == null) { //未登录
				if (logger.isInfoEnabled()) {
					logger.info("=============认证失败================");
					logger.info(request.getRemoteHost());
					logger.info(request.getRequestURL());
				}
				if (request.getHeader("x-requested-with") != null
						&& request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
					// 在响应头设置session状态
					response.setHeader("sessionstatus", "sessionOut");
					response.sendRedirect(request.getContextPath() + loginUrl);
				} else {
					response.sendRedirect(request.getContextPath() + loginUrl);
				}
				return false;
			} else { //已经登录
				SecurityAccessCheckable checkable = handlerMethod.getMethodAnnotation(SecurityAccessCheckable.class);
				if (checkable == null) { //该方法没有安全权限注解
					if (request.getHeader("x-requested-with") != null
							&& request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
						// 在响应头设置session状态
						response.setHeader("sessionstatus", "permissionDenied");
						response.setContentType("text/html;charset=utf-8");
						response.getWriter().print("没有配置权限，请与管理员进行联系");
						request.getRequestDispatcher("/_permission_undefined").forward(request, response);
					} else {
						request.setAttribute("_msg",
								handlerMethod.getBeanType().getName() + ":" + handlerMethod.getMethod().getName() + "(...)");
						response.setContentType("text/html;charset=utf-8");
						request.getRequestDispatcher("/_permission_undefined").forward(request, response);
					}
					return false;
				}else{// 该方法有注解
					
					//if (checkable == null || !secuObj.validate(checkable.resource().getName(), checkable.operation().name())) {
					String resourceName = checkable.resource().getName(); //这个名字，大概就是authority类的resource字段的值。证实：com.wuyuan.core.acl.Index
					List<Authority> auths = secuObj.getAuths();
					for(Authority auth:auths){
						if(auth.getResource().equals(resourceName)){//该用户有该方法的权限。
							return true;
						}
					}
					
					if (request.getHeader("x-requested-with") != null
							&& request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
						// 在响应头设置session状态
						response.setHeader("sessionstatus", "permissionDenied");
						response.setContentType("text/html;charset=utf-8");
						response.getWriter().print("没有访问权限，请与管理员进行联系!");
					} else {
						request.getRequestDispatcher("/_permission_denied").forward(request, response);//请求跳转，_permission_denied是url
					}
					return false;
				}
			}
		}
		return true;
	}

	private boolean checkContains(String requestUrl) {
		boolean flag = false;
		for (String uncheckRegexUrl : uncheckRegexUrls) {
			uncheckRegexUrl = "^" + uncheckRegexUrl.replaceAll("[*]", "(.+)?") + "$";
			flag = Pattern.matches(uncheckRegexUrl,requestUrl);
			if(flag){
				return flag;
			}
		}
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		// if (logger.isDebugEnabled()) {
		// logger.debug("========Interceptor-postHandle:Do Something here...");
		// logger.debug("Interceptor-Handler:" + handler);
		// }
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

		// if (logger.isDebugEnabled()) {
		// logger.debug("========Interceptor-afterCompletion:Do Something
		// here...");
		// logger.debug("Interceptor-Handler:" + handler);
		// }
	}

	public void setLoginUrl(String loginUrl) {
		this.loginUrl = loginUrl;
	}

	public List<String> getUncheckUrls() {
		return uncheckUrls;
	}

	public void setUncheckUrls(List<String> uncheckUrls) {
		this.uncheckUrls = uncheckUrls;
	}

	public List<String> getUncheckRegexUrls() {
		return uncheckRegexUrls;
	}

	public void setUncheckRegexUrls(List<String> uncheckRegexUrls) {
		this.uncheckRegexUrls = uncheckRegexUrls;
	}

}
