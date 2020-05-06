package com.jq.support.main.controller.merchandise.order;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.order.EbOrderLog;
import com.jq.support.service.merchandise.order.EbOrderLogService;


@Controller
@RequestMapping(value = "${adminPath}/OrderLog")
public class EbOrderLogController extends BaseController {

	@Autowired
	private EbOrderLogService ebOrderLogService;
	
	
	@ModelAttribute
	public EbOrderLog get(@RequestParam(required=false) String ebOrderLogId) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(ebOrderLogId)){
			return ebOrderLogService.getEbOrderLogById(Integer.parseInt(ebOrderLogId));
		}else{
			return new EbOrderLog();
		}
	}
	
	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = {"saleorderhis", ""})
	public String getProductList(EbOrderLog ebOrderLog, HttpServletRequest request, HttpServletResponse response, Model model){
	    List<EbOrderLog> ebOrderLoglist=ebOrderLogService.getEbOrderLogByOrderId(ebOrderLog.getOrderId());
	    model.addAttribute("ebOrderLoglist", ebOrderLoglist);
	    model.addAttribute("ebOrderLog", ebOrderLog);
	    return "modules/shopping/order/saleorder_his";
	}
	
}
