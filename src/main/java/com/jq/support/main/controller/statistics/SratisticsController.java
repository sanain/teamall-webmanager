package com.jq.support.main.controller.statistics;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jq.support.common.config.Global;
import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.user.EbBannerClick;
import com.jq.support.model.user.EbConversion;
import com.jq.support.service.merchandise.order.EbAftersaleService;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.user.EbBannerClickService;
import com.jq.support.service.merchandise.user.EbConversionService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.utils.DateTest;
/**
 * 统计
 *
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/Sratistics")
public class SratisticsController extends BaseController {
	@Autowired
	private EbOrderService ebOrderService;
	@Autowired
	private EbAftersaleService ebAftersaleService;
	@Autowired
	private EbConversionService ebConversionService;
	@Autowired
	private EbBannerClickService ebBannerClickService;
	@Autowired
	private EbUserService ebUserService;


	@RequiresPermissions("merchandise:Sratistics:view")
	@RequestMapping(value = "sratisticsfrom")
	public String form(EbOrder ebOrder,HttpServletRequest request,
					   HttpServletResponse response, Model model) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
		Date now=new Date();
		Date thisWeekMonday=DateTest.getThisWeekMonday(now);//本周一,开始时间
		//本周订单总数
		String orderCount=ebOrderService.sratisticsOrderAmount(now, null,null, thisWeekMonday);
		//本周订单支付总数
		String payOrderCount=ebOrderService.sratisticsOrderAmount(null, now,null, thisWeekMonday);
		//本周取消订单总数
		String closeOrderCount=ebOrderService.sratisticsOrderAmount(null,null, now, thisWeekMonday);
		//本周退款订单量
		String afterSaleCount=ebAftersaleService.sratisticsOrderAmount(now, thisWeekMonday);
		//指定时间内的订单增长数量
		model.addAttribute("thisWeekMonday", sdf.format(thisWeekMonday));
		model.addAttribute("orderCount", orderCount);
		model.addAttribute("payOrderCount", payOrderCount);
		model.addAttribute("closeOrderCount", closeOrderCount);
		model.addAttribute("afterSaleCount", afterSaleCount);
		model.addAttribute("ebOrder", ebOrder);
		return "modules/shopping/sratistics/sratisticsfrom";
	}
	@RequiresPermissions("merchandise:Sratistics:view")
	@RequestMapping(value = "sratisticsfrom0")
	public String form0(EbOrder ebOrder,HttpServletRequest request,
						HttpServletResponse response, Model model) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
		Date now=new Date();
		Date thisWeekMonday=DateTest.getThisWeekMonday(now);//本周一,开始时间
		//本周订单总数
		String orderCount=ebOrderService.sratisticsOrderAmount(now, null,null, thisWeekMonday);
		//本周订单支付总数
		String payOrderCount=ebOrderService.sratisticsOrderAmount(null, now,null, thisWeekMonday);
		//本周取消订单总数
		String closeOrderCount=ebOrderService.sratisticsOrderAmount(null,null, now, thisWeekMonday);
		//本周退款订单量
		String afterSaleCount=ebAftersaleService.sratisticsOrderAmount(now, thisWeekMonday);
		//指定时间内的订单增长数量
		model.addAttribute("thisWeekMonday", sdf.format(thisWeekMonday));
		model.addAttribute("orderCount", orderCount);
		model.addAttribute("payOrderCount", payOrderCount);
		model.addAttribute("closeOrderCount", closeOrderCount);
		model.addAttribute("afterSaleCount", afterSaleCount);
		model.addAttribute("ebOrder", ebOrder);
		return "modules/shopping/sratistics/sratisticsfrom0";
	}
	/**
	 * 各节点转化率分析
	 * @return
	 */
	@RequestMapping(value = "sratisticsdayorderzh", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsdayorderzh(){
		Date now=new Date();
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		List<Date> listDates=DateTest.getBetweenDates(DateTest.geLastWeekMonday(now), now);//获取七天前到今天的数据
		List<Map<String, Object>> liHashMaps=new ArrayList<Map<String,Object>>();
		List<String> list=new ArrayList<String>();
		for(Date dt:listDates){
			Map map=new HashMap<String, Object>();
			String nowSim=simpleDateFormat.format(dt);
			list.add(nowSim);
			/** 类型：1首页，2商品列表页，3详情页，4支付页，5支付成功 6确认订单7启动页*/
			EbConversion ebConversion_1=ebConversionService.getEbConversionById(new EbConversion(null, 1,null,null, null,null, null), nowSim);
			EbConversion ebConversion_2=ebConversionService.getEbConversionById(new EbConversion(null, 2,null,null, null,null, null), nowSim);
			EbConversion ebConversion_3=ebConversionService.getEbConversionById(new EbConversion(null, 3,null,null, null,null, null), nowSim);
			EbConversion ebConversion_4=ebConversionService.getEbConversionById(new EbConversion(null, 4,null,null, null,null, null), nowSim);
			EbConversion ebConversion_5=ebConversionService.getEbConversionById(new EbConversion(null, 5,null,null, null,null, null), nowSim);
			EbConversion ebConversion_6=ebConversionService.getEbConversionById(new EbConversion(null, 6,null,null, null,null, null), nowSim);


			if(ebConversion_1==null){
				ebConversion_1=new EbConversion(null, 1,0,dt, "首页",null, null);
				ebConversion_1.setCreateDate(dt);
			}
			if(ebConversion_2==null){
				ebConversion_2=new EbConversion(null, 2,0,dt, "商品列表页",null, null);
			}
			if(ebConversion_3==null){
				ebConversion_3=new EbConversion(null, 3,0,dt, "详情页",null, null);
			}
			if(ebConversion_4==null){
				ebConversion_4=new EbConversion(null, 4,0,dt, "支付页",null, null);
			}
			if(ebConversion_5==null){
				ebConversion_5=new EbConversion(null, 5,0,dt, "支付成功",null, null);
			}
			if(ebConversion_6==null){
				ebConversion_6=new EbConversion(null, 6,0,dt, "确认订单",null, null);
			}
			map.put("ebConversion_1", toMap(ebConversion_1));
			map.put("ebConversion_2", toMap(ebConversion_2));
			map.put("ebConversion_3", toMap(ebConversion_3));
			map.put("ebConversion_4", toMap(ebConversion_4));
			map.put("ebConversion_5", toMap(ebConversion_5));
			map.put("ebConversion_6", toMap(ebConversion_6));
			liHashMaps.add(map);
		}
		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("liHashMaps",liHashMaps);
		map.put("list",list);

		return map;
	}

	/**
	 * 首页各广告点击量
	 * @return
	 */
	@RequestMapping(value = "sratisticsdayorderclick", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsdayorderclick(){
		Date now=new Date();
		List<EbBannerClick> listeb=ebBannerClickService.getEbBannerClickByIdList(null, now, DateTest.geLastWeekMonday(now));

		List<Map<String, Object>> liHashMaps=new ArrayList<Map<String,Object>>();
		List<String> list=new ArrayList<String>();
		for(EbBannerClick dt:listeb){
			liHashMaps.add(toMap(dt));//首页各广告点击量转换
		}
		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("liHashMaps",liHashMaps);
		map.put("list",list);

		return map;
	}


	/**
	 * 将一个 JavaBean 对象转化为一个 Map
	 * @param bean 要转化的JavaBean 对象
	 * @return 转化出来的 Map 对象
	 * @throws IntrospectionException 如果分析类属性失败
	 * @throws IllegalAccessException 如果实例化 JavaBean 失败
	 * @throws InvocationTargetException 如果调用属性的 setter 方法失败
	 */
	@SuppressWarnings("rawtypes")
	public static Map toMap(Object bean) {
		Class<? extends Object> clazz = bean.getClass();
		Map<Object, Object> returnMap = new HashMap<Object, Object>();
		BeanInfo beanInfo = null;
		try {
			beanInfo = Introspector.getBeanInfo(clazz);
			PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
			for (int i = 0; i < propertyDescriptors.length; i++) {
				PropertyDescriptor descriptor = propertyDescriptors[i];
				String propertyName = descriptor.getName();
				if (!propertyName.equals("class")) {
					Method readMethod = descriptor.getReadMethod();
					Object result = null;
					result = readMethod.invoke(bean, new Object[0]);
					if (null != propertyName) {
						propertyName = propertyName.toString();
					}
					if (null != result) {
						result = result.toString();
					}
					returnMap.put(propertyName, result);
				}
			}
		} catch (IntrospectionException e) {
			System.out.println("分析类属性失败");
		} catch (IllegalAccessException e) {
			System.out.println("实例化 JavaBean 失败");
		} catch (IllegalArgumentException e) {
			System.out.println("映射错误");
		} catch (InvocationTargetException e) {
			System.out.println("调用属性的 setter 方法失败");
		}
		return returnMap;
	}


	/**
	 * 每日订单及环比情况
	 * @return
	 */
	@RequestMapping(value = "sratisticsdayorder", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsdayorder(){
		SimpleDateFormat yymmdd = new SimpleDateFormat("yyyy-MM-dd");
		Date now=new Date();
		Date thisWeekMonday=DateTest.getThisWeekMonday(now);//本周一,开始时间
		Date thisWeekDateMondayPrevious=now;
		try {
			thisWeekDateMondayPrevious = DateTest.getDate(thisWeekMonday, -1);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<HashMap<String, String>> liHashMaps=new ArrayList<HashMap<String,String>>();
		List<Date> listDates=DateTest.getBetweenDates(thisWeekDateMondayPrevious, now);
		String orderCountPrevious=ebOrderService.sratisticsOrderAmount(thisWeekDateMondayPrevious, null,null, thisWeekDateMondayPrevious);

		for(int i=0;i<listDates.size();i++){//循环查找
			Date date=listDates.get(i);
			HashMap<String, String> hashMap=new HashMap<String, String>();
			//当天订单总数
			String orderCount=ebOrderService.sratisticsOrderAmount(date, null,null, date);
			hashMap.put("daytime", yymmdd.format(date));//时间，哪一天
			hashMap.put("orderCount", orderCount);
//			环比增长率=（本期数-上期数）/上期数×100%
			int preOrderCount=0;
			if(i!=0){
				preOrderCount=Integer.parseInt(liHashMaps.get(i-1).get("orderCount"));
			}else{
				preOrderCount=Integer.parseInt(orderCountPrevious);
			}
			if(preOrderCount==0){
				hashMap.put("orderHb",String.valueOf( ((Integer.parseInt(orderCount))*100)+"%"));
			}else{
				hashMap.put("orderHb", String.valueOf(((Integer.parseInt(orderCount)-preOrderCount)/preOrderCount*100)));
			}
			liHashMaps.add(hashMap);
		}
		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("orderList", liHashMaps);
		return map;
	}

	/**
	 * 不同注册用户订单转换量
	 * @return
	 */
	@RequestMapping(value = "sratisticsorderbyuserregiter", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsorderbyuserregiter(HttpServletRequest request,
											HttpServletResponse response){
		String startTime=request.getParameter("startTime");//开始时间
		String endTime=request.getParameter("endTime");//结束时间
		List<Object> sratisticsOrderByUserRegiterList=ebOrderService.getSratisticsOrderByUserRegiterList(startTime,endTime);

		Map map=new HashMap<String, Object>();
		map.put("code","00");
		//结构:注册类型、注册名字、注册总量
		map.put("sratisticsOrderByUserRegiterList", sratisticsOrderByUserRegiterList);
		return map;
	}
	/**
	 * 不同来源注册用户量
	 * @return
	 */
	@RequestMapping(value = "sratisticsbyuserregiter", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsbyuserregiter(HttpServletRequest request,
									   HttpServletResponse response){
		String startTime=request.getParameter("startTime");//开始时间
		String endTime=request.getParameter("endTime");//结束时间
		List<Object> sratisticsByUserRegiterList=ebOrderService.getSratisticsByUserRegiterList(startTime,endTime);

		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("getSratisticsByUserRegiterList", sratisticsByUserRegiterList);
		return map;
	}
	/**
	 * 本周新增订单分布（地图）
	 * @return
	 */
	@RequestMapping(value = "sratisticsbyordermap", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsbyordermap(){
		Date now=new Date();
		List<Object> sratisticsOrderByUserAreaList=ebOrderService.getSratisticsOrderByUserAreaList(DateTest.geLastWeekMonday(now),now);

		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("sratisticsOrderByUserAreaList", sratisticsOrderByUserAreaList);
		return map;
	}
	/**
	 * 各终端订单量（柱状） 微信公众号、IOS、Android
	 * @return
	 */
	@RequestMapping(value = "sratisticsbyorderdevice", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsbyorderdevice(){
		List<Object> sratisticsOrderByUserAreaList=ebOrderService.getSratisticsOrderByDeviceList();

		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("sratisticsOrderByUserAreaList", sratisticsOrderByUserAreaList);
		return map;
	}
	/**
	 * 非批发商品订单价格图标（表格） 日期、订单数、订单均价、订单均让利额
	 * @return
	 */
	@RequestMapping(value = "sratisticsbyordernotwholesale", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsbyordernotwholesale(){
		Date now=new Date();
		List<Object> SratisticsOrderNotWholesaleList=ebOrderService.getSratisticsOrderNotWholesaleList(DateTest.geLastWeekMonday(now),now);

		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("SratisticsOrderNotWholesaleList", SratisticsOrderNotWholesaleList);
		return map;
	}
	/**
	 * 非批发商品订单价格图标（表格） 日期、订单数、订单均价、订单均让利额
	 * @return
	 */
	@RequestMapping(value = "sratisticsbyorderwholesale", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsbyorderwholesale(){
		Date now=new Date();
		List<Object> SratisticsOrderWholesaleList=ebOrderService.getSratisticsOrderWholesaleList(DateTest.geLastWeekMonday(now),now);

		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("SratisticsOrderWholesaleList", SratisticsOrderWholesaleList);
		return map;
	}
	/**
	 * 过去一周全站日均启动次数（数字 环比 趋势 用户每次打开app即被计算一次）
	 * @return
	 */
	@RequestMapping(value = "sratisticsbyopenapp", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsbyopenapp(){
		Date now=new Date();
		/** 类型：1首页，2商品列表页，3详情页，4支付页，5支付成功 6确认订单7启动页*/
		List<Object> ebConversionlist=ebConversionService.getEbConversionByconversionType(7,DateTest.geLastWeekMonday(now),now);
		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("ebConversionlist", ebConversionlist);
		return map;
	}
	/**
	 * 过去一周每日注册用户数
	 * @return
	 */
	@RequestMapping(value = "sratisticsbyregiteruser", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsbyregiteruser(){
		Date now=new Date();
		List<Object> sratisticsbyregiteruserList=ebUserService.getSratisticsByRegiterUser(DateTest.geLastWeekMonday(now),now);
		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("sratisticsbyregiteruserList", sratisticsbyregiteruserList);
		return map;
	}
	/**
	 * 过去一周每日注册用户数
	 * @return
	 */
	@RequestMapping(value = "sratisticsbyregiteruseravg", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsbyregiteruseravg(){
		Date now=new Date();
		List<Object> sratisticsbyregiteruserAvgList=ebUserService.getSratisticsByRegiterUserAvg(DateTest.geLastWeekMonday(now),now);
		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("sratisticsbyregiteruserAvgList", sratisticsbyregiteruserAvgList);
		return map;
	}
	/**
	 * Sku数（商品总数量  多规格每个规格算一个）
	 * @return
	 */
	@RequestMapping(value = "sratisticsorderitembyproperty", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsorderitembyproperty(){
		List<Object> sratisticsOrderItemByPropertyList=ebOrderService.getSratisticsOrderItemByPropertyList();

		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("sratisticsOrderItemByPropertyList", sratisticsOrderItemByPropertyList);
		return map;
	}

	/**
	 * Spu数（商品总数量 多规格只算一个）
	 * @return
	 */
	@RequestMapping(value = "sratisticsorderitembyproduct", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsorderitembyproduct(Integer type){
		List<Object> sratisticsOrderItemByProductList=ebOrderService.getSratisticsOrderItemByProductList(type);
		//统计计量类型为重量，单位为公斤时，转化库存
		if(type != null && type == 2){
			for(Object o : sratisticsOrderItemByProductList){
				Object[] arr = (Object[])o;
				String str = arr[2] == null ? "0":arr[2].toString();
				arr[2] = Double.valueOf(str)/1000;
			}
		}
		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("sratisticsOrderItemByProductList", sratisticsOrderItemByProductList);
		return map;
	}

	/**
	 *过去一周全站商品销售总量 （数字）
	 * @return
	 */
	@RequestMapping(value = "sratisticsorderitembyproductsum", method = RequestMethod.POST)
	@ResponseBody
	public Map sratisticsorderitembyproductsum(){
		Date now=new Date();
		//件
		List<Object> list1=ebUserService.getSratisticsOrderitemByProductSum(DateTest.geLastWeekMonday(now),now,1);
		//公斤
		List<Object> list2=ebUserService.getSratisticsOrderitemByProductSum(DateTest.geLastWeekMonday(now),now,2);
		//克
		List<Object> list3=ebUserService.getSratisticsOrderitemByProductSum(DateTest.geLastWeekMonday(now),now,3);

		StringBuffer productCountStr = new StringBuffer();
		if(CollectionUtils.isNotEmpty(list1)){
			Object o = ((Object[]) list1.get(0))[2];
			String str = o == null ? "":o.toString();
			productCountStr.append(str+"件/");
		}

		if("1".equals(Global.getConfig("isShowWeight"))){
			if(CollectionUtils.isNotEmpty(list2)){
				Object o = ((Object[]) list2.get(0))[2];
				String str = o == null ? "0":o.toString();
				int number = Integer.valueOf(str);
				productCountStr.append(number/1000+"公斤/");
			}
			if(CollectionUtils.isNotEmpty(list3)){
				Object o = ((Object[]) list3.get(0))[2];
				String str = o == null ? "0":o.toString();
				productCountStr.append(str+"克/");
			}
		}
		if(productCountStr.length() > 0){
			productCountStr.setLength(productCountStr.length()-1);
		}

		if(CollectionUtils.isNotEmpty(list1)){
			Object[] arr = ((Object[]) list1.get(0));
			arr[2] = productCountStr;
		}

		Map map=new HashMap<String, Object>();
		map.put("code","00");
		map.put("sratisticsOrderitemByProductSum", list1);
		return map;
	}

	/**
	 * 库存转化
	 * @param list
	 * @return
	 */
//	private List<Object> replaceSalesCount(List<Object>  list){
//		List<Object> newList = new ArrayList<Object>();
//
//		if(CollectionUtils.isNotEmpty(list)){
//			for(Object o : list){
//				Object[] arr = (Object[])o;
//				Object[] newArr = new Object[4];
//				newArr[0] = arr[0];
//				newArr[1] = arr[1];
//
//				Integer salesCount = arr[2] == null ? 0 : Integer.valueOf(arr[2].toString());
//				Integer measuringType = arr[3] == null ? null : Integer.valueOf(arr[3].toString());
//				Integer measuringUnit = arr[4] == null ? null : Integer.valueOf(arr[4].toString());
//
//				if(measuringType != null && measuringType == 2){
//					if(measuringUnit == null || measuringType == 1){
//
//					}
//				}
//			}
//		}
//	}
}
