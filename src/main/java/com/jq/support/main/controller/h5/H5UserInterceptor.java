package com.jq.support.main.controller.h5;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.jq.support.common.utils.StringUtils;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.sys.SystemService;


public class H5UserInterceptor  implements HandlerInterceptor{
	@Autowired
	SystemService systemService;
	
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {
		String parentPath=request.getContextPath();
		HttpSession session=request.getSession();
		SysUser user=(SysUser) session.getAttribute("agentUser");
		if(user != null) {  
			if (user.getCompany()==null||StringUtils.isBlank(user.getCompany().getCode())||StringUtils.isBlank(user.getCompany().getType())||!user.getCompany().getType().equals("1")) {
				 response.sendRedirect(parentPath+"/h5/agentUser/formLogin");
				 return false;
			}
	        return true;  
	    }else{
	    	//user=systemService.getUserByLoginName("ltt");
	    	//session.setAttribute("agentUser", user);
		    response.sendRedirect(parentPath+"/h5/agentUser/formLogin");  
		    return false;
	    }
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request,HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}
	
	
	    
	
}
