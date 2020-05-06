package com.jq.support.main.controller.sys;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Maps;
import com.jq.support.common.config.Global;
import com.jq.support.common.web.BaseController;
import com.jq.support.dao.sys.SysUserDao;
import com.jq.support.model.sys.SysMenu;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.sys.SystemService;
import com.jq.support.service.utils.SysUserUtils;


@Controller
public class SysController extends BaseController{
	
	private static Logger logger = LoggerFactory.getLogger(SysController.class);
	
	@RequestMapping(value="${adminPath}/login" , method = RequestMethod.GET)
	public String login (HttpServletRequest request,RedirectAttributes redirectAttributes){

		SysUser user = SysUserUtils.getUser();
		
		// 如果已经登录，则跳转到管理首页
		if(user.getId() != null){
			return "redirect:"+Global.getAdminPath();
		}
		addMessage(redirectAttributes, "用户名或密码错误");
		return "modules/sys/login";
	}

	
	@RequestMapping(value="${adminPath}/login" , method = RequestMethod.POST)
	public String login(@RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String username, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
		SysUser user = SysUserUtils.getUser();
		// 如果已经登录，则跳转到管理首页
		if(user.getId() != null){
			return "redirect:"+Global.getAdminPath();
		}
		  model.addAttribute("messager", "用户名 密码或验证码错误");
		   return "modules/sys/login";
	}
	
	/**
	 * 登录成功，进入管理首页
	 * @throws JsonProcessingException 
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "${adminPath}")
	public String index(HttpServletRequest request, HttpServletResponse response,Model model) throws JsonProcessingException {
		//Principal principal = SysUserUtils.getPrincipal();
		SysUser user = SysUserUtils.getUser();
		SysOffice  sysOffice =user.getCompany();
		List<SysMenu> sysMenulist = SysUserUtils.getMenuList();
		
		List<SysMenu> toplist=new ArrayList<SysMenu>();//头部菜单
		ArrayList<Map<String, Object>> leftlist = new ArrayList<Map<String, Object>>();
		
		boolean iscollapsed=true;
		
		for(SysMenu sysMenu:sysMenulist){
			if(sysMenu.getParent()!=null && sysMenu.getParent().getId().equals("1") && sysMenu.getIsShow().equals("1")){
				toplist.add(sysMenu);
				Map<String, Object> firstmap = Maps.newHashMap();
				firstmap.put("id", sysMenu.getId());
//				if(fistb){
//					firstmap.put("collapsed", true);
//					firstmap.put("homePage", "code");//默认打开的主页
//				}
				ArrayList<Map<String, Object>> leftfirstlist = new ArrayList<Map<String, Object>>();
				
				for(SysMenu leftMenu:sysMenulist){//第二级
					if(leftMenu.getParent()!=null && leftMenu.getParent().getId().equals(sysMenu.getId()) && leftMenu.getIsShow().equals("1")){
						Map<String, Object> secondmap = Maps.newHashMap();
						secondmap.put("text", leftMenu.getName());
						
						ArrayList<Map<String, Object>> leftsecondlist = new ArrayList<Map<String, Object>>();
						for(SysMenu leftsecondMenu:sysMenulist){//第三级
							if(leftsecondMenu.getParent()!=null && leftsecondMenu.getParent().getId().equals(leftMenu.getId()) && leftsecondMenu.getIsShow().equals("1")){
								Map<String, Object> shirdmap = Maps.newHashMap();
								shirdmap.put("id", leftsecondMenu.getId());
								shirdmap.put("text", leftsecondMenu.getName());
								shirdmap.put("href", request.getContextPath()+Global.getAdminPath()+leftsecondMenu.getHref());
								if(iscollapsed){
									shirdmap.put("collapsed", false);
									iscollapsed=false;
								}
								leftsecondlist.add(shirdmap);
								
							}
						}
						secondmap.put("items", leftsecondlist);
						leftfirstlist.add(secondmap);
					}
				}
				firstmap.put("menu", leftfirstlist);
				leftlist.add(firstmap);
				
			}
		}
		
		model.addAttribute("toplist", toplist);
		model.addAttribute("sysOffice", sysOffice);
		ObjectMapper objectMapper = new ObjectMapper();  
	    String userMapJson = objectMapper.writeValueAsString(leftlist); 
		model.addAttribute("leftlist", userMapJson);
		return "modules/sys/index";
	}
}
