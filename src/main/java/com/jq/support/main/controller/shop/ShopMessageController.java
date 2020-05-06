package com.jq.support.main.controller.shop;

import java.io.File;
import java.util.Locale;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.message.EbMessageUser;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 商家消息管理 Controller
 *
 */
@Controller
@RequestMapping(value = "${adShopPath}/message")
public class ShopMessageController  extends BaseController{
	@Autowired
	private EbMessageUserService messageInfoService;
	@Autowired
	private EbUserService userService;
	@Autowired
	private EbMessageUserService messageInfoUserService;
	@Autowired
	private SysOfficeService officeService;
	@Autowired
	private EbUserService ebUserService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl + "/uploads/images/";
	
	
	@ModelAttribute
	public EbMessageUser get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return messageInfoUserService.get(Integer.valueOf(id));
		}else{
			return new EbMessageUser();
		}
	}
	
	
	/**
	 * 商家消息管理
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "messageList")
	public String getMessageInfoList(EbMessageUser messageInfo,String messageType, HttpServletRequest request,HttpServletResponse response, Model model){
		EbUser ebUser= (EbUser) request.getSession().getAttribute("shopuser");
		Page<EbMessageUser> page = messageInfoUserService.getMessageInfoList(new Page<EbMessageUser>(request, response), messageInfo,ebUser,messageType);

		for(EbMessageUser messageUser : page.getList()){
			messageUser.setState(2);
			messageInfoUserService.update(messageUser);
		}

		model.addAttribute("page", page);
		model.addAttribute("messageInfo", messageInfo);
		model.addAttribute("messageType", messageType);
		model.addAttribute("mTypeClass"+messageType, "active");
		return "modules/shop/shopMessageList";
	}
	
	
	
	
	/**
	 * 删除
	 */
	@ResponseBody
	@RequestMapping(value = "deleteService")
	public String deleteProject(String ids,String type,RedirectAttributes redirectAttributes, HttpServletRequest request) {
		EbUser ebUser= (EbUser) request.getSession().getAttribute("shopuser");
		if (ebUser!=null) {
			messageInfoService.userdelMessages(ebUser,ids,type);
		}
		return null;
	}
	
	
	

	
	/**
	 * 创建商品详情图片存放目录
	 */
	private void createPicFold(HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("/");
		StringBuffer folder = new StringBuffer(root);
		folder.append("uploads");
		folder.append(File.separator);
		// ===========集群文件处理 start===============
		String wfsName = Global.getConfig("wfsName");
		if (!StringUtil.isEmpty(wfsName)) {
			folder.append(wfsName);
			folder.append(File.separator);
		}
		// ===========集群文件字段处理 end===============
		folder.append("000000");
		folder.append(File.separator);
		SysUser user = SysUserUtils.getUser();
		if(user.getCompany()!=null&&user.getCompany().getIsAgent().equals("1")){
			folder.append("agent"+user.getCompany().getId());
			folder.append(File.separator);
		  }
		folder.append("images" );
		folder.append(File.separator);
		folder.append("message");
		folder.append(File.separator);
		folder.append("messageIcon");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator); 
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
}
