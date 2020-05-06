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
import org.springframework.transaction.annotation.Transactional;
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
import com.jq.support.model.frozenlove.PmFrozenLoveOperateLog;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.frozenlove.PmFrozenLoveOperateLogService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 冻结操作记录表Controller
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/frozenLoveOperateLog")
public class PmFrozenLoveOperateLogController  extends BaseController{
	@Autowired
	private PmFrozenLoveOperateLogService pmFrozenLoveOperateLogService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/upload/images/";
	private static String innerImgFullPath = "src=\"" + domainurl + "/upload/images/";
	
	
	@ModelAttribute
	public PmFrozenLoveOperateLog get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return pmFrozenLoveOperateLogService.get(Integer.valueOf(id));
		}else{
			return new PmFrozenLoveOperateLog();
		}
	}
	
	
	/**
	 * 列表
	 * @param request
	 * @return
	 */
	@RequiresPermissions("frozenLove:info:view")
	@RequestMapping({"list", ""})
	public String pmFrozenLoveOperateLogList(PmFrozenLoveOperateLog pmFrozenLoveOperateLog, HttpServletRequest request,HttpServletResponse response, Model model){
		Page<PmFrozenLoveOperateLog> page = pmFrozenLoveOperateLogService.findPmFrozenLoveOperateLogList(new Page<PmFrozenLoveOperateLog>(request, response), pmFrozenLoveOperateLog);
		model.addAttribute("page", page);
		return "modules/frozenlove/pmFrozenLoveOperateLogList";
	}
	
	
	@RequiresPermissions("frozenLove:info:view")
	@RequestMapping(value = "form")
	public String form(PmFrozenLoveOperateLog pmFrozenLoveOperateLog, HttpServletRequest request, Model model) {
		// 创建广告图片存放目录
		//createPicFold(request);
		return formSearch(pmFrozenLoveOperateLog, model);
	}
	
	private String formSearch(PmFrozenLoveOperateLog pmFrozenLoveOperateLog, Model model) {
		model.addAttribute("pmFrozenLoveOperateLog", pmFrozenLoveOperateLog); 
		return "modules/frozenlove/pmFrozenLoveOperateLogForm";
	}
	
	/**
	 * 保存
	 */
	@RequiresPermissions("frozenLove:info:edit")
	@RequestMapping(value = "save")
	public String save(PmFrozenLoveOperateLog pmFrozenLoveOperateLog, Model model,HttpServletRequest request, RedirectAttributes redirectAttributes) {
		SysUser user=SysUserUtils.getUser();
		if (pmFrozenLoveOperateLog.getId()!=null) {
        	pmFrozenLoveOperateLog.setModifyTime(new Date());
		}else {
			pmFrozenLoveOperateLog.setOperateStatus(1);
			pmFrozenLoveOperateLog.setCreateTime(new Date());
		}
        if (pmFrozenLoveOperateLog.getFrozenType()!=3) {
        	pmFrozenLoveOperateLog.setStartDate(null);
        	pmFrozenLoveOperateLog.setEndDate(null);
		}
        pmFrozenLoveOperateLog.setCreateUser(user.getName());
		pmFrozenLoveOperateLogService.save(pmFrozenLoveOperateLog);
		return "redirect:" + Global.getAdminPath() + "/frozenLoveOperateLog/list";
	}
	
	
	/**
	 * 删除
	 */
	@RequiresPermissions("frozenLove:info:edit")
	@RequestMapping(value = "deleteService")
	public String deleteProject(String ids[],String spackId,RedirectAttributes redirectAttributes, HttpServletRequest request) {
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + Global.getAdminPath() + "/frozenLoveOperateLog/list";
	}
	
	/**
	 * 执行
	 */
	@RequiresPermissions("frozenLove:info:edit")
	@RequestMapping(value = "updateProcess")
	@Transactional(readOnly = false)
	public String updateProcess(String id,RedirectAttributes redirectAttributes, HttpServletRequest request) {
		if (StringUtils.isNotBlank(id)) {
			pmFrozenLoveOperateLogService.updateProcess(id);
		}
		addMessage(redirectAttributes, "执行成功");
		return "redirect:" + Global.getAdminPath() + "/frozenLoveOperateLog/list";
	}
	
	/**
	 * 详情
	 */
	@RequiresPermissions("frozenLove:info:view")
	@RequestMapping(value = "detail")
	public String detail(PmFrozenLoveOperateLog pmFrozenLoveOperateLog,RedirectAttributes redirectAttributes, HttpServletRequest request, Model model) {
		model.addAttribute("pmFrozenLoveOperateLog", pmFrozenLoveOperateLog); 
		return "modules/frozenlove/pmFrozenLoveDetail";
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
		folder.append("pmFrozenLoveOperateLog");
		folder.append(File.separator);
		folder.append("frozenLoveOperateLogIcon");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator); 
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
	

	
	
	
}
