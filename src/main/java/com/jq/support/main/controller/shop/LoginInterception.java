package com.jq.support.main.controller.shop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.jq.support.model.user.EbUser;
import com.jq.support.service.utils.LogUtils;
/**
 * 登录拦截
 *
 */
@Component
public class LoginInterception extends HandlerInterceptorAdapter{
	
    @Override
    public void afterCompletion(HttpServletRequest request,
            HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
    	 super.afterCompletion(request, response, handler, ex);
    	
      
    }

    @Override
    public void postHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
    	//System.out.println("222");
        super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {
    	String servletPath = request.getContextPath();
    	EbUser ebUser= (EbUser) request.getSession().getAttribute("shopuser");
    	if(ebUser!=null){
			return true;
		}else{
			String XRequested =request.getHeader("X-Requested-With");
            if("XMLHttpRequest".equals(XRequested)){
                    response.setHeader("sessionstatus", "timeout");//在响应头设置session状态
                    return false;  
            }
		}


    	response.sendRedirect(servletPath+"/shoplogin"); 
        return false;
    }

}