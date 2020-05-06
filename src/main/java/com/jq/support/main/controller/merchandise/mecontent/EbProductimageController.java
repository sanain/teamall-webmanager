package com.jq.support.main.controller.merchandise.mecontent;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.jq.support.model.product.EbProductimage;
import com.jq.support.service.merchandise.mecontent.EbProductimageService;




@Controller
public class EbProductimageController extends BaseController{
	@Autowired
	private EbProductimageService ebProductimageService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
	
	@ModelAttribute
	public EbProductimage get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return ebProductimageService.getebpEbProductimage(id);
		}else{
			return new EbProductimage();
		}
	}
	
	@RequiresPermissions("merchandise:template:view")
	@RequestMapping(value = {"list", ""})
	public String getProductList(
			EbProductimage ebProductimage, 
			HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<EbProductimage> page=ebProductimageService.getPageList(new Page<EbProductimage>(request, response),ebProductimage);
		    model.addAttribute("page", page);
		    model.addAttribute("ebProductimage", ebProductimage);
		    return "modules/shopping/Article/templateList";
	}
	
	@RequiresPermissions("merchandise:template:view")
	@RequestMapping(value = "form")
	public String form(
			EbProductimage ebProductimage, 
			HttpServletRequest request, HttpServletResponse response, Model model){
		    model.addAttribute("ebProductimage", ebProductimage);
		    return "modules/shopping/Article/templateForm";
	}

	
	@RequiresPermissions("merchandise:template:edit")
	@RequestMapping(value = "save")
	public String save(
			EbProductimage ebProductimage, 
			HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		    ebProductimageService.save(ebProductimage);
		    addMessage(redirectAttributes, "保存成功");
			return "redirect:"+Global.getAdminPath()+"/template/list";
	}
	@RequiresPermissions("merchandise:template:edit")
	@RequestMapping(value = "delete")
	public String delete(
			EbProductimage ebProductimage, 
			HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		    ebProductimageService.save(ebProductimage);
		    addMessage(redirectAttributes, "删除成功");
			return "redirect:"+Global.getAdminPath()+"/template/list";
	}
	
	
	
	
	
	
}
