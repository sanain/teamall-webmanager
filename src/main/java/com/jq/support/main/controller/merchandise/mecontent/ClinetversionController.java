package com.jq.support.main.controller.merchandise.mecontent;

import java.io.File;
import java.io.IOException;
import java.util.Date;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.Clinetversion;
import com.jq.support.model.product.EbProduct;
import com.jq.support.model.product.PmProductType;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.mecontent.ClinetversionService;
import com.jq.support.service.utils.CommonFile;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 版本更新Controller
 * @author Administrator
 *
 */



@Controller
@RequestMapping(value = "${adminPath}/Clinetversion")
public class ClinetversionController extends BaseController {
	@Autowired
	private ClinetversionService clinetversionService;
	
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
	
	@ModelAttribute
	public Clinetversion get(@RequestParam(required=false) String versionId) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(versionId)){
			return clinetversionService.getClinetversion(versionId);
		}else{
			return new Clinetversion();
		}
	}
	
	@RequiresPermissions("merchandise:Clinetversion:view")
	@RequestMapping(value = {"list", ""})
	public String getProductList(
			Clinetversion clinetversion, 
			HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<Clinetversion> page=clinetversionService.getPageList(clinetversion, new Page<Clinetversion>(request, response));
		    model.addAttribute("page", page);
		    model.addAttribute("clinetversion", clinetversion);
		    return "modules/shopping/Article/clinetversionlist";
	}
	@RequiresPermissions("merchandise:Clinetversion:view")
	@RequestMapping(value = "form")
	public String form(Clinetversion clinetversion, HttpServletRequest request, HttpServletResponse response, Model model){
		    model.addAttribute("clinetversion", clinetversion);
		    return "modules/shopping/Article/clinetversionfrom";
	}
	
	@RequiresPermissions("merchandise:Clinetversion:edit")
	@RequestMapping(value = "save")
	public String save(Clinetversion clinetversion, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      MultipartHttpServletRequest multipartRequest  =  (MultipartHttpServletRequest) request;  
		      MultipartFile imgFile1 =  multipartRequest.getFile("file");
		      if(imgFile1.getSize()>0){
		    	  CommonFile commonfile=new CommonFile();
				  String versionSrc= commonfile.filename(imgFile1, multipartRequest);
				  clinetversion.setVersionSrc(versionSrc);
		      }
		      SysUser user = SysUserUtils.getUser();
		       if(clinetversion.getVersionId()!=null){ 
		    	    clinetversion.setCreateUser(user.getName());
		    	    clinetversion.setCreateTime(new Date());
				}else{
					clinetversion.setModifyUser(user.getName());
					clinetversion.setModifyTime(new Date());
		      }
		      clinetversionService.save(clinetversion);
		      addMessage(redirectAttributes, "保存成功");
	  	return "redirect:"+Global.getAdminPath()+"/Clinetversion/list";
	}
	
	
	
	@RequiresPermissions("merchandise:Clinetversion:edit")
	@RequestMapping(value = "delete")
	public String delete(String versionId, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      Clinetversion clinetversion=clinetversionService.getClinetversion(versionId);
		      clinetversionService.delete(clinetversion);
		      addMessage(redirectAttributes, "删除成功");
	  	return "redirect:"+Global.getAdminPath()+"/Clinetversion/list";
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
		folder.append("images" );
		folder.append(File.separator);
		folder.append("merchandise");
		folder.append(File.separator);
		folder.append("file");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
}
