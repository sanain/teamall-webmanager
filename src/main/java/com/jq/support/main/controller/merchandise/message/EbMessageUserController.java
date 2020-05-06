package com.jq.support.main.controller.merchandise.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.message.EbMessageUser;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.sys.SysDictService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 消息推送表 Controller
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/messageUser")
public class EbMessageUserController  extends BaseController{

	@Autowired
	private EbMessageUserService messageUserService;
	
	@ModelAttribute
	public EbMessageUser get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return messageUserService.get(Integer.valueOf(id));
		}else{
			return new EbMessageUser();
		}
	}
	
	
	/**
	 * 用户消息列表
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping({"list", ""})
	public String messageUserList(EbMessageUser ebMessageUser, HttpServletRequest request,HttpServletResponse response, Model model){
		//过滤数据
		SysUser currentUser = SysUserUtils.getUser();
		if(currentUser!=null && !currentUser.isAdmin() && currentUser.getCompany()!=null){
			ebMessageUser.setAgentId(currentUser.getCompany().getId());
		}
		Page<EbMessageUser> page = messageUserService.find(new Page<EbMessageUser>(request, response), ebMessageUser);
		model.addAttribute("page", page);
		model.addAttribute("ebMessageUser", ebMessageUser);
		return "modules/message/messageUserList";
	}
	
	
	@RequiresPermissions("messageUser:info:view")
	@RequestMapping(value = "view")
	public String view(EbMessageUser ebMessageUser, HttpServletRequest request, Model model) {
		if(ebMessageUser.getId()!=null){
			ebMessageUser = messageUserService.getEbMessageUserById(ebMessageUser.getId().toString());
			
			//修改状态为已读
			ebMessageUser.setState(2);
			messageUserService.save(ebMessageUser);
		}
		model.addAttribute("ebMessageUser", ebMessageUser); 
		return "modules/message/messageUserView";
	}

}
