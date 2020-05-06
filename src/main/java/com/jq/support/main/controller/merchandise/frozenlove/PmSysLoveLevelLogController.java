package com.jq.support.main.controller.merchandise.frozenlove;
import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
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
import com.jq.support.model.frozenlove.PmSysLoveLevelLog;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.frozenlove.PmSysLoveLevelLogService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 系统每日红包级别数日志Controller
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/pmSysLoveLevelLog")
public class PmSysLoveLevelLogController  extends BaseController{
	@Autowired
	private PmSysLoveLevelLogService pmSysLoveLevelLogService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/upload/images/";
	private static String innerImgFullPath = "src=\"" + domainurl + "/upload/images/";
	
	
	@ModelAttribute
	public PmSysLoveLevelLog get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return pmSysLoveLevelLogService.get(Integer.valueOf(id));
		}else{
			return new PmSysLoveLevelLog();
		}
	}
	
	
	/**
	 * 列表
	 * @param request
	 * @return
	 */
	@RequiresPermissions("pmSysLoveLevelLog:info:view")
	@RequestMapping({"list", ""})
	public String pmSysLoveLevelLogList(PmSysLoveLevelLog pmSysLoveLevelLog, HttpServletRequest request,HttpServletResponse response, Model model){
		Page<PmSysLoveLevelLog> page = pmSysLoveLevelLogService.findPmSysLoveLevelLogList(new Page<PmSysLoveLevelLog>(request, response), pmSysLoveLevelLog);
		model.addAttribute("page", page);
		return "modules/frozenlove/pmSysLoveLevelLogList";
	}
	
	
	@RequiresPermissions("pmSysLoveLevelLog:info:view")
	@RequestMapping(value = "form")
	public String form(PmSysLoveLevelLog pmSysLoveLevelLog, HttpServletRequest request, Model model) {
		return formSearch(pmSysLoveLevelLog, model);
	}
	
	private String formSearch(PmSysLoveLevelLog pmSysLoveLevelLog, Model model) {
		List<PmSysLoveLevelLog>  list=pmSysLoveLevelLogService.getPmSysLoveLevelLogList(pmSysLoveLevelLog, 0, 1);
		if (CollectionUtils.isNotEmpty(list)) {
			model.addAttribute("pmSysLoveLevelLog", list.get(0)); 
		}else {
			model.addAttribute("pmSysLoveLevelLog", pmSysLoveLevelLog); 
		}
		return "modules/frozenlove/pmSysLoveLevelLogForm";
	}
	
	/**
	 * 保存
	 */
	@RequiresPermissions("pmSysLoveLevelLog:info:edit")
	@RequestMapping(value = "save")
	public String save(PmSysLoveLevelLog pmSysLoveLevelLog, Model model,HttpServletRequest request, RedirectAttributes redirectAttributes) {
        if (pmSysLoveLevelLog.getId()!=null) {
		}else {
			pmSysLoveLevelLog.setCreateTime(new Date());
		}
		pmSysLoveLevelLogService.save(pmSysLoveLevelLog);
		return "redirect:" + Global.getAdminPath() + "/pmSysLoveLevelLog/form";
	}
	
	
	/**
	 * 删除
	 */
	@RequiresPermissions("pmSysLoveLevelLog:info:edit")
	@RequestMapping(value = "deleteService")
	public String deleteProject(String ids[],String spackId,RedirectAttributes redirectAttributes, HttpServletRequest request) {
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + Global.getAdminPath() + "/pmSysLoveLevelLog/list";
	}
	
	/**
	 * 执行
	 */
	@RequiresPermissions("pmSysLoveLevelLog:info:edit")
	@RequestMapping(value = "updateProcess")
	@Transactional(readOnly = false)
	public String updateProcess(String id,RedirectAttributes redirectAttributes, HttpServletRequest request) {
		addMessage(redirectAttributes, "执行成功");
		return "redirect:" + Global.getAdminPath() + "/pmSysLoveLevelLog/list";
	}
	
	/**
	 * 详情
	 */
	@RequiresPermissions("pmSysLoveLevelLog:info:view")
	@RequestMapping(value = "detail")
	public String detail(PmSysLoveLevelLog pmSysLoveLevelLog,RedirectAttributes redirectAttributes, HttpServletRequest request, Model model) {
		model.addAttribute("pmSysLoveLevelLog", pmSysLoveLevelLog); 
		return "modules/pmSysLoveLevelLog/pmFrozenLoveDetail";
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
		folder.append("pmSysLoveLevelLog");
		folder.append(File.separator);
		folder.append("pmSysLoveLevelLogIcon");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator); 
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
	

	
	
	
}
