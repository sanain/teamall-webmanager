package com.jq.support.main.controller.payback;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.pay.PmOpenPayWay;
import com.jq.support.model.pay.PmSysPayAmountStatistics;
import com.jq.support.service.pay.PmOpenPayWayService;
import com.jq.support.service.pay.PmSysPayAmountStatisticsService;
import com.jq.support.service.utils.DateUtil;

/**
 * 系统每日支付金额统计Controller
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/pmSysPayAmountStatistics")
public class PmSysPayAmountStatisticsController  extends BaseController{
	@Autowired
	private PmSysPayAmountStatisticsService pmSysPayAmountStatisticsService;
	@Autowired
	private PmOpenPayWayService pmOpenPayWayService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/upload/images/";
	private static String innerImgFullPath = "src=\"" + domainurl + "/upload/images/";
	
	
	@ModelAttribute
	public PmSysPayAmountStatistics get(String id) {
		if (StringUtils.isNotBlank(id)){
			return pmSysPayAmountStatisticsService.get(id);
		}else{
			return new PmSysPayAmountStatistics();
		}
	}
	
	
	/**
	 * 列表
	 * @return
	 */
	@RequiresPermissions("pmSysPayAmountStatistics:info:view")
	@RequestMapping({"list", ""})
	public String pmSysPayAmountStatisticsList(PmSysPayAmountStatistics pmSysPayAmountStatistics,String startTime,String endTime, HttpServletRequest request,HttpServletResponse response, Model model){
		Page<PmSysPayAmountStatistics> page = pmSysPayAmountStatisticsService.getPageList(new Page<PmSysPayAmountStatistics>(request, response), pmSysPayAmountStatistics,startTime,endTime);
		model.addAttribute("page", page);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		return "modules/shopping/order/pmSysPayAmountStatisticsList";
	}
	
	
	@RequiresPermissions("pmSysPayAmountStatistics:info:view")
	@RequestMapping(value = "form")
	public String form(PmSysPayAmountStatistics pmSysPayAmountStatistics, HttpServletRequest request, Model model) {
		return formSearch(pmSysPayAmountStatistics, model);
	}
	
	private String formSearch(PmSysPayAmountStatistics pmSysPayAmountStatistics, Model model) {
		return "modules/frozenlove/pmSysPayAmountStatisticsForm";
	}
	
	/**
	 * 保存
	 */
	@RequiresPermissions("pmSysPayAmountStatistics:info:edit")
	@RequestMapping(value = "save")
	public String save(PmSysPayAmountStatistics pmSysPayAmountStatistics, Model model,HttpServletRequest request, RedirectAttributes redirectAttributes) {
        if (pmSysPayAmountStatistics.getId()!=null) {
		}else {
			pmSysPayAmountStatistics.setCreateTime(new Date());
		}
		pmSysPayAmountStatisticsService.save(pmSysPayAmountStatistics);
		return "redirect:" + Global.getAdminPath() + "/pmSysPayAmountStatistics/form";
	}
	
	
	/**
	 * 删除
	 */
	@RequiresPermissions("pmSysPayAmountStatistics:info:edit")
	@RequestMapping(value = "deleteService")
	public String deleteProject(String ids[],String spackId,RedirectAttributes redirectAttributes, HttpServletRequest request) {
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + Global.getAdminPath() + "/pmSysPayAmountStatistics/list";
	}
	
	
	/**
	 * 实时的详情
	 */
	@RequiresPermissions("pmSysPayAmountStatistics:info:view")
	@RequestMapping(value = "detail")
	public String detail(PmSysPayAmountStatistics pmSysPayAmountStatistics,RedirectAttributes redirectAttributes, HttpServletRequest request, Model model) {
		 String startTime=DateUtil.getNow()+" 00:00:00";
		 String endTime=DateUtil.getNows();
		 Map<Integer , String> map=new HashMap<Integer, String>();
		 List<PmOpenPayWay> list=pmOpenPayWayService.getList(new PmOpenPayWay());
		 if (CollectionUtils.isNotEmpty(list)) {
			for (PmOpenPayWay pmOpenPayWay : list) {
				map.put(pmOpenPayWay.getPayWayCode(), pmOpenPayWay.getPayWayName());
			}
		 }
		 PmSysPayAmountStatistics ps=new PmSysPayAmountStatistics();
		 pmSysPayAmountStatisticsService.payAmountStatistics(map, startTime, endTime, ps);
		 model.addAttribute("pmSysPayAmountStatistics", ps); 
		 model.addAttribute("map", map); 
		 model.addAttribute("startTime", startTime); 
		 model.addAttribute("endTime", endTime); 
		 return "modules/shopping/order/pmSysPayAmountStatisticsDetail";
	}
	
	
}
