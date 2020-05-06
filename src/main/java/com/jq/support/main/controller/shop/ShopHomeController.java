package com.jq.support.main.controller.shop;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jq.support.model.message.EbMessageUser;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.utils.*;
import net.sf.json.JSONArray;

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
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.shop.PmShopFreightTem;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmAmtLog;
import com.jq.support.service.merchandise.order.EbAftersaleService;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.order.PmOrderLoveLogService;
import com.jq.support.service.merchandise.product.EbProductService;
import com.jq.support.service.merchandise.product.EbProductcommentService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmAmtLogService;


@Controller
@RequestMapping(value = "${adShopPath}")
public class ShopHomeController extends BaseController{
	
	@Autowired
	private PmAmtLogService pmAmtLogService;
	@Autowired
	private PmOrderLoveLogService pmOrderLoveLogService;
	@Autowired
	private EbOrderService ebOrderService;
	@Autowired
	private EbAftersaleService ebAftersaleService;
	@Autowired
	private EbProductService ebProductService;
	@Autowired
	private PmShopInfoService pmShopInfoService;
	@Autowired
	private EbProductcommentService ebProductcommentService;
	@Autowired
	private EbMessageUserService ebMessageUserService;
	
	

	//跳转到主页
	@RequestMapping(value = "home")
	public String goTomyAccount(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		EbUser ebUser= (EbUser) request.getSession().getAttribute("shopuser");
		ebUser=pmAmtLogService.myLoveDetail(ebUser.getUserId()+"");
		//今日御可贡茶指数
		String loveIndex=DictUtils.getDictValue("LoveIndex", "gyconfig", "");
		
		String sdate=DateUtil.getDateTime("yyyy-MM-dd HH:mm:ss", DateUtil.addDate(new Date(), 2, -3));
		String edate=DateUtil.getDateTime("yyyy-MM-dd HH:mm:ss", new Date());

		/*三个月内订单*/
		Integer orderCount=ebOrderService.totalVolume("'"+ebUser.getShopId()+"'", sdate, edate);
		/*三个月内退货*/
		Integer cancelOrderCount =ebAftersaleService.totalAftersale(ebUser.getShopId(), 0,null, sdate, edate);
		/*在售商品*/
		Integer saleCount =ebProductService.totalProductCount(ebUser.getShopId(), 1);
		/*仓库商品*/
		Integer storeCount=ebProductService.totalProductCount(ebUser.getShopId(), 0);
		
		/*订单*/
		/*全部订单*/
		Integer orderAllCount=ebOrderService.totalStateOrderCount(ebUser.getShopId(),null, null);
			/*待付款*/
		Integer waitPayCount=ebOrderService.totalStateOrderCount(ebUser.getShopId(), 1, null);
			/*待发货*/
		Integer waitSendCount=ebOrderService.totalStateOrderCount(ebUser.getShopId(), 2);	
			/*待收货*/
		Integer waitTakeCount=ebOrderService.totalStateOrderCount(ebUser.getShopId(), 3, null);	
			/*已完成*/
		Integer endCount=ebOrderService.totalStateOrderCount(ebUser.getShopId(), 4, null);	
			/*待评价*/
		Integer waitCommentCount=ebOrderService.totalStateOrderCount(ebUser.getShopId(), 4, 0);		
		
		/*退款*/
			/*待审核*/
		Integer waitVerifyCount =ebAftersaleService.totalAftersale(ebUser.getShopId(), null,1, null, null);	
			/*待退货*/
		Integer waitReturnGoodsCount =ebAftersaleService.totalAftersale(ebUser.getShopId(), null,5, null, null);	
			/*待收货*/
		Integer waitTakeGoodsCount =ebAftersaleService.totalAftersale(ebUser.getShopId(), null,6, null, null);	
			/*待退款*/
		Integer waitRefundCount =ebAftersaleService.totalAftersale(ebUser.getShopId(), null,8, null, null);	
		    /*平台介入*/
		Integer platformInterventionCount =ebAftersaleService.totalAftersale(ebUser.getShopId(), null,9, null, null);	
		
		/*商家信息*/
		PmShopInfo  shopInfo =pmShopInfoService.getpmPmShopInfo(ebUser.getShopId()+"");

		if(StringUtil.isBlank(shopInfo.getMiniCode())){
			String dir =request.getSession().getServletContext().getRealPath("/uploads");
			Map map=WeixinUtil.getWxacodeunlimit(shopInfo.getId(),ebUser.getCartNum(),dir,"miniCode"+shopInfo.getId()+".png");
			if("00".equals(map.get("code"))) {
				String miniCode = "/uploads/" + "miniCode" + shopInfo.getId() + ".png";  //设置图片所在路径
				shopInfo.setMiniCode(miniCode);
				pmShopInfoService.save(shopInfo);
			}
		}
		/*好评率*/
		Integer point=ebProductcommentService.getScoreDetail(4, ebUser.getShopId());
		/*商品描述*/
		Integer color=ebProductcommentService.getScoreDetail(3, ebUser.getShopId());
		/*商家服务*/
		Integer service=ebProductcommentService.getScoreDetail(1, ebUser.getShopId());
		/*物流服务*/
		Integer logistics=ebProductcommentService.getScoreDetail(2, ebUser.getShopId());
		/*查询门店最新广告*/
		EbMessageUser advertising = ebMessageUserService.getShopLatestAdvertising(ebUser.getUserId());
		model.addAttribute("advertising", advertising);
		model.addAttribute("orderCount", orderCount);
		model.addAttribute("cancelOrderCount", cancelOrderCount);
		model.addAttribute("saleCount", saleCount);
		model.addAttribute("storeCount", storeCount);
		model.addAttribute("waitPayCount", waitPayCount);
		model.addAttribute("waitSendCount", waitSendCount);
		model.addAttribute("waitTakeCount", waitTakeCount);
		model.addAttribute("endCount", endCount);
		model.addAttribute("waitCommentCount", waitCommentCount);
		model.addAttribute("waitVerifyCount", waitVerifyCount);
		model.addAttribute("waitReturnGoodsCount", waitReturnGoodsCount);
		model.addAttribute("waitTakeGoodsCount", waitTakeGoodsCount);
		model.addAttribute("waitRefundCount", waitRefundCount);
		model.addAttribute("platformInterventionCount", platformInterventionCount);
		model.addAttribute("point", point);
		model.addAttribute("color", color);
		model.addAttribute("service", service);
		model.addAttribute("logistics", logistics);
		model.addAttribute("shopInfo", shopInfo);
		model.addAttribute("ebUser", ebUser);
		model.addAttribute("loveIndex", loveIndex);
		model.addAttribute("orderAllCount", orderAllCount);
		return "modules/shop/home";
	}
	
	
	
	 //统计销售情况
  	 @RequestMapping(value = "saleDetail")
   	 @ResponseBody
	 public JSONArray saleDetail(String shopId) throws IOException, ParseException {
			JSONArray jsonArray=new JSONArray();
			List<String> daylist= DateUtil2.getBeforeDays(12,DateUtil2.Md);//天数
			List<String> days= DateUtil2.getBeforeDays(12,DateUtil2.gymd);//天数
			List<Double> priceList= new ArrayList<Double>();
			List<Integer> orderList= new ArrayList<Integer>();
			List<Object> mounthList= new ArrayList<Object>();
			Map<String , Object> map=new HashMap<String , Object>();
			for (int j = 0; j < days.size(); j++) {
				String  stime=days.get(j)+" 00:00:00";
				//String  etime=days.get(j)+" 23:59:59";
				Date ttime =DateUtil.addDate(DateUtil.convertStringToDate("yyyy-MM-dd HH:mm:ss", stime), 5, 1);
				String  etime =DateUtil.getDateTime("yyyy-MM-dd HH:mm:ss", ttime);
				//统计一天的总营业额
				double oneDayRevenue=ebOrderService.oneDayRevenue("'"+shopId+"'", stime, etime);
				//统计一天总交易量
				Integer oneDaytotalVolume=ebOrderService.totalVolume("'"+shopId+"'", stime, etime);
				priceList.add(oneDayRevenue);
				orderList.add(oneDaytotalVolume);
			}
			//本月数据
			Calendar today = Calendar.getInstance();
			String  startMounth=DateUtil2.getFormatCalendar(DateUtil2.getStartMounth(today),DateUtil2.ymdhms);//开始月
			today.add(Calendar.MONTH, 1);
			String  endMounth=DateUtil2.getFormatCalendar(DateUtil2.getStartMounth(today),DateUtil2.ymdhms);//结束月
			//统计本月的总营业额
			double mounthRevenue=ebOrderService.oneDayRevenue("'"+shopId+"'", startMounth, endMounth);
			//统计本月总交易量
			Integer mounthTotalVolume=ebOrderService.totalVolume("'"+shopId+"'", startMounth, endMounth);
			mounthList.add(mounthRevenue);
			mounthList.add(mounthTotalVolume);
			
			map.put("daylist", daylist);
			map.put("orderList", orderList);
			map.put("priceList", priceList);
			map.put("mounthList", mounthList);
			jsonArray.add(map);
			return jsonArray;		
			
		}

	
}
