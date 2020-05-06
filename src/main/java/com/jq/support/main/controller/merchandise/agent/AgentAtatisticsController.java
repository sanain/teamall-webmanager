package com.jq.support.main.controller.merchandise.agent;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.order.PmAgentAmtLogService;
import com.jq.support.service.merchandise.order.PmOrderLoveLogService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmAgentBankService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 代理营业 收益 统计
 */
@Controller
@RequestMapping(value = "${adminPath}/agent")
public class AgentAtatisticsController extends BaseController {

	@Autowired
	PmAgentAmtLogService pmAgentAmtLogService;
	@Autowired
	PmAgentBankService pmAgentBankService;
	@Autowired
	EbUserService ebUserService;
	@Autowired
	SysOfficeService sysOfficeService;
	@Autowired
	PmOrderLoveLogService pmOrderLoveLogService;
	@Autowired
	EbOrderService ebOrderService;
	@Autowired
	PmShopInfoService pmShopInfoService;
	
	//营业 统计
	@RequestMapping("business")
	public String businessAtatistics(EbUser ebUser,HttpServletRequest request, HttpServletResponse response, Model model){
		SysUser user=SysUserUtils.getUser();
		SysOffice sysOffice=user.getCompany();
		String agentIds= sysOfficeService.getAgentIdList(sysOffice);
		Page<EbUser> page =ebUserService.getPageAgentIdList(new Page<EbUser>(request,response),ebUser,agentIds);
		List<EbUser> users=page.getList();
		for (EbUser eu : users) {
			//统计总营业额
			double totalRevenue=ebOrderService.totalRevenue("'"+eu.getShopId()+"'");
			//统计总交易量
			Integer totalVolume=ebOrderService.totalVolume("'"+eu.getShopId()+"'",null,null);
			//设置门店
//			PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(eu.getShopId()+"");
			eu.setTotalRevenue(totalRevenue);
			eu.setTotalVolume(totalVolume);
//			eu.setPmShopInfo(pmShopInfo);
		}
		model.addAttribute("page", page);
		return "modules/shopping/user/businessAtatisticsList";
	}
	
	//门店的订单详情
	@RequestMapping("orderDetail")
	public String orderDetail(EbOrder ebOrder,String shopId,HttpServletRequest request, HttpServletResponse response, Model model){
		Page<EbOrder> page =ebOrderService.getPageEbOrderList(new Page<EbOrder>(),ebOrder,shopId);
		List<EbOrder> ebOrders=page.getList();
		for (EbOrder eo : ebOrders) {
			EbUser ebUser=ebUserService.getShop(eo.getShopId()+"");
			eo.setEbUser(ebUser);
		}
		model.addAttribute("page", page);
		return "modules/shopping/user/agentOrderDetailList";
	}
	
	
	//收益 统计
	@RequestMapping("income")
	public String income(EbUser ebUser,HttpServletRequest request, HttpServletResponse response, Model model){
		SysUser user=SysUserUtils.getUser();
		SysOffice sysOffice=user.getCompany();
		String agentIds= sysOfficeService.getAgentIdList(sysOffice);
		Page<EbUser> page =ebUserService.getPageAgentIdList(new Page<EbUser>(request,response),ebUser,agentIds);
		List<EbUser> users=page.getList();
		for (EbUser eu : users) {
			//统计总营业额
			double totalRevenue=ebOrderService.totalRevenue("'"+eu.getShopId()+"'");
			//统计总御可贡茶数量
			double totalLoveCount=pmOrderLoveLogService.totalLoveCount("'"+eu.getShopId()+"'");
			//设置门店
//			PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(eu.getShopId()+"");
			eu.setTotalLove(totalLoveCount);
			eu.setTotalRevenue(totalRevenue);
//			eu.setPmShopInfo(pmShopInfo);
		}
		model.addAttribute("page", page);
		return "modules/shopping/user/agentIncomeList";
	}
	
	
	//门店的收益详情
	@RequestMapping("incomeDetail")
	public String incomeDetail(EbOrder ebOrder,String shopId,HttpServletRequest request, HttpServletResponse response, Model model) throws ParseException{
		Page<Object> page =ebOrderService.getPageObjectList(new Page<Object>(),shopId);
		List<Object> times=page.getList();
		List<Object> ebUsers=new ArrayList<Object>();
		EbUser ebUser=null;
		for (Object  s : times) {
			if (s==null) {
				continue;
			}
			ebUser=new EbUser();
			String stime=s+" 00:00:00";
			Date ttime =DateUtil.addDate(DateUtil.convertStringToDate("yyyy-MM-dd HH:mm:ss", stime), 5, 1);
			String  etime =DateUtil.getDateTime("yyyy-MM-dd HH:mm:ss", ttime);
			double oneDayRevenue=ebOrderService.oneDayRevenue("'"+shopId+"'", stime, etime);//统计一天的总营业额
			double oneDayLoveCount=pmOrderLoveLogService.oneDayLoveCount("'"+shopId+"'", stime, etime);//统计一天的总御可贡茶数量
			ebUser.setTotalRevenue(oneDayRevenue);
			ebUser.setTotalLoveCount(oneDayLoveCount);
			ebUser.setInformation(s+"");
			ebUsers.add(ebUser);
		}
		page.setList(ebUsers);
		model.addAttribute("page", page);
		return "modules/shopping/user/agentIncomeDetailList";
	}
	
}