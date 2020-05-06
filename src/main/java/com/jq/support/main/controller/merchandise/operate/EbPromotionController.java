package com.jq.support.main.controller.merchandise.operate;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.promotion.EbPrize;
import com.jq.support.model.promotion.EbPromotion;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.promotion.EbPrizeService;
import com.jq.support.service.merchandise.promotion.EbPromotionService;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 活动 Controller
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/promotion")
public class EbPromotionController  extends BaseController{
	@Autowired
	private EbPromotionService ebPromotionService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl + "/uploads/images/";

	/**
	 * 活动列表
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping({"list", ""})
	public String promotionList(EbPromotion ebPromotion, HttpServletRequest request,HttpServletResponse response, Model model){
		Page<EbPromotion> page = ebPromotionService.findEbPromotionList(new Page<EbPromotion>(request, response), ebPromotion);
		model.addAttribute("page", page);
		model.addAttribute("ebPromotion", ebPromotion);
		return "modules/operate/promotionList";
	}
	
	@RequiresPermissions("promotion:info:view")
	@RequestMapping(value = "form")
	public String form(HttpServletRequest request, Model model) {
		String promotionId = (String) request.getParameter("promotionId");
		if(StringUtils.isNotBlank(promotionId)){
			EbPromotion ebPromotion = ebPromotionService.get(promotionId);
			model.addAttribute("ebPromotion", ebPromotion);
		}else{
			EbPromotion ebPromotion = new EbPromotion();
			model.addAttribute("ebPromotion", ebPromotion);
		}
		return "modules/operate/promotionForm";
	}
	
	/**
	 * 保存
	 */
	@RequiresPermissions("promotion:info:edit")
	@RequestMapping(value = "save")
	public String save(EbPromotion ebPromotion, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		SysUser user = SysUserUtils.getUser();
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + Global.getAdminPath() + "/promotion/list";
		}else{
			if(ebPromotion.getPromotionId() != null){
				ebPromotionService.update(ebPromotion);
			}else{
				ebPromotion.setCreateTime(new Date());
				ebPromotionService.save(ebPromotion);
			}
			return "redirect:" + Global.getAdminPath() + "/promotion/list";
		}
	}
	
	/**
	 * 删除
	 */
	@RequiresPermissions("promotion:info:edit")
	@RequestMapping(value = "delete")
	public String deleteProject(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		String promotionId = (String) request.getParameter("promotionId");
		if(StringUtils.isNotBlank(promotionId)){
			ebPromotionService.delete(promotionId);
		}
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + Global.getAdminPath() + "/promotion/list";
	}
		
}
