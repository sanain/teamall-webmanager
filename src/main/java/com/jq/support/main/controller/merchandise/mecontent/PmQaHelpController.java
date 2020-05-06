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
import com.jq.support.model.product.PmQaHelp;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.mecontent.PmQaHelpService;
import com.jq.support.service.utils.SysUserUtils;




@Controller
@RequestMapping(value = "${adminPath}/PmQaHelp")
public class PmQaHelpController extends BaseController {
	@Autowired
	private PmQaHelpService pmQaHelpService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String domain = Global.getConfig("domain");
	private static String innerImgPartPath = "src=\"/uploads";
	private static String innerImgPartPath_1 = "src=\"/" + domain + "/uploads";
	private static String innerImgFullPath = "src=\"" + domainurl + "/uploads";
	
	
	@ModelAttribute
	public PmQaHelp get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmQaHelpService.getSbQaHelp(id);
		}else{
			return new PmQaHelp();
		}
	}
	
	@RequiresPermissions("merchandise:PmQaHelp:view")
	@RequestMapping(value = {"list", ""})
	public String list(
			PmQaHelp sbQaHelp, 
			HttpServletRequest request, HttpServletResponse response, Model model){
			sbQaHelp.setDelFlag("0,1");
			Page<PmQaHelp> page=pmQaHelpService.getPageList(sbQaHelp, new Page<PmQaHelp>(request, response));
		    model.addAttribute("page", page);
		    model.addAttribute("sbQaHelp", sbQaHelp);
		    return "modules/shopping/Article/SbQaHelpList";
	}
	@RequiresPermissions("merchandise:PmQaHelp:view")
	@RequestMapping(value = "form")
	public String form(PmQaHelp sbQaHelp, HttpServletRequest request, HttpServletResponse response, Model model){
		    model.addAttribute("sbQaHelp", sbQaHelp);
		    createPicFold(request);
		    return "modules/shopping/Article/SbQaHelpFrom";
	}
	@RequiresPermissions("merchandise:PmQaHelp:edit")
	@RequestMapping(value = "save")
	public String save(PmQaHelp sbQaHelp, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      SysUser user = SysUserUtils.getUser();
		       if(sbQaHelp.getId()!=null){
				   sbQaHelp.setModifyUser(user.getName());
				   sbQaHelp.setModifyTime(new Date());
				}else{
					sbQaHelp.setCreateUser(user.getName());
					sbQaHelp.setCreateTime(new Date());
					sbQaHelp.setModifyUser(user.getName());
					sbQaHelp.setModifyTime(new Date());
		      }
		       
		       if (sbQaHelp.getContent()!=null){
		    	   sbQaHelp.setContent(StringEscapeUtils.unescapeHtml4(sbQaHelp.getContent()));
				}
				String content = sbQaHelp.getContent();
				// ===========集群文件处理 start===============
//				String wfsName = Global.getConfig("wfsName");
//				if (StringUtils.isNotBlank(wfsName)) {
//					innerImgPartPath = "src=\"/uploads/" + wfsName + "/images/";
//					innerImgFullPath = "src=\"" + domainurl  + "/uploads/" + wfsName + "/images/";
//				}
				// ===========集群文件字段处理 end===============
//				if (StringUtils.contains(content, innerImgPartPath)) {
//					content = content.replace(innerImgPartPath, innerImgFullPath);
//				}
				sbQaHelp.setContent(htmltoUrl(content));
		       pmQaHelpService.save(sbQaHelp);
		      addMessage(redirectAttributes, "保存成功");
	  	return "redirect:"+Global.getAdminPath()+"/PmQaHelp/list";
	}
	public String htmltoUrl(String html) {
		String wfsName = Global.getConfig("wfsName");
		if (StringUtils.isNotBlank(wfsName)) {
			innerImgPartPath = innerImgPartPath + "/" + wfsName;
			innerImgPartPath_1 = innerImgPartPath_1 + "/" + wfsName;
		}
		if (StringUtils.contains(html, innerImgPartPath)) {
			html = html.replace(innerImgPartPath, innerImgFullPath);
		}
		if (StringUtils.contains(html, innerImgPartPath_1)) {
			html = html.replace(innerImgPartPath_1, innerImgFullPath);
		}

		return html;
	}
	
	
	@RequiresPermissions("merchandise:PmQaHelp:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      PmQaHelp sbQaHelp=pmQaHelpService.getSbQaHelp(id);
		      sbQaHelp.setDelFlag("2");
		      pmQaHelpService.save(sbQaHelp);
		      addMessage(redirectAttributes, "删除成功");
	  	return "redirect:"+Global.getAdminPath()+"/PmQaHelp/list";
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
		folder.append("SbQaHelp");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
	
	
	
	
}
