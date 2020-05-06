package com.jq.support.main.controller.merchandise.mecontent;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringEscapeUtils;
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
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.PmServiceProtocol;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.mecontent.PmServiceProtocolService;
import com.jq.support.service.utils.SysUserUtils;



/**
 * 
 * @author Administrator
 *
 */

@Controller
@RequestMapping(value = "${adminPath}/PmServiceProtocol")
public class PmServiceProtocolController extends BaseController {
	@Autowired
	private PmServiceProtocolService pmServiceProtocolService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
	
	
	@ModelAttribute
	public PmServiceProtocol get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmServiceProtocolService.getSbServiceProtocol(id);
		}else{
			return new PmServiceProtocol();
		}
	}
	
	@RequiresPermissions("merchandise:PmServiceProtocol:view")
	@RequestMapping(value = {"list", ""})
	public String list(
			PmServiceProtocol pmServiceProtocol, 
			HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<PmServiceProtocol> page=pmServiceProtocolService.getPageList(pmServiceProtocol, new Page<PmServiceProtocol>(request, response));
		    model.addAttribute("page", page);
		    model.addAttribute("sbServiceProtocol", pmServiceProtocol);
		    return "modules/shopping/Article/sbServiceProtocolList";
	}
	@RequiresPermissions("merchandise:PmServiceProtocol:view")
	@RequestMapping(value = "form")
	public String form(PmServiceProtocol pmServiceProtocol, HttpServletRequest request, HttpServletResponse response, Model model){
		createPicFold(request);
		model.addAttribute("sbServiceProtocol", pmServiceProtocol);
		return "modules/shopping/Article/sbServiceProtocolFrom";
	}
	
	
	@RequiresPermissions("merchandise:PmServiceProtocol:edit")
	@RequestMapping(value = "save")
	public String save(PmServiceProtocol pmServiceProtocol, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
		      SysUser user = SysUserUtils.getUser();
		       if(pmServiceProtocol.getId()!=null){ 
		    	   pmServiceProtocol.setCreateUser(user.getName());
		    	   pmServiceProtocol.setCreateTime(new Date());
				}else{
					if(StringUtils.isNotBlank(pmServiceProtocol.getCode())){
						PmServiceProtocol serviceProtocol=pmServiceProtocolService.getSbServiceProtocolCode(pmServiceProtocol.getCode());
					    if(serviceProtocol!=null){
					        addMessage(redirectAttributes, "code重复");
					        return "redirect:"+Global.getAdminPath()+"/PmServiceProtocol/list";
					    }
					}
					pmServiceProtocol.setModifyUser(user.getName());
					pmServiceProtocol.setModifyTime(new Date());
		       }
		       if (pmServiceProtocol.getContentInfo()!=null){
		    	   pmServiceProtocol.setContentInfo(StringEscapeUtils.unescapeHtml4(pmServiceProtocol.getContentInfo()));
				}
				String content = pmServiceProtocol.getContentInfo();
				
				// ===========集群文件处理 start===============
				String wfsName = Global.getConfig("wfsName");
				if (StringUtils.isNotBlank(wfsName)) {
					innerImgPartPath = "src=\"/uploads/" + wfsName + "/images/";
					innerImgFullPath = "src=\"" + domainurl  + "/uploads/" + wfsName + "/images/";
				}
				// ===========集群文件字段处理 end===============
				if (StringUtils.contains(content, innerImgPartPath)) {
					content = content.replace(innerImgPartPath, innerImgFullPath);
				}
				pmServiceProtocol.setContentInfo(content);
		       pmServiceProtocolService.save(pmServiceProtocol);
		      addMessage(redirectAttributes, "保存成功");
	  	return "redirect:"+Global.getAdminPath()+"/PmServiceProtocol/list";
	}
	
	
	
	@RequiresPermissions("merchandise:PmServiceProtocol:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      PmServiceProtocol pmServiceProtocol=pmServiceProtocolService.getSbServiceProtocol(id);
		      pmServiceProtocolService.delete(pmServiceProtocol);
		      addMessage(redirectAttributes, "删除成功");
	  	return "redirect:"+Global.getAdminPath()+"/PmServiceProtocol/list";
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
		folder.append("PmServiceProtocol");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
	
	
	
	
	
	
	
}
