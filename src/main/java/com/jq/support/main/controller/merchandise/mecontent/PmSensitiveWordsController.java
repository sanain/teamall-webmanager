package com.jq.support.main.controller.merchandise.mecontent;

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
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.PmQaHelp;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.PmSensitiveWords;
import com.jq.support.service.merchandise.mecontent.PmSensitiveWordsService;
import com.jq.support.service.utils.SysUserUtils;



@Controller
@RequestMapping(value = "${adminPath}/PmSensitiveWords")
public class PmSensitiveWordsController extends BaseController{
	@Autowired
	private PmSensitiveWordsService pmSensitiveWordsService;
	
	
	@ModelAttribute
	public PmSensitiveWords get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmSensitiveWordsService.getPmSensitiveWords(id);
		}else{
			return new PmSensitiveWords();
		}
	}
	
	@RequiresPermissions("merchandise:PmSensitiveWords:view")
	@RequestMapping(value = {"list", ""})
	public String list(
			PmSensitiveWords pmSensitiveWords, 
			HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<PmSensitiveWords> page=pmSensitiveWordsService.getPageList(pmSensitiveWords, new Page<PmSensitiveWords>(request, response));
		    model.addAttribute("page", page);
		    model.addAttribute("pmSensitiveWords", pmSensitiveWords);
		    return "modules/shopping/Article/PmSensitiveWordsList";
	}
	
	@RequiresPermissions("merchandise:PmSensitiveWords:view")
	@RequestMapping(value = "form")
	public String form(PmSensitiveWords pmSensitiveWords, HttpServletRequest request, HttpServletResponse response, Model model){
		    model.addAttribute("pmSensitiveWords", pmSensitiveWords);
		    return "modules/shopping/Article/PmSensitiveWordsFrom";
	}
	
	@RequiresPermissions("merchandise:PmSensitiveWords:edit")
	@RequestMapping(value = "save")
	public String save(PmSensitiveWords pmSensitiveWords, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      SysUser user = SysUserUtils.getUser();
		       if(pmSensitiveWords.getId()!=null){ 
		    	   pmSensitiveWords.setCreateUser(user.getName());
		    	   pmSensitiveWords.setCreateTime(new Date());
				}else{
				   pmSensitiveWords.setModifyUser(user.getName());
				   pmSensitiveWords.setModifyTime(new Date());
		      }
		       pmSensitiveWordsService.save(pmSensitiveWords);
		      addMessage(redirectAttributes, "保存成功");
	  	return "redirect:"+Global.getAdminPath()+"/PmSensitiveWords/list";
	}
	
	@RequiresPermissions("merchandise:PmSensitiveWords:edit")
	@RequestMapping(value = "delete")
	public String delete(PmSensitiveWords pmSensitiveWords, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      pmSensitiveWordsService.delete(pmSensitiveWords);
		      addMessage(redirectAttributes, "删除成功");
	  	return "redirect:"+Global.getAdminPath()+"/PmSensitiveWords/list";
	}

}
