package com.jq.support.main.controller.shop;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.security.Md5Encrypt;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.dao.merchandise.user.EbUserDao;
import com.jq.support.model.order.PmOrderLoveLog;
import com.jq.support.model.shop.PmShopFreightTem;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmAmtLog;
import com.jq.support.service.merchandise.order.PmOrderLoveLogService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmAmtLogService;
import com.jq.support.service.utils.DictUtils;


@Controller
@RequestMapping(value = "${adShopPath}/shopAccount")
public class ShopAccountController extends BaseController{
	
	@Autowired
	private PmAmtLogService pmAmtLogService;
	@Autowired
	private PmOrderLoveLogService pmOrderLoveLogService;
	
	
	

	//跳转到账户页
	@RequestMapping(value = "myAccount")
	public String goTomyAccount(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		EbUser ebUser= (EbUser) request.getSession().getAttribute("shopuser");
		ebUser=pmAmtLogService.myLoveDetail(ebUser.getUserId()+"");
		//今日御可贡茶指数
		String loveIndex=DictUtils.getDictValue("LoveIndex", "gyconfig", "");
		model.addAttribute("ebUser", ebUser);
		model.addAttribute("loveIndex", loveIndex);
		return "modules/shop/my-account";
	}
	
	//查看我的账单
	@RequestMapping(value = "mybill")
	 public String mybillList (PmAmtLog pmAmtLog,HttpServletRequest request,HttpServletResponse response,Model model) throws ParseException{
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		pmAmtLog.setUserId(ebUser.getUserId());
		Page<PmAmtLog> page=pmAmtLogService.findmybillList(new Page<PmAmtLog>(request,response),pmAmtLog);
		model.addAttribute("page", page);
		model.addAttribute("pmAmtLog", pmAmtLog);
		return "modules/shop/my-bill";
	}
	
	//查看御可贡茶明细
	@RequestMapping(value = "mylove")
	public String myloveList (PmOrderLoveLog pmOrderLoveLog,HttpServletRequest request,HttpServletResponse response,Model model) throws ParseException{
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		pmOrderLoveLog.setObjId(ebUser.getUserId()+"");
		Page<PmOrderLoveLog> page=pmOrderLoveLogService.findmyloveList(new Page<PmOrderLoveLog>(request,response),pmOrderLoveLog,"","");
		model.addAttribute("page", page);
		model.addAttribute("pmOrderLoveLog", pmOrderLoveLog);
		return "modules/shop/my-love";
	}

	
}
