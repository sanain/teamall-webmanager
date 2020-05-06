package com.jq.support.main.controller.merchandise.operate;

import java.text.ParseException;
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
import com.jq.support.model.promotion.EbActor;
import com.jq.support.model.promotion.EbPromotion;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.promotion.EbActorService;
import com.jq.support.service.merchandise.promotion.EbPromotionService;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 活动 Controller
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/actor")
public class EbActorController  extends BaseController{
	@Autowired
	private EbActorService ebActorService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl + "/uploads/images/";

	/**
	 * 活动结果列表
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping({"list", ""})
	public String promotionList(EbActor ebActor, HttpServletRequest request,HttpServletResponse response, Model model){
		String startDate = request.getParameter("startDate");
		String stopDate = request.getParameter("stopDate");
		Page<EbActor> page = ebActorService.findEbActorList(new Page<EbActor>(request, response), ebActor, startDate, stopDate);
		model.addAttribute("page", page);
		model.addAttribute("startDate", startDate);
		model.addAttribute("stopDate", stopDate);
		model.addAttribute("ebActor", ebActor);
		return "modules/operate/actorList";
	}
	
	/**
	 * 活动结果统计
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping({"countResult"})
	public String countResult(EbActor ebActor, HttpServletRequest request,HttpServletResponse response, Model model) throws ParseException{
		String date = request.getParameter("date");
		List<Object> list = ebActorService.countResult(date);
		model.addAttribute("list", list);
		model.addAttribute("ebActor", ebActor);
		return "modules/operate/countResult";
	}

}
