package com.jq.support.main.controller.merchandise.order;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.pay.PmLovePayDeploy;
import com.jq.support.service.pay.PmLovePayDeployService;
import com.jq.support.service.utils.DateUtil;




@Controller
@RequestMapping(value = "${adminPath}/pmLovePayDeploy")
public class PmLovePayDeployController extends BaseController{
	@Autowired
	private PmLovePayDeployService pmLovePayDeployService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
	
	@ModelAttribute
	public PmLovePayDeploy get(String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmLovePayDeployService.get(Integer.valueOf(id));
		}else{
			return new PmLovePayDeploy();
		}
	}
	
	@RequiresPermissions("order:pmLovePayDeploy:view")
	@RequestMapping(value = {"list", ""})
	public String getPmLovePayDeployList(PmLovePayDeploy pmLovePayDeploy, HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<PmLovePayDeploy> page=pmLovePayDeployService.findPmLovePayDeployList(new Page<PmLovePayDeploy>(request, response),pmLovePayDeploy);
		    model.addAttribute("page", page);
		    model.addAttribute("pmLovePayDeploy", pmLovePayDeploy);
		    return "modules/shopping/order/pmLovePayDeployList";
	}
	
	@RequiresPermissions("order:pmLovePayDeploy:view")
	@RequestMapping(value = "form")
	public String form(PmLovePayDeploy pmLovePayDeploy, HttpServletRequest request, HttpServletResponse response, Model model){
		    model.addAttribute("pmLovePayDeploy", pmLovePayDeploy);
		    return "modules/shopping/order/pmLovePayDeployForm";
	}

	
	@RequiresPermissions("order:pmLovePayDeploy:edit")
	@RequestMapping(value = "save")
	public String save(PmLovePayDeploy pmLovePayDeploy, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		    if (pmLovePayDeploy.getId()==null) {
		    	if (pmLovePayDeploy.getLovePayEffectType()!=null&&pmLovePayDeploy.getLovePayEffectType()==1) {//只有一个默认
		    	List<PmLovePayDeploy> payDeploys=pmLovePayDeployService.getBylovePayEffectType(1);
		    	if (CollectionUtils.isNotEmpty(payDeploys)) {
		    		addMessage(redirectAttributes, "失败，默认已存在");
		    		return "redirect:"+Global.getAdminPath()+"/pmLovePayDeploy/list";
		    	 }else {
		    		 pmLovePayDeploy.setLovePayEndDate(null);
		    		 pmLovePayDeploy.setLovePayStartDate(null);
				}
		    	}
		    	if (pmLovePayDeploy.getLovePayEffectType()!=null&&pmLovePayDeploy.getLovePayEffectType()==2) {//时间区间
		    		boolean isdate=pmLovePayDeployService.getInTime(pmLovePayDeploy);//判断是否在时间段
		    		if (isdate) {
	    				addMessage(redirectAttributes, "失败，时间段已存在");
			    		return "redirect:"+Global.getAdminPath()+"/pmLovePayDeploy/list";
					}
		    	}
		    	pmLovePayDeploy.setCreateTime(new Date());
			}else {
				if (pmLovePayDeploy.getLovePayEffectType()!=null&&pmLovePayDeploy.getLovePayEffectType()==2) {//时间区间
		    		boolean isdate=pmLovePayDeployService.getInTime(pmLovePayDeploy);//判断是否在时间段
		    		if (isdate) {
	    				addMessage(redirectAttributes, "失败，时间段已存在");
			    		return "redirect:"+Global.getAdminPath()+"/pmLovePayDeploy/list";
					}
		    	}
				pmLovePayDeploy.setModifyTime(new Date());
			}
		    pmLovePayDeployService.save(pmLovePayDeploy);
		    addMessage(redirectAttributes, "保存成功");
			return "redirect:"+Global.getAdminPath()+"/pmLovePayDeploy/list";
	}
	@RequiresPermissions("order:pmLovePayDeploy:edit")
	@RequestMapping(value = "delete")
	public String delete(
			PmLovePayDeploy pmLovePayDeploy, 
			HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		    pmLovePayDeployService.save(pmLovePayDeploy);
		    addMessage(redirectAttributes, "删除成功");
			return "redirect:"+Global.getAdminPath()+"/template/list";
	}
	
	/**
	 * 删除
	 */
	@RequiresPermissions("order:pmLovePayDeploy:edit")
	@RequestMapping(value = "deleteAll")
	public String deleteProject(String ids[],RedirectAttributes redirectAttributes, HttpServletRequest request) {
		for (int i = 0; i < ids.length; i++) {
			PmLovePayDeploy pmLovePayDeploy=pmLovePayDeployService.get(Integer.valueOf(ids[i]));
			if(pmLovePayDeploy!=null){
				pmLovePayDeployService.delete(pmLovePayDeploy);
			}
		}
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + Global.getAdminPath() + "/pmLovePayDeploy/list";
	}
	
	
	
	
}
