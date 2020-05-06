package com.jq.support.main.controller.merchandise.frozenlove;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.frozenlove.PmFrozenLoveDetailLog;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.frozenlove.PmFrozenLoveDetailLogService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.sys.SysDictService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 冻结积分明细记录表Controller
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/frozenLoveDetail")
public class PmFrozenLoveDetailLogController  extends BaseController{
	@Autowired
	private PmFrozenLoveDetailLogService pmFrozenLoveDetailLogService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/upload/images/";
	private static String innerImgFullPath = "src=\"" + domainurl + "/upload/images/";
	
	
	@ModelAttribute
	public PmFrozenLoveDetailLog get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return pmFrozenLoveDetailLogService.get(Integer.valueOf(id));
		}else{
			return new PmFrozenLoveDetailLog();
		}
	}
	
	
	/**
	 * 列表
	 * @param request
	 * @return
	 */
	@RequestMapping({"list", ""})
	public String pmFrozenLoveDetailLogList(PmFrozenLoveDetailLog pmFrozenLoveDetailLog, HttpServletRequest request,HttpServletResponse response, Model model){
		Page<PmFrozenLoveDetailLog> page = pmFrozenLoveDetailLogService.findPmFrozenLoveDetailLogList(new Page<PmFrozenLoveDetailLog>(request, response), pmFrozenLoveDetailLog);
		model.addAttribute("page", page);
		model.addAttribute("pmFrozenLoveDetailLog", pmFrozenLoveDetailLog);
		return "modules/frozenlove/pmFrozenLoveDetailLogList";
	}
	
	
	@RequiresPermissions("message:info:view")
	@RequestMapping(value = "form")
	public String form(PmFrozenLoveDetailLog pmFrozenLoveDetailLog, HttpServletRequest request, Model model) {
		// 创建广告图片存放目录
		createPicFold(request);
		return formSearch(pmFrozenLoveDetailLog, model);
	}
	
	
	/**
	 * 保存
	 */
	@RequiresPermissions("message:info:edit")
	@RequestMapping(value = "save")
	public String save(PmFrozenLoveDetailLog pmFrozenLoveDetailLog,String sendUserIds, Model model,HttpServletRequest request, RedirectAttributes redirectAttributes) {


		return "redirect:" + Global.getAdminPath() + "/message/list";
	}
	
	
	/**
	 * 删除
	 */
	@RequiresPermissions("message:info:edit")
	@RequestMapping(value = "deleteService")
	public String deleteProject(String ids[],String spackId,RedirectAttributes redirectAttributes, HttpServletRequest request) {
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + Global.getAdminPath() + "/pmFrozenLoveDetailLog/list";
	}
	
	
	
	
	/**
	 * 创建商品详情图片存放目录
	 */
	private void createPicFold(HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("/");
		StringBuffer folder = new StringBuffer(root);
		folder.append("upload");
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
		folder.append("pmFrozenLoveDetailLog");
		folder.append(File.separator);
		folder.append("messageIcon");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator); 
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
	
	
	private String formSearch(PmFrozenLoveDetailLog pmFrozenLoveDetailLog, Model model) {
		model.addAttribute("pmFrozenLoveDetailLog", pmFrozenLoveDetailLog); 
		return "modules/frozenLove/pmFrozenLoveDetailLogForm";
	}
	
	
	
}
