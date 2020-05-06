package com.jq.support.main.controller.merchandise.shop;

import java.io.IOException;
import java.text.ParseException;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.order.PmOrderLoveLog;
import com.jq.support.model.order.PmSysAccount;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmAmtLog;
import com.jq.support.service.merchandise.order.PmOrderLoveLogService;
import com.jq.support.service.merchandise.order.PmSysAccountService;
import com.jq.support.service.merchandise.user.PmAmtLogService;


//后台管理  系统账号
@Controller
@RequestMapping(value = "${adminPath}/pmSysAccount")
public class PmSysAccountController extends BaseController{
	@Autowired
	private PmSysAccountService pmSysAccountService;
	@Autowired
	private PmAmtLogService pmAmtLogService;
	@Autowired
	private PmOrderLoveLogService pmOrderLoveLogService;
	
	@ModelAttribute
	public PmSysAccount get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return pmSysAccountService.getPmSysAccount(id);
		}else{
			return new PmSysAccount();
		}
	}
	
	@RequiresPermissions("shop:pmSysAccount:view")
	@RequestMapping(value = {"list", ""})
	public String list(PmSysAccount pmSysAccount, HttpServletRequest request, HttpServletResponse response, Model model){
		
	    Page<PmSysAccount> page=pmSysAccountService.findPmSysAccountList(new Page<PmSysAccount>(request, response),pmSysAccount);
	    model.addAttribute("page", page);
	    return "modules/shop/pmSysAccountList";
	}
	
	
	@RequiresPermissions("shop:pmSysAccount:view")
	@RequestMapping(value = "form")
	public String form(PmSysAccount pmSysAccount, HttpServletRequest request, HttpServletResponse response, Model model){
		    model.addAttribute("pmSysAccount", pmSysAccount);
		    return "modules/shop/PmSysAccountFrom";
	}
	
	
	@RequiresPermissions("shop:pmSysAccount:edit")
	@RequestMapping(value = "save")
	public String save(PmSysAccount pmSysAccount, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      pmSysAccountService.save(pmSysAccount);
		      addMessage(redirectAttributes, "保存成功");
	  	return "redirect:"+Global.getAdminPath()+"/PmSysAccount/list";
	}
	
	
	
	//查看御可贡茶明细
	@RequestMapping(value = "mylove")
	public String myloveList (PmOrderLoveLog pmOrderLoveLog,String statrDate,String stopDate,HttpServletRequest request,HttpServletResponse response,Model model) throws ParseException{
		pmOrderLoveLog.setObjType(4);
		Page<PmOrderLoveLog> page=pmOrderLoveLogService.findmyloveList(new Page<PmOrderLoveLog>(request,response),pmOrderLoveLog,statrDate,stopDate);
		model.addAttribute("page", page);
		model.addAttribute("pmOrderLoveLog", pmOrderLoveLog);
		return "modules/shop/orderLoveList";
	}
	
	
}
