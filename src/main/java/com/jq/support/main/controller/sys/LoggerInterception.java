package com.jq.support.main.controller.sys;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.jq.support.service.utils.LogUtils;
/**
 * 日志拦截器
 *
 */
@Component
public class LoggerInterception extends HandlerInterceptorAdapter{
	
    @Override
    public void afterCompletion(HttpServletRequest request,
            HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
    	 super.afterCompletion(request, response, handler, ex);
    	String servletPath = request.getServletPath(); // 请求的相对url
    	String fun=servletPath.substring(servletPath.lastIndexOf("/")+1,servletPath.length());
    	if (fun.contains("delete")||fun.contains("save")||fun.equals("manage")||fun.contains("check")||fun.contains("update")||fun.contains("savepro")) {
    		LogUtils.saveSysLog();//保存日志
		}
      
    }

    @Override
    public void postHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
    	//System.out.println("222");
        super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception {
    	//System.out.println("333");
        return super.preHandle(request, response, handler);
    }

}