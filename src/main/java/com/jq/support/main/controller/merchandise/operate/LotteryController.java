package com.jq.support.main.controller.merchandise.operate;

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
import com.jq.support.common.web.BaseController;
import com.jq.support.model.promotion.EbPrize;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.promotion.EbPrizeService;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 转盘抽奖 Controller
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/lottery")
public class LotteryController  extends BaseController{
	@Autowired
	private EbPrizeService ebPrizeService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl + "/uploads/images/";

	/**
	 * 奖品池列表
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping({"list", ""})
	public String lotteryList(HttpServletRequest request,HttpServletResponse response, Model model){
		List<EbPrize> ebPrizeList = ebPrizeService.findAll();
		model.addAttribute("ebPrizeList", ebPrizeList);
		return "modules/operate/lotteryList";
	}
	
	@RequiresPermissions("lottery:info:view")
	@RequestMapping(value = "form")
	public String form(HttpServletRequest request, Model model) {
		String ebPrizeId = (String) request.getParameter("ebPrizeId");
		if(StringUtils.isNotBlank(ebPrizeId)){
			EbPrize ebPrize = ebPrizeService.get(ebPrizeId);
			model.addAttribute("ebPrize", ebPrize);
		}
		return "modules/operate/lotteryForm";
	}
	
	/**
	 * 保存
	 */
	@RequiresPermissions("lottery:info:edit")
	@RequestMapping(value = "save")
	public String save(EbPrize ebPrize, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		SysUser user = SysUserUtils.getUser();
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + Global.getAdminPath() + "/lottery/list";
		}else{
			ebPrizeService.update(ebPrize);
			return "redirect:" + Global.getAdminPath() + "/lottery/list";
		}
	}
		
}
