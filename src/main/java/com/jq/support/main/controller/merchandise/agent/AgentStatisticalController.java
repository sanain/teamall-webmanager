package com.jq.support.main.controller.merchandise.agent;

import com.jq.support.model.agent.PmAgent;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbConversion;
import com.jq.support.service.agent.PmAgentService;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.user.EbConversionService;
import com.jq.support.service.utils.DateTest;
import com.jq.support.service.utils.NumberFormateUtil;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.utils.SysUserUtils;
import org.bson.util.StringRangeSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 代理商相关的统计数据
 */
@RequestMapping(value = "${adminPath}/agentStatistical")
@Controller
public class AgentStatisticalController {
    @Autowired
    private EbOrderService ebOrderService;
    @Autowired
    private PmAgentService pmAgentService;
    @Autowired
    private EbConversionService ebConversionService;

    /**
     * 进入销售统计页面
     * @param model
     * @return
     */
    @RequestMapping(value = "statistical")
    public String statistical(Model model ,PmAgent pmAgent,boolean  isAgent){
        //获得系统用户的代理id
        SysUser user = SysUserUtils.getUser();


        if(pmAgent == null || pmAgent.getId() == null) {
            //当不是代理商登录时，显示一个默认的代理商数据
            if (user.getTeaAgentId() == null) {
                List<PmAgent> all = pmAgentService.getAll();
                if (all == null || all.size() == 0) {
                    return "modules/shopping/agent/agentStatistical";
                }
                pmAgent = all.get(0);

            } else {  //是代理商登录时，显示当前的代理商数据
                pmAgent = pmAgentService.getById(user.getTeaAgentId());
            }
        }else{
            pmAgent = pmAgentService.getById(pmAgent.getId());
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
        Date now=new Date();
        Date thisWeekMonday= DateTest.getThisWeekMonday(now);//本周一,开始时间

        //今天订单总数
        String todayOrderCount=ebOrderService.statisticalOrderAmount(now, null, new Date(),pmAgent.getShopIds());
        //今天订单支付总数
        String todayPayOrderCount=ebOrderService.statisticalOrderAmount(null, now,  new Date(),pmAgent.getShopIds());
        //今天订单支付金额
        String todayPayOrderMoneyCount=ebOrderService.statisticalOrderMoneyAmount(null, now,  new Date(),pmAgent.getShopIds());

        //今天平均客单价
        String todayOrderAverage = "0";
        if(todayPayOrderCount != null && !"0".equals(todayPayOrderCount)){
            todayOrderAverage =new Formatter().format("%.2f", Double.valueOf(todayPayOrderMoneyCount)/Integer.valueOf(todayPayOrderCount)).toString();
        }

        //本周订单总数
        String orderCount=ebOrderService.statisticalOrderAmount(now, null, thisWeekMonday,pmAgent.getShopIds());
        //本周订单支付总数
        String payOrderCount=ebOrderService.statisticalOrderAmount(null, now, thisWeekMonday,pmAgent.getShopIds());
        //本周订单支付金额
        String payOrderMoneyCount=ebOrderService.statisticalOrderMoneyAmount(null, now, thisWeekMonday,pmAgent.getShopIds());

        //本周平均客单价
        String orderAverage = "0";
        if(payOrderCount != null && !"0".equals(payOrderCount)){
            orderAverage =new Formatter().format("%.2f", Double.valueOf(payOrderMoneyCount)/Integer.valueOf(payOrderCount)).toString();
        }


        //指定时间内的订单增长数量
        model.addAttribute("thisWeekMonday", sdf.format(thisWeekMonday));

        model.addAttribute("todayOrderCount", todayOrderCount);
        model.addAttribute("todayPayOrderCount", todayPayOrderCount);
        model.addAttribute("todayPayOrderMoneyCount", todayPayOrderMoneyCount);
        model.addAttribute("todayOrderAverage", todayOrderAverage);

        model.addAttribute("orderCount", orderCount);
        model.addAttribute("payOrderCount", payOrderCount);
        model.addAttribute("payOrderMoneyCount", payOrderMoneyCount);
        model.addAttribute("orderAverage", orderAverage);
        model.addAttribute("pmAgent",pmAgent);
        model.addAttribute("isAgent",user.getTeaAgentId() == null ? false : true);
        return "modules/shopping/agent/agentStatistical";
    }


    /**
     * 每日订单及环比情况
     * @return
     */
    @RequestMapping(value = "statisticalDayOrder", method = RequestMethod.POST)
    @ResponseBody
    public Map statisticalDayOrder(Integer agentId){

        if(agentId == null){
            Map map=new HashMap<String, Object>();
            map.put("code","00");
            return map;
        }

        PmAgent pmAgent = pmAgentService.getById(agentId);
        //当代理商和没有门店时，直接退出
        if(pmAgent == null || StringUtil.isBlank(pmAgent.getShopIds())){
            Map map=new HashMap<String, Object>();
            map.put("code","00");
            return map;
        }

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
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
        String orderCountPrevious=ebOrderService.statisticalOrderAmount(null, thisWeekDateMondayPrevious, thisWeekDateMondayPrevious,pmAgent.getShopIds());

        for(int i=0;i<listDates.size();i++){//循环查找
            Date date=listDates.get(i);
            HashMap<String, String> hashMap=new HashMap<String, String>();
            //当天订单总数
            String orderCount=ebOrderService.statisticalOrderAmount(null, date, date,pmAgent.getShopIds());
            hashMap.put("daytime", format.format(date));//时间，哪一天
            hashMap.put("orderCount", orderCount);
//			环比增长率=（本期数-上期数）/上期数×100%
            int preOrderCount=0;
            if(i!=0){
                preOrderCount=Integer.parseInt(liHashMaps.get(i-1).get("orderCount"));
            }else{
                preOrderCount=Integer.parseInt(orderCountPrevious);
            }
            if(preOrderCount==0){
                hashMap.put("orderHb",String.valueOf( ((Integer.parseInt(orderCount))*100)));
            }else{
                hashMap.put("orderHb", new Formatter().format("%.2f",(double)(Integer.parseInt(orderCount)-preOrderCount)/preOrderCount*100).toString());
            }
            liHashMaps.add(hashMap);
        }
        Map map=new HashMap<String, Object>();
        map.put("code","00");
        map.put("orderList", liHashMaps);
        return map;
    }


    /**
     * 最近7天每日订单类型分布（订单类型：1、门店自取 2、线下门店 3、外卖订单）
     * @return
     */
    @RequestMapping(value = "statisticalBeforeSevenDayOrder", method = RequestMethod.POST)
    @ResponseBody
    public Map statisticalBeforeSevenDayOrder(Integer agentId){
        if(agentId == null){
            Map map=new HashMap<String, Object>();
            map.put("code","00");
            return map;
        }

        PmAgent pmAgent = pmAgentService.getById(agentId);
        //当代理商和没有门店时，直接退出
        if(pmAgent == null || StringUtil.isBlank(pmAgent.getShopIds())){
            Map map=new HashMap<String, Object>();
            map.put("code","00");
            return map;
        }

        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE,-1);
        Date endTime = cal.getTime();

        cal.add(Calendar.DATE,-6);
        Date startTime = cal.getTime();

        //获得过去七天的date列表
        List<Date> listDates=DateTest.getBetweenDates(startTime, endTime);

        //循环查询每天的支付订单总数
        List<Object[]> resultList = new ArrayList<Object[]>();
        for (Date date : listDates){
            Object[] objects = new Object[4];
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            objects[0] = format.format(date);
            //统计每种订单的个数
            for(int i = 1 ; i <= 3 ; i++){
                objects[i] = ebOrderService.statisticalOrderAmountByType(null, date, date, pmAgent.getShopIds(),i);
            }
            resultList.add(objects);
        }
        Map map=new HashMap<String, Object>();

        map.put("code","00");
        map.put("resultList", resultList);
        return map;
    }


    /**
     * 各节点转化率分析
     * @return
     */
    @RequestMapping(value = "statisticalDayOrderZh", method = RequestMethod.POST)
    @ResponseBody
    public Map statisticalDayOrderZh(){
        Date now=new Date();
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
        List<Date> listDates=DateTest.getBetweenDates(DateTest.geLastWeekMonday(now), now);//获取七天前到今天的数据
        List<Map<String, Object>> liHashMaps=new ArrayList<Map<String,Object>>();
        List<String> list=new ArrayList<String>();
        for(Date dt:listDates){
            Map map=new HashMap<String, Object>();
            String nowSim=simpleDateFormat.format(dt);
            list.add(nowSim);
            /** 类型：2商品列表页，4支付页，5支付成功 ，8优惠券列表*/
            EbConversion ebConversion_2=ebConversionService.getEbConversionById(new EbConversion(null, 2,null,null, null,null, null), nowSim);
            EbConversion ebConversion_4=ebConversionService.getEbConversionById(new EbConversion(null, 4,null,null, null,null, null), nowSim);
            EbConversion ebConversion_5=ebConversionService.getEbConversionById(new EbConversion(null, 5,null,null, null,null, null), nowSim);
            EbConversion ebConversion_8=ebConversionService.getEbConversionById(new EbConversion(null, 8,null,null, null,null, null), nowSim);

            if(ebConversion_2==null){
                ebConversion_2=new EbConversion(null, 2,0,dt, "点单-商品列表页",null, null);
            }
            if(ebConversion_4==null){
                ebConversion_4=new EbConversion(null, 4,0,dt, "结算页",null, null);
            }
            if(ebConversion_5==null){
                ebConversion_5=new EbConversion(null, 5,0,dt, "支付页-支付成功",null, null);
            }
            if(ebConversion_8==null){
                ebConversion_8=new EbConversion(null, 8,0,dt, "优惠券列表",null, null);
            }

            map.put("ebConversion_2", toMap(ebConversion_2));
            map.put("ebConversion_4", toMap(ebConversion_4));
            map.put("ebConversion_5", toMap(ebConversion_5));
            map.put("ebConversion_8", toMap(ebConversion_8));

            liHashMaps.add(map);
        }
        Map map=new HashMap<String, Object>();
        map.put("code","00");
        map.put("liHashMaps",liHashMaps);
        map.put("list",list);

        return map;
    }


    /**
     * Spu数（商品总数量  多规格算一个）
     * @return
     */
    @RequestMapping(value = "statisticalOrderItemByProduct", method = RequestMethod.POST)
    @ResponseBody
    public Map statisticalOrderItemByProduct(Integer agentId,Integer type){
        if(agentId == null){
            Map map=new HashMap<String, Object>();
            map.put("code","00");
            return map;
        }

        PmAgent pmAgent = pmAgentService.getById(agentId);
        //当代理商和没有门店时，直接退出
        if(pmAgent == null || StringUtil.isBlank(pmAgent.getShopIds())){
            Map map=new HashMap<String, Object>();
            map.put("code","00");
            return map;
        }

        List<Object> resultList=ebOrderService.getStatisticalOrderItemByProductList(pmAgent.getShopIds(),type);

        Map map=new HashMap<String, Object>();
        map.put("code","00");
        map.put("resultList", resultList);
        return map;
    }

    /**
     *
     * Sku数（商品总数量  多规格每个规格算一个）
     * @return
     */
    @RequestMapping(value = "statisticalOrderItemByProperty", method = RequestMethod.POST)
    @ResponseBody
    public Map statisticalOrderItemByProperty(Integer agentId){

        if(agentId == null){
            Map map=new HashMap<String, Object>();
            map.put("code","00");
            return map;
        }

        PmAgent pmAgent = pmAgentService.getById(agentId);
        //当代理商和没有门店时，直接退出
        if(pmAgent == null || StringUtil.isBlank(pmAgent.getShopIds())){
            Map map=new HashMap<String, Object>();
            map.put("code","00");
            return map;
        }

        List<Object> resultList=ebOrderService.getStatisticalOrderItemByPropertyList(pmAgent.getShopIds());

        Map map=new HashMap<String, Object>();
        map.put("code","00");
        map.put("resultList", resultList);
        return map;
    }


    /**
     *
     * 统计本周每日的订单金额
     * @return
     */
    @RequestMapping(value = "statisticalThisWeekOrderMoney", method = RequestMethod.POST)
    @ResponseBody
    public Map statisticalThisWeekOrderMoney(Integer agentId){
        if(agentId == null){
            Map map=new HashMap<String, Object>();
            map.put("code","00");
            return map;
        }


        PmAgent pmAgent = pmAgentService.getById(agentId);
        //当代理商和没有门店时，直接退出
        if(pmAgent == null || StringUtil.isBlank(pmAgent.getShopIds())){
            Map map=new HashMap<String, Object>();
            map.put("code","00");
            return map;
        }

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date now=new Date();
        Date thisWeekMonday=DateTest.getThisWeekMonday(now);//本周一,开始时间

        List<Object> resultList=new ArrayList();
        //获得本周所有的日期
        List<Date> listDates=DateTest.getBetweenDates(thisWeekMonday, now);

        for(int i=0;i<listDates.size();i++){//循环查找
            Date date=listDates.get(i);
            Object[] arr = new Object[4];

            //格式日期
            arr[0] = format.format(date);
            //今天订单支付总数
            arr[1]=ebOrderService.statisticalOrderAmount(null, date,  date,pmAgent.getShopIds());
            //今天订单支付金额
            arr[2]=ebOrderService.statisticalOrderMoneyAmount(null, date,  date,pmAgent.getShopIds());
            //计算订单均值
            arr[3] = Integer.valueOf(arr[1].toString()) == 0 ? 0.0: NumberFormateUtil.saveTwoDecimal(
                    Double.valueOf(arr[2].toString())/Integer.valueOf(arr[1].toString()));

            resultList.add(arr);
        }
        Map map=new HashMap<String, Object>();
        map.put("code","00");
        map.put("resultList", resultList);
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
}
