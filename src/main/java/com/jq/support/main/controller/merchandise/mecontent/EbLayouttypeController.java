package com.jq.support.main.controller.merchandise.mecontent;

import java.io.File;

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

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.EbLayouttype;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.mecontent.EbLayouttypeService;
import com.jq.support.service.utils.SysUserUtils;




@Controller
@RequestMapping(value = "${adminPath}/template")
public class EbLayouttypeController extends BaseController{
		@Autowired
		private EbLayouttypeService ebLayouttypeService;


		
		private static String domainurl = Global.getConfig("domainurl");
		private static String innerImgPartPath = "src=\"/uploads/images/";
		private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
		
		@ModelAttribute
		public  EbLayouttype get(@RequestParam(required=false) String id) {
			if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
				return ebLayouttypeService.geteblLayouttype(id);
			}else{
				return new  EbLayouttype();
			}
		}
		
		@RequiresPermissions("merchandise:template:view")
		@RequestMapping(value = {"list", ""})
		public String getProductList(
				EbLayouttype ebLayouttype,
				HttpServletRequest request, HttpServletResponse response, Model model){
				SysUser user=SysUserUtils.getUser();
				SysOffice sysOffice=user.getCompany();
				if(sysOffice!=null){
					ebLayouttype.setAgentId(sysOffice.getId());
				    Page<EbLayouttype> page=ebLayouttypeService.getPageList(new Page<EbLayouttype>(request, response),ebLayouttype);
				    model.addAttribute("page", page);
				    model.addAttribute("ebLayouttype", ebLayouttype);
				}
			    return "modules/shopping/Article/templateList";
		}
		
		@RequiresPermissions("merchandise:template:view")
		@RequestMapping(value = "form")
		public String form(
				EbLayouttype ebLayouttype,
				HttpServletRequest request, HttpServletResponse response, Model model){
			    model.addAttribute("ebLayouttype", ebLayouttype);
			    createPicFold(request);
			    return "modules/shopping/Article/templateForm";
		}

		
		@RequiresPermissions("merchandise:template:edit")
		@RequestMapping(value = "save")
		public String save(
				EbLayouttype ebLayouttype,
				HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
				SysUser user=SysUserUtils.getUser();
				SysOffice sysOffice=user.getCompany();
				if(sysOffice!=null){    
					ebLayouttype.setAgentId(sysOffice.getId());
				}
					ebLayouttypeService.save(ebLayouttype);
				
			    addMessage(redirectAttributes, "保存成功");
				return "redirect:"+Global.getAdminPath()+"/template/list";
		}
		
		@RequiresPermissions("merchandise:template:edit")
		@RequestMapping(value = "delete")
		public String delete(
				EbLayouttype ebLayouttype,
				HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
			    ebLayouttypeService.delete(ebLayouttype);
			    addMessage(redirectAttributes, "删除成功");
				return "redirect:"+Global.getAdminPath()+"/template/list";
		}
		
		@ResponseBody
		@RequestMapping(value = "geturl")
		public String geturl(HttpServletRequest request, HttpServletResponse response) {
			String url="";
			String layouttypeId=request.getParameter("layouttypeId");
			if(StringUtils.isNotBlank(layouttypeId)){
				EbLayouttype ebLayouttype=ebLayouttypeService.geteblLayouttype(layouttypeId);
				url=ebLayouttype.getModuleDemoUrl();
				System.out.println(url);
			}
			return url;
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
			folder.append("images");
			folder.append(File.separator);
			folder.append("merchandise");
			folder.append(File.separator);
			folder.append("template");
			folder.append(File.separator);
			folder.append(DateUtils.getYear());
			folder.append(File.separator);
			folder.append(DateUtils.getMonth());
			FileUtils.createDirectory(folder.toString());
		}
		
		
		
		
}
