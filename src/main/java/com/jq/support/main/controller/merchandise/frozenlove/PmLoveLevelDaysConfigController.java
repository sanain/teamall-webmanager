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
import com.jq.support.model.frozenlove.PmLoveLevelDaysConfig;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.frozenlove.PmLoveLevelDaysConfigService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 红包级别天数配置Controller
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/pmLoveLevelDaysConfig")
public class PmLoveLevelDaysConfigController  extends BaseController{
	@Autowired
	private PmLoveLevelDaysConfigService pmLoveLevelDaysConfigService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/upload/images/";
	private static String innerImgFullPath = "src=\"" + domainurl + "/upload/images/";
	
	
	@ModelAttribute
	public PmLoveLevelDaysConfig get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return pmLoveLevelDaysConfigService.get(Integer.valueOf(id));
		}else{
			return new PmLoveLevelDaysConfig();
		}
	}
	
	
	/**
	 * 列表
	 * @param request
	 * @return
	 */
	@RequiresPermissions("pmLoveLevelDaysConfig:info:view")
	@RequestMapping({"list", ""})
	public String pmLoveLevelDaysConfigList(PmLoveLevelDaysConfig pmLoveLevelDaysConfig, HttpServletRequest request,HttpServletResponse response, Model model){
		Page<PmLoveLevelDaysConfig> page = pmLoveLevelDaysConfigService.findPmLoveLevelDaysConfigList(new Page<PmLoveLevelDaysConfig>(request, response), pmLoveLevelDaysConfig);
		model.addAttribute("page", page);
		return "modules/pmLoveLevelDaysConfig/pmLoveLevelDaysConfigList";
	}
	
	
	@RequiresPermissions("pmLoveLevelDaysConfig:info:view")
	@RequestMapping(value = "form")
	public String form(PmLoveLevelDaysConfig pmLoveLevelDaysConfig, HttpServletRequest request, Model model) {
		return formSearch(pmLoveLevelDaysConfig, model);
	}
	
	private String formSearch(PmLoveLevelDaysConfig pmLoveLevelDaysConfig, Model model) {
		List<PmLoveLevelDaysConfig>  list=pmLoveLevelDaysConfigService.getPmLoveLevelDaysConfigList(pmLoveLevelDaysConfig, 0, 1);
		if (CollectionUtils.isNotEmpty(list)) {
			model.addAttribute("pmLoveLevelDaysConfig", list.get(0)); 
		}else {
			model.addAttribute("pmLoveLevelDaysConfig", pmLoveLevelDaysConfig); 
		}
		return "modules/frozenlove/pmLoveLevelDaysConfigForm";
	}
	
	/**
	 * 保存
	 */
	@RequiresPermissions("pmLoveLevelDaysConfig:info:edit")
	@RequestMapping(value = "save")
	public String save(PmLoveLevelDaysConfig pmLoveLevelDaysConfig, Model model,HttpServletRequest request, RedirectAttributes redirectAttributes) {
        if (pmLoveLevelDaysConfig.getId()!=null) {
        	pmLoveLevelDaysConfig.setModifyTime(new Date());
		}else {
			pmLoveLevelDaysConfig.setCreateTime(new Date());
		}
		pmLoveLevelDaysConfigService.save(pmLoveLevelDaysConfig);
		return "redirect:" + Global.getAdminPath() + "/pmLoveLevelDaysConfig/form";
	}
	
	
	/**
	 * 删除
	 */
	@RequiresPermissions("pmLoveLevelDaysConfig:info:edit")
	@RequestMapping(value = "deleteService")
	public String deleteProject(String ids[],String spackId,RedirectAttributes redirectAttributes, HttpServletRequest request) {
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + Global.getAdminPath() + "/pmLoveLevelDaysConfig/list";
	}
	
	/**
	 * 执行
	 */
	@RequiresPermissions("pmLoveLevelDaysConfig:info:edit")
	@RequestMapping(value = "updateProcess")
	@Transactional(readOnly = false)
	public String updateProcess(String id,RedirectAttributes redirectAttributes, HttpServletRequest request) {
		addMessage(redirectAttributes, "执行成功");
		return "redirect:" + Global.getAdminPath() + "/pmLoveLevelDaysConfig/list";
	}
	
	/**
	 * 详情
	 */
	@RequiresPermissions("pmLoveLevelDaysConfig:info:view")
	@RequestMapping(value = "detail")
	public String detail(PmLoveLevelDaysConfig pmLoveLevelDaysConfig,RedirectAttributes redirectAttributes, HttpServletRequest request, Model model) {
		model.addAttribute("pmLoveLevelDaysConfig", pmLoveLevelDaysConfig); 
		return "modules/pmLoveLevelDaysConfig/pmFrozenLoveDetail";
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
		folder.append("pmLoveLevelDaysConfig");
		folder.append(File.separator);
		folder.append("pmLoveLevelDaysConfigIcon");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator); 
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
	

	
	
	
}
