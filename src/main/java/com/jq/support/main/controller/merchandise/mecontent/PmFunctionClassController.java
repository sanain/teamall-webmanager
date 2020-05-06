package com.jq.support.main.controller.merchandise.mecontent;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
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
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.PmFunctionClass;
import com.jq.support.model.product.PmQaHelp;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.mecontent.PmFunctionClassService;
import com.jq.support.service.utils.SysUserUtils;



@Controller
@RequestMapping(value = "${adminPath}/PmFunctionClass")
public class PmFunctionClassController extends BaseController{
	@Autowired
	private PmFunctionClassService pmFunctionClassService;
	
	@ModelAttribute
	public PmFunctionClass get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmFunctionClassService.getpmfClass(id);
		}else{
			return new PmFunctionClass();
		}
	}
	
	@RequiresPermissions("merchandise:PmFunctionClass:view")
	@RequestMapping(value = {"list", ""})
	public String list(
			PmFunctionClass pmFunctionClass, 
			HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<PmFunctionClass> page=pmFunctionClassService.getpmfClass(new Page<PmFunctionClass>(request, response),pmFunctionClass);
		    model.addAttribute("page", page);
		    model.addAttribute("pmFunctionClass", pmFunctionClass);
		    return "modules/shopping/Article/PmFunctionClassList";
	}
	@RequiresPermissions("merchandise:PmFunctionClass:view")
	@RequestMapping(value = "form")
	public String form(PmFunctionClass pmFunctionClass, HttpServletRequest request, HttpServletResponse response, Model model){
		    model.addAttribute("pmFunctionClass", pmFunctionClass);
		    createPicFold(request);
		    return "modules/shopping/Article/PmFunctionClassFrom";
	}
	@RequiresPermissions("merchandise:PmFunctionClass:edit")
	@RequestMapping(value = "save")
	public String save(PmFunctionClass pmFunctionClass, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      pmFunctionClassService.save(pmFunctionClass);
		      addMessage(redirectAttributes, "保存成功");
	  	return "redirect:"+Global.getAdminPath()+"/PmFunctionClass/list";
	}
	
	@RequiresPermissions("merchandise:PmFunctionClass:edit")
	@RequestMapping(value = "delete")
	public String delete(PmFunctionClass pmFunctionClass, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      pmFunctionClassService.delete(pmFunctionClass);
		      addMessage(redirectAttributes, "删除成功");
	  	return "redirect:"+Global.getAdminPath()+"/PmFunctionClass/list";
	}
	/**
	 * 创建图片存放目录
	 */
	private void createPicFold(HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("/");
		StringBuffer folder = new StringBuffer(root);
		folder.append("uploads");
		folder.append(File.separator);
		// ===========集群文件处理 start===============
		String wfsName = Global.getConfig("wfsName");
		if (StringUtils.isNotBlank(wfsName)) {
			folder.append(wfsName);
			folder.append(File.separator);
		}
		// ===========集群文件字段处理 end===============
		folder.append("000000");
		folder.append(File.separator);
		folder.append("images" );
		folder.append(File.separator);
		folder.append("merchandise");
		folder.append(File.separator);
		folder.append("getpmfClass");
		folder.append(File.separator);
		folder.append("adImg");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
	
	
}
