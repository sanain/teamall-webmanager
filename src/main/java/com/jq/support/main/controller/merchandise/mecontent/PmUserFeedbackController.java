package com.jq.support.main.controller.merchandise.mecontent;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jq.support.common.utils.StringUtils;
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
import com.jq.support.model.product.PmUserFeedback;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.mecontent.PmUserFeedbackService;
import com.jq.support.service.utils.SysUserUtils;

@Controller
@RequestMapping(value = "${adminPath}/PmUserFeedback")
public class PmUserFeedbackController extends BaseController {
	@Autowired
	private PmUserFeedbackService pmUserFeedbackService;
	
	@ModelAttribute
	public PmUserFeedback get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmUserFeedbackService.getSbUserFeedback(id);
		}else{
			return new PmUserFeedback();
		}
	}
	
	@RequiresPermissions("merchandise:PmUserFeedback:view")
	@RequestMapping(value = {"list", ""})
	public String list(
			PmUserFeedback sbUserFeedback, 
			HttpServletRequest request, HttpServletResponse response, Model model){

		Page<PmUserFeedback> page=pmUserFeedbackService.getPageList(sbUserFeedback, new Page<PmUserFeedback>(request, response));

		List<String []> imgUrlList = new ArrayList<String[]>();

		for (PmUserFeedback feedback:page.getList()) {
			String urls = feedback.getFbPicUrl();

			if(StringUtils.isBlank(urls)){
				imgUrlList.add(new String[0]);
				continue;
			}

			String[] imageUrlArr = urls.split(",");
			imgUrlList.add(imageUrlArr);

		}
		    model.addAttribute("page", page);
		    model.addAttribute("sbUserFeedback", sbUserFeedback);
		    model.addAttribute("imgUrlList", imgUrlList);
		    return "modules/shopping/Article/SbUserFeedbackList";
	}
	@RequiresPermissions("merchandise:PmUserFeedback:view")
	@RequestMapping(value = "form")
	public String form(PmUserFeedback sbUserFeedback, HttpServletRequest request, HttpServletResponse response, Model model){
		    model.addAttribute("sbUserFeedback", sbUserFeedback);
		String fbPicUrl = sbUserFeedback.getFbPicUrl();

		String[] imgUrlArr = new String[0];
		if(StringUtils.isNotBlank(fbPicUrl)){
			imgUrlArr = fbPicUrl.split(",");
		}

		model.addAttribute("imgUrlArr",imgUrlArr);
		return "modules/shopping/Article/SbUserFeedbackFrom";
	}
	@RequiresPermissions("merchandise:PmUserFeedback:edit")
	@RequestMapping(value = "save")
	public String save(PmUserFeedback sbUserFeedback, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      SysUser user = SysUserUtils.getUser();
		       if(sbUserFeedback.getId()!=null){ 
		    	   sbUserFeedback.setCreateUser(user.getName());
		    	   sbUserFeedback.setCreateTime(new Date());
				}else{
					sbUserFeedback.setModifyUser(user.getName());
					sbUserFeedback.setModifyTime(new Date());
		      }
		       pmUserFeedbackService.save(sbUserFeedback);
		      addMessage(redirectAttributes, "保存成功");
	  	return "redirect:"+Global.getAdminPath()+"/PmUserFeedback/list";
	}
	
	
	
	@RequiresPermissions("merchandise:PmUserFeedback:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      PmUserFeedback sbUserFeedback=pmUserFeedbackService.getSbUserFeedback(id);
		      pmUserFeedbackService.delete(sbUserFeedback);
		      addMessage(redirectAttributes, "删除成功");
	  	return "redirect:"+Global.getAdminPath()+"/PmUserFeedback/list";
	}
	
	
	

}
