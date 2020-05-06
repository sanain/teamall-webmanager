package com.jq.support.main.controller.merchandise.mecontent;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.user.PmSysDailyStatis;
import com.jq.support.model.user.PmSysStatistics;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.user.PmSysStatisticsService;


@Controller
@RequestMapping(value = "${adminPath}/PmSysStatistics")
public class PmSysStatisticsController extends BaseController {
	@Autowired
	private PmSysStatisticsService pmSysStatisticsService;
	@Autowired 
	private EbOrderService ebOrderService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
	
	@ModelAttribute
	public PmSysStatistics get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmSysStatisticsService.getPmSysStatistics(id);
		}else{
			return new  PmSysStatistics();
		}
	}
	
	@RequiresPermissions("merchandise:PmSysStatistics:view")
	@RequestMapping(value = {"list", ""})
	public String getProductList(
			PmSysStatistics pmSysStatistics , String statrDate,String stopDate,
			HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<PmSysStatistics> page=pmSysStatisticsService.getPageList(pmSysStatistics, new Page<PmSysStatistics>(request, response), statrDate, stopDate);
		    model.addAttribute("page", page);
		    model.addAttribute("statrDate",statrDate);
		    model.addAttribute("stopDate", stopDate);
		    model.addAttribute("pmSysDailyStatis", pmSysStatistics);
		    return "modules/shopping/Article/PmSysStatisticsList";
	}

	@RequiresPermissions("merchandise:PmSysStatistics:view")
	@RequestMapping(value = "orderList")
	public String orderList( String statrDate, EbOrder ebOrder,
			HttpServletRequest request, HttpServletResponse response, Model model) throws ParseException{
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd ");  
		    Date date = sdf.parse(statrDate);
		    Calendar startDT = Calendar.getInstance();
		    startDT.setTime(date);
		    startDT.add(Calendar.DATE, 1);
		    Date date2 = startDT.getTime();
		    String stopDate=sdf.format(date2);
		    String s=sdf.format(date);
		    if(ebOrder.getType()!=null){
		    	 if(ebOrder.getOnoffLineStatus()==4){
				    ebOrder.setType(2);
				    ebOrder.setOnoffLineStatus(null);
			    }else if(ebOrder.getOnoffLineStatus()==5){
			    	ebOrder.setType(3);
			    	ebOrder.setOnoffLineStatus(null);
			    }
		    }
		    Page<EbOrder> page=ebOrderService.getPageList(new Page<EbOrder>(request, response), ebOrder,s);
		    model.addAttribute("page", page);
		    model.addAttribute("statrDate",statrDate);
		    model.addAttribute("stopDate",stopDate);
		    model.addAttribute("ebOrder",ebOrder);
		    return "modules/shopping/Article/PmSysStatisticsOrderList";
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
