package com.jq.support.main.controller.merchandise.statement;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.dao.merchandise.shop.PmBusinessIndicatorsDao;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.shop.*;
import com.jq.support.model.statement.PmShopUserSourceStatistics;
import com.jq.support.model.statement.PmShopUserStatistics;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.shop.*;
import com.jq.support.service.statement.PmShopUserSourceStatisticsService;
import com.jq.support.service.statement.PmShopUserStatisticsService;
import com.jq.support.service.statement.TodayStamentService;
import com.jq.support.service.utils.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 统计报表的controller
 */
@Controller
@RequestMapping(value = "${adShopPath}/statement")
public class ShopStatementController {
    @Autowired
    private PmShopUserSourceStatisticsService pmShopUserSourceStatisticsService;
    @Autowired
    private PmShopUserStatisticsService pmShopUserStatisticsService;
    @Autowired
    private PmShopUserService pmShopUserService;
    @Autowired
    private PmBusinessStatisticsService pmBusinessStatisticsService;
    @Autowired
    private EbOrderService ebOrderService;
    @Autowired
    private PmBusinessDailyService pmBusinessDailyService;
    @Autowired
    private PmBusinessDailyItemService pmBusinessDailyItemService;
    @Autowired
    private PmBusinessDailyItemPayService pmBusinessDailyItemPayService;
    @Autowired
    private PmBusinessDailyRankingService pmBusinessDailyRankingService;
    @Autowired
    private PmProductTasteRankingService pmProductTasteRankingService;
    @Autowired
    private PmProductTasteService pmProductTasteService;
    @Autowired
    private PmBusinessIndicatorsService pmBusinessIndicatorsService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private TodayStamentService todayStamentService;

    /**
     * 分页条件查询营业汇总列表
     * @param request
     * @param response
     * @param model
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如1为今天 2为近七天 3为近三十天
     * @param type  查询汇总的分类 1 日 2 月
     * @return
     */
    @RequestMapping(value = "statisticsList")
    public String statisticsList(HttpServletRequest request , HttpServletResponse response , Model model ,
                                 String timeRange , Integer quickTime,
                                 Integer type,@RequestParam(defaultValue = "0") Integer isAll,Integer shopId){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }
        if(StringUtil.isBlank(timeRange) && quickTime == null){
            quickTime = 1;
        }
        shopId = getShopId(request);
        Page<PmBusinessStatistics> page = null;
        List<PmBusinessStatistics> todayDateList = null;
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&&DateUtil2.isInDate(timeRange," - "))) {
            todayDateList = todayStamentService.oneDayStatistics(shopId,type);
        }
        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessStatisticsService.getRangeListByDay(new Page<PmBusinessStatistics>(1, Integer.MAX_VALUE),  quickTime, startTime, endTime , isAll , shopId);
            }

        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessStatisticsService.getRangeListByMonth(new Page<PmBusinessStatistics>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, isAll, shopId);
            }
        }

        page = getPage(todayDateList, page, new Page<PmBusinessStatistics>(request,response));
        model.addAttribute("page",page);
        model.addAttribute("type",type);
        model.addAttribute("timeRange",timeRange);
        model.addAttribute("quickTime",quickTime);
        model.addAttribute("isAll",isAll);
        model.addAttribute("shopId",shopId);
        model.addAttribute("pmBusinessStatistics",new PmBusinessStatistics());

        return "modules/shop/statement/statisticsList";
    }

    // 营业汇总日报
    @RequestMapping(value = "statisticsDaily")
    public String statisticsDaily(){
        return "modules/shop/statement/statisticsDaily";
    }  
    
    // 营业汇总月报
    @RequestMapping(value = "statisticsMonth")
    public String statisticsMonth(){
        return "modules/shop/statement/statisticsMonth"; 
    }
    
    // 营业指标月报
    @RequestMapping(value = "targetMonth")
    public String targetMounth(){
        return "modules/shop/statement/targetMonth";
    }
    
    // 报表管理营业分析
    @RequestMapping(value = "reportbusinessAnalysis")
    public String reportbusinessAnalysis(){
        return "modules/shop/statement/reportbusinessAnalysis";
    }  
    
    //  营业指标日报
    @RequestMapping(value = "targetDaily")
    public String targetDaily(){
        return "modules/shop/statement/targetDaily";
    }  
   

    /**
     * 导出营业汇总报表
     * @param request
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @param type  查询汇总的分类 1 日 2 月
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "statisticsExcel")
    public String statisticsExcel(HttpServletRequest request ,String timeRange , Integer quickTime,
                                  Integer type,Integer isAll,Integer shopId,String[] syllable){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }
        shopId = getShopId(request);
        Page<PmBusinessStatistics> page = null;
        List<PmBusinessStatistics> todayDateList = null;
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&&DateUtil2.isInDate(timeRange," - "))) {
            todayDateList = todayStamentService.oneDayStatistics(shopId,type);
        }
        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessStatisticsService.getRangeListByDay(new Page<PmBusinessStatistics>(1, Integer.MAX_VALUE),  quickTime, startTime, endTime , isAll , shopId);
            }
        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessStatisticsService.getRangeListByMonth(new Page<PmBusinessStatistics>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, isAll, shopId);
            }
        }

        page = getPage(todayDateList, page, new Page<PmBusinessStatistics>(1,Integer.MAX_VALUE));

        String title = type==1 ? "门店营业汇总日报":"门店营业汇总月报";
        String url = new ExcelUtil().export(syllable, page.getList(), title, request);

        return url;
    }


    /**
     * 查看营业日报
     * @param specificTime
     * @param response
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "businessDaily")
    public String getBusinessDaily(String specificTime ,HttpServletResponse response,
                                   HttpServletRequest request , Model model,Integer shopId){

        if(StringUtil.isBlank(specificTime)){
            specificTime = FormatUtil.getTodayStr();
        }

        PmBusinessDaily pmBusinessDaily = null;
        //来源表
        List<PmBusinessDailyItem> itemList = null;
        shopId = getShopId(request);
        List<List<PmBusinessDailyItemPay>> payList = null;
        List<List<PmBusinessDailyRanking>> rankingList = null;
        List<List<PmBusinessDailyRanking>> weightRankingList = null;

        if(!FormatUtil.getTodayStr().equals(specificTime)) {
            //日报总表
            pmBusinessDaily = pmBusinessDailyService.getListBySpecificTime(specificTime, 0, shopId);

            if (pmBusinessDaily == null) {
                return "modules/shop/statement/businessDaily";
            }

            itemList = pmBusinessDailyItemService.getListByDailyId(pmBusinessDaily.getId());

            payList = new ArrayList();
            rankingList = new ArrayList();
            weightRankingList = new ArrayList();

            if (itemList != null) {
                for (PmBusinessDailyItem item : itemList) {
                    //实付构成
                    List<PmBusinessDailyItemPay> pays = pmBusinessDailyItemPayService.getListByDailItemId(item.getId());
                    payList.add(pays);

                    //菜品排名
                    List<PmBusinessDailyRanking> rankings = pmBusinessDailyRankingService.getListByDailItemId(item.getId(),1);
                    List<PmBusinessDailyRanking> weightRankings = pmBusinessDailyRankingService.getListByDailItemId(item.getId(),2);
                    rankingList.add(rankings);
                    weightRankingList.add(weightRankings);
                }
            }
        }else{
             pmBusinessDaily = todayStamentService.totalBusinessDaily(shopId);
             if(CollectionUtils.isNotEmpty(pmBusinessDaily.getItemList())){
                 itemList = pmBusinessDaily.getItemList();
                 payList = new ArrayList();
                 rankingList = new ArrayList();
                 weightRankingList = new ArrayList();
                 for (PmBusinessDailyItem item : itemList){
                     payList.add(item.getPayList());
                     rankingList.add(item.getRankingList());
                     weightRankingList.add(item.getWegihtRankingList());
                 }
             }
        }

        model.addAttribute("pmBusinessDaily",pmBusinessDaily);
        model.addAttribute("shopId",shopId);
        model.addAttribute("itemList",itemList);
        model.addAttribute("weightRankingList",weightRankingList);
        model.addAttribute("payList",payList);
        model.addAttribute("specificTime",specificTime);
        model.addAttribute("rankingList",rankingList);

        return "modules/shop/statement/businessDaily";
    }

    /**
     * 菜品营业分析
     * @param request
     * @param response
     * @param model
     * @param timeRange      时间范围
     * @param quickTime      快速选择的时间  1  昨天  2 前七天  3 前三十天
     * @return
     */
    @RequestMapping("produtTasteList")
    public  String produtTasteList(HttpServletRequest request , HttpServletResponse response , Model model ,
                                   String timeRange ,  Integer quickTime, Integer shopId){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }
        if(StringUtil.isBlank(timeRange) && quickTime == null){
            quickTime = 1;
        }
        shopId = getShopId(request);
        List<PmProductTaste> tasteList = pmProductTasteService.getListByTimeRange(quickTime, startTime, endTime,0,shopId);

        Page<PmProductTasteRanking> rankingPage1 = pmProductTasteRankingService.getListTimeRange(new Page<PmProductTasteRanking>(request, response), 0,
                0, 1, quickTime, startTime, endTime,0,shopId);

        Page<PmProductTasteRanking> rankingPage2 = pmProductTasteRankingService.getListTimeRange(new Page<PmProductTasteRanking>(request, response), 0,
                0, 2, quickTime, startTime, endTime,0,shopId);

        Page<PmProductTasteRanking> rankingPage3 = pmProductTasteRankingService.getListTimeRange(new Page<PmProductTasteRanking>(request, response), 0,
                0, 3, quickTime, startTime, endTime,0,shopId);

        model.addAttribute("tasteList",tasteList);
        model.addAttribute("shopId",shopId);
        model.addAttribute("rankingPage1",rankingPage1);
        model.addAttribute("rankingPage2",rankingPage2);
        model.addAttribute("rankingPage3",rankingPage3);
        model.addAttribute("timeRange",timeRange);
        model.addAttribute("quickTime",quickTime);

        return "modules/shop/statement/productTastList";
    }


    /**
     * 对菜品口味排序进行分页条件查询
     * @param request
     * @param response
     * @param timeRange     时间范围
     * @param quickTime     快速选择的时间  1  昨天  2 前七天  3 前三十天
     * @param type          类型 1 不包含加料  2  包含加料
     * @param sortType      排序的类型 0 门店  1 自提  2外卖
     * @param sortBy        排序的依据 0 销售量 1 金额
     * @return
     */
    @ResponseBody
    @RequestMapping("productTasteCharging")
    public Map productTasteCharging(HttpServletRequest request , HttpServletResponse response,
                                    String timeRange , Integer quickTime,@RequestParam(defaultValue = "1") Integer type
            ,@RequestParam(defaultValue = "0")Integer sortType , @RequestParam(defaultValue = "0")Integer sortBy,Integer shopId){

        Map<String , Page<PmProductTasteRanking>> map = new HashMap<String, Page<PmProductTasteRanking>>();

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }else if(quickTime == null){
            quickTime=1;
        }
        shopId = getShopId(request);
        Page<PmProductTasteRanking> rangkingPage = pmProductTasteRankingService.getListTimeRange(new Page<PmProductTasteRanking>(request, response), sortType,
                sortBy, type, quickTime, startTime, endTime, 0 , shopId);

        map.put("data",rangkingPage);

        return map;
    }


    /**
     * 分页条件查询营业指标列表
     * @param request
     * @param response
     * @param model
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @param type  查询汇总的分类 1 日 2 月
     * @param isAll  是否为所有门店的汇总 0 不是  1是
     * @return
     */
    @RequestMapping(value = "indicatorList")
    public String indicatorList(HttpServletRequest request , HttpServletResponse response , Model model ,
                                String timeRange , @RequestParam(defaultValue = "1") Integer quickTime,
                                @RequestParam(defaultValue = "1") Integer type , @RequestParam(defaultValue = "0")Integer orderType,
                                @RequestParam(defaultValue = "0") Integer isAll,Integer shopId){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }
        shopId = getShopId(request);
        Page<PmBusinessIndicators> page = null;
        List<PmBusinessIndicators> todayDateList=null;
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&&DateUtil2.isInDate(timeRange," - "))) {
            todayDateList = todayStamentService.oneDayIndicator(orderType,shopId,type);
        }
        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)) {
                page = pmBusinessIndicatorsService.getRangeListByDay(new Page<PmBusinessIndicators>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, orderType, isAll, shopId);
            }
        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)) {
                page = pmBusinessIndicatorsService.getRangeListByMonth(new Page<PmBusinessIndicators>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, orderType, isAll, shopId);
            }
        }

        page = getPage(todayDateList,page,new Page<PmBusinessIndicators>(request,response));
        model.addAttribute("page",page);
        model.addAttribute("type",type);
        model.addAttribute("orderType",orderType);
        model.addAttribute("timeRange",timeRange);
        model.addAttribute("quickTime",quickTime);
        model.addAttribute("isAll",isAll);
        model.addAttribute("shopId",shopId);
        model.addAttribute("pmBusinessStatistics",new PmBusinessStatistics());

        return "modules/shop/statement/indicatorList";
    }


    /**
     * 导出营业指标报表
     * @param request
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @param type  查询汇总的分类 1 日 2 月
     * @param isAll  是否为所有门店的汇总 0 不是  1是
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "indicatorExcel")
    public String indicatorExcel(HttpServletRequest request ,String[] syllable ,String timeRange ,  Integer quickTime,
                                 Integer type , Integer orderType,Integer isAll,Integer shopId){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }
        shopId = getShopId(request);
        Page<PmBusinessIndicators> page = null;
        List<PmBusinessIndicators> todayDateList=null;
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&&DateUtil2.isInDate(timeRange," - "))) {
            todayDateList = todayStamentService.oneDayIndicator(orderType,shopId,type);
        }
        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)) {
                page = pmBusinessIndicatorsService.getRangeListByDay(new Page<PmBusinessIndicators>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, orderType, isAll, shopId);
            }
        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)) {
                page = pmBusinessIndicatorsService.getRangeListByMonth(new Page<PmBusinessIndicators>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, orderType, isAll, shopId);
            }
        }

        page = getPage(todayDateList,page,new Page<PmBusinessIndicators>(1,Integer.MAX_VALUE));

        String title = type ==1?"门店营业指标日报":"门店营业指标月报";

        String url = new ExcelUtil().export(syllable, page.getList(), title, request);

        return url;
    }



    /**
     * 分页条件查询营业汇总列表（json格式）
     * @param request
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，2为前七天  3为前三十天
     * @param type  查询汇总的分类 1 日 2 月
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "statisticsListJson")
    public  Map<String,Object> statisticsListJson(HttpServletRequest request , String timeRange , Integer quickTime,Integer type){

        Map<String , Object> map = new HashMap<String, Object>();
        Integer shopId = getShopId(request);

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }
        if(StringUtil.isBlank(timeRange) && quickTime == null){
            quickTime = 2;
        }

        Page<PmBusinessStatistics> page = null;
        List<PmBusinessStatistics> todayDateList = null;

        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&&DateUtil2.isInDate(timeRange," - "))) {
            todayDateList = todayStamentService.oneDayStatistics(shopId ,type);
        }

        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessStatisticsService.getRangeListByDay(new Page<PmBusinessStatistics>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, 0, shopId);
            }
        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)){
            page = pmBusinessStatisticsService.getRangeListByMonth(new Page<PmBusinessStatistics>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, 0, shopId);
            }
        }

        page = getPage(todayDateList, page, new Page<PmBusinessStatistics>(1,Integer.MAX_VALUE));

        Map<String,Map<String,Object>> allOrderInfoMap = new HashMap<String,Map<String,Object>>();
        Map<String,Map<String,Object>> proportionMap =  new HashMap<String,Map<String,Object>>();
        List<Map<String,Object>> orderInfoByDayList = new ArrayList<Map<String,Object>>();
        List<Map<String,Object>> memberTopupByDayList = new ArrayList<Map<String,Object>>();

        Double[] payMoneyCountArr = {0.0,0.0,0.0,0.0};  //0 总订单应付  1门店订单应付 2自提订单应付 3外卖订单应付
        Double[] readMoneyCountArr = {0.0,0.0,0.0,0.0}; //0 总订单实付  1门店订单实付 2自提订单实付 3外卖订单实付
        Integer[] orderCountArr = {0,0,0,0};//0 总订单总数  1门店订单总数 2自提订单总数 3外卖订单总数

        if(CollectionUtils.isNotEmpty(page.getList())){
            for(PmBusinessStatistics statistics : page.getList()){
                //应付统计
                payMoneyCountArr[0]= add(payMoneyCountArr[0],statistics.getAllPayableAmount());
                payMoneyCountArr[1]= add(payMoneyCountArr[1],statistics.getStorePayableAmount());
                payMoneyCountArr[2]= add(payMoneyCountArr[2],statistics.getSelfPayableAmount());
                payMoneyCountArr[3]= add(payMoneyCountArr[3],statistics.getOnlinePayableAmount());


                //实付统计
                readMoneyCountArr[0]= add(readMoneyCountArr[0],statistics.getAllRealAmount());
                readMoneyCountArr[1]= add(readMoneyCountArr[1],statistics.getStoreRealAmount());
                readMoneyCountArr[2]= add(readMoneyCountArr[2],statistics.getSelfRealAmount());
                readMoneyCountArr[3]= add(readMoneyCountArr[3],statistics.getOnlineRealAmount());


//                订单总数
                orderCountArr[0]+= statistics.getAllOrderTotal();
                orderCountArr[1]+= statistics.getStoreOrderTotal();
                orderCountArr[2]+= statistics.getSelfOrderTotal();
                orderCountArr[3]+= statistics.getOnlineOrderTotal();
            }
        }

        Map<String,Object> payableMoneyMap = new HashMap<String,Object>();
        Map<String,Object> orderCountMap = new HashMap<String,Object>();
        Map<String,Object> realMoneyMap = new HashMap<String,Object>();

        payableMoneyMap.put("allPayableMoney",payMoneyCountArr[0]);     //所有订单应付
        payableMoneyMap.put("storePayableMoney",payMoneyCountArr[1]);   //门店订单应付
        payableMoneyMap.put("selfPayableMoney",payMoneyCountArr[2]);    //自提订单应付
        payableMoneyMap.put("onlinePayableMoney",payMoneyCountArr[3]);  //外卖订单应付

        orderCountMap.put("allOrderCount",orderCountArr[0]);        //所有订单订单数
        orderCountMap.put("storeOrderCount",orderCountArr[1]);      //门店订单订单数
        orderCountMap.put("selfOrderCount",orderCountArr[2]);       //自提订单订单数
        orderCountMap.put("onlineOrderCount",orderCountArr[3]);     //外卖订单订单数

        realMoneyMap.put("allRealMoney",readMoneyCountArr[0]);   //所有订单实付
        realMoneyMap.put("storeRealMoney",readMoneyCountArr[1]); //门店订单实付
        realMoneyMap.put("selfRealMoney",readMoneyCountArr[2]); //自提订单实付
        realMoneyMap.put("onlineRealMoney",readMoneyCountArr[3]);//外卖订单实付

        allOrderInfoMap.put("payableMoneyMap",payableMoneyMap);
        allOrderInfoMap.put("orderCountMap",orderCountMap);
        allOrderInfoMap.put("realMoneyMap",realMoneyMap);


        //比例数组 0 门店订单 1自提订单  2外卖订单
        String[] payProportionArr = {"0.0","0.0","0.0"};  //应付比例数组
        String[] realProportionArr = {"0.0","0.0","0.0"};   //实付比例数组
        String[] orderProportionArr = {"0.0","0.0","0.0"};      //订单总数比例数组

        if(CollectionUtils.isNotEmpty(page.getList())) {

            //防止payMoneyCountArr[0]为0计算报错
            if (payMoneyCountArr[0] != 0) {
                //计算应付比例
                payProportionArr[0] = new Formatter().format("%.2f", (payMoneyCountArr[1] / payMoneyCountArr[0])*100).toString();
                payProportionArr[1] = new Formatter().format("%.2f", (payMoneyCountArr[2] / payMoneyCountArr[0])*100).toString();
                payProportionArr[2] = new Formatter().format("%.2f", (payMoneyCountArr[3] / payMoneyCountArr[0])*100).toString();
            }

            if (readMoneyCountArr[0] != 0) {
                //计算实付比例
                realProportionArr[0] = new Formatter().format("%.2f", (readMoneyCountArr[1] / readMoneyCountArr[0])*100).toString();
                realProportionArr[1] = new Formatter().format("%.2f", (readMoneyCountArr[2] / readMoneyCountArr[0])*100).toString();
                realProportionArr[2] = new Formatter().format("%.2f", (readMoneyCountArr[3] / readMoneyCountArr[0])*100).toString();
            }

            if (orderCountArr[0] != 0) {
                //计算订单总数比例
                orderProportionArr[0] = new Formatter().format("%.2f", ((double) orderCountArr[1] / (double) orderCountArr[0])*100).toString();
                orderProportionArr[1] = new Formatter().format("%.2f", ((double) orderCountArr[2] / (double) orderCountArr[0])*100).toString();
                orderProportionArr[2] = new Formatter().format("%.2f", ((double) orderCountArr[3] / (double) orderCountArr[0])*100).toString();
            }
        }

        //比例map
        Map<String,Object> payableMoneyProportionMap = new HashMap<String, Object>(); //实付map
        Map<String,Object> orderCountProportionMap = new HashMap<String, Object>();     //订单总数map
        Map<String,Object> realMoneyProportionMap = new HashMap<String, Object>();      //实付map

        //比例数组 0 门店订单 1自提订单  2外卖订单
        payableMoneyProportionMap.put("store",payProportionArr[0]);
        payableMoneyProportionMap.put("self",payProportionArr[1]);
        payableMoneyProportionMap.put("online",payProportionArr[2]);

        orderCountProportionMap.put("store",orderProportionArr[0]);
        orderCountProportionMap.put("self",orderProportionArr[1]);
        orderCountProportionMap.put("online",orderProportionArr[2]);

        realMoneyProportionMap.put("store",realProportionArr[0]);
        realMoneyProportionMap.put("self",realProportionArr[1]);
        realMoneyProportionMap.put("online",realProportionArr[2]);

        proportionMap.put("payable",payableMoneyProportionMap);
        proportionMap.put("order",orderCountProportionMap);
        proportionMap.put("real",realMoneyProportionMap);


        Double memberTopupCount = 0.0;

        Collections.sort(page.getList(),new Comparator<PmBusinessStatistics>(){
            public int compare(PmBusinessStatistics arg0, PmBusinessStatistics arg1) {
                return arg0.getTotalTime().compareTo(arg1.getTotalTime());
            }
        });
        if(CollectionUtils.isNotEmpty(page.getList())){
            for(PmBusinessStatistics statistics : page.getList()){
                Object[] arr = new Object[4];
                Object[] arr2 = new Object[2];

                SimpleDateFormat format = null;
                if(type==1){
                    format = new SimpleDateFormat("yyyy-MM-dd");
                }else{
                    format = new SimpleDateFormat("yyyy-MM");
                }
                arr[0]=format.format(statistics.getTotalTime());
                arr[1] = statistics.getAllPayableAmount();
                arr[2] = statistics.getAllRealAmount();
                arr[3] = statistics.getAllOrderTotal();

                arr2[0]=format.format(statistics.getTotalTime());
                memberTopupCount+= statistics.getMemberTopup();
                arr2[1] = statistics.getMemberTopup();//临时占用比例的空间

                Map <String , Object> itemMap = new HashMap<String, Object>();
                Map <String , Object> topUpMap = new HashMap<String, Object>();
                itemMap.put("date",arr[0]);
                itemMap.put("payableMoney",arr[1]);
                itemMap.put("realMoney",arr[2]);
                itemMap.put("orderCount",arr[3]);

                topUpMap.put("date",arr2[0]);
                topUpMap.put("proportion",arr2[1]);
                orderInfoByDayList.add(itemMap);
                memberTopupByDayList.add(topUpMap);
            }
        }

        //把充值金额替换成比例
        for(Map <String , Object> stringObjectMap : memberTopupByDayList){
            Double money = (Double) stringObjectMap.get("proportion");
            String  proportion = memberTopupCount == 0.0 ? "0.0" : new Formatter().format("%.2f",divide(money,memberTopupCount)).toString();
            map.put("proportion",proportion);
        }



        map.put("allOrderInfo",allOrderInfoMap);
        map.put("proportion",proportionMap);
        map.put("orderInfoByDayList",orderInfoByDayList);
        map.put("memberTopupByDayList",memberTopupByDayList);
        map.put("code",CollectionUtils.isNotEmpty(page.getList()) ? "01":"02");
        map.put("msg",CollectionUtils.isNotEmpty(page.getList()) ? "查询成功":"暂无数据");
//        map.put("data",page.getList());
        map.put("type",type);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        map.put("quickTime",quickTime);

        return map;
    }

    /**
     * 分页条件查询营业指标列表（json）
     * @param request
     * @param growthType 增长率类型  1环比增长率  2同比增长率
     * @param timeRange 分页条件查询营业指标列表（json）
     * @param quickTime  快捷时间，如昨天为1  2为前七天 3前三十天
     * @param type 查询汇总的分类 1 日 2 月
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "indicatorListJson")
    public  Map<String , Object> indicatorListJson(HttpServletRequest request ,Integer growthType,
                                                   String timeRange , @RequestParam(defaultValue = "2") Integer quickTime,
                                                   @RequestParam(defaultValue = "1") Integer type ){

        Map<String , Object> map = new HashMap<String, Object>();
        Integer shopId = getShopId(request);

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }
        //当没有指定时间范围和选择快捷时间时，默认查询昨天的记录
        if(StringUtil.isBlank(timeRange) && quickTime == null){
            quickTime = 1;
        }

        Page<PmBusinessIndicators> page = null;
        List<PmBusinessIndicators> todayDateList=null;
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&&DateUtil2.isInDate(timeRange," - "))) {
            todayDateList = todayStamentService.oneDayIndicator(0,shopId,type);
        }
        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessIndicatorsService.getRangeListByDay(new Page<PmBusinessIndicators>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, 0, 0, shopId);
            }
        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessIndicatorsService.getRangeListByMonth(new Page<PmBusinessIndicators>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, 0, 0, shopId);
            }
        }

        page = getPage(todayDateList,page,new Page<PmBusinessIndicators>(1,Integer.MAX_VALUE));
        List<Map<String,Object>> orderInfoList = new ArrayList<Map<String,Object>>();

        Collections.sort(page.getList(), new Comparator<PmBusinessIndicators>() {
            public int compare(PmBusinessIndicators o1, PmBusinessIndicators o2) {
                return o1.getTotalTime().compareTo(o2.getTotalTime());
            }
        });
        if(CollectionUtils.isNotEmpty(page.getList())){
            for(PmBusinessIndicators indicators:page.getList()){
                Object[] arr = new Object[3];

                SimpleDateFormat simpleDateFormat = null;
                if(type==1){    //日报的时候统计日期格式为日
                    simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                }else{ //日报的时候统计日期格式为月
                    simpleDateFormat = new SimpleDateFormat("yyyy-MM");
                }

                arr[0] = simpleDateFormat.format(indicators.getTotalTime());
                arr[1] = indicators.getRealAmount();
                arr[2] = new Formatter().format("%.0f", getGrowthRate(growthType,indicators)).toString();

                Map<String ,Object> itemMap = new HashMap<String, Object>();
                itemMap.put("date",arr[0]);
                itemMap.put("realAmount",arr[1]);
                itemMap.put("growthRate",arr[2]);
                orderInfoList.add(itemMap);
            }
        }

        map.put("code",CollectionUtils.isNotEmpty(page.getList()) ? "01":"02");
        map.put("msg",CollectionUtils.isNotEmpty(page.getList()) ? "查询成功":"暂无数据");
        map.put("data",orderInfoList);
        map.put("type",type);
        map.put("growthType",growthType);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        map.put("quickTime",quickTime);


        return map;
    }





    /**
     * 营业分析(json)
     * @param request
     * @param timeRange      时间范围
     * @param quickTime      快速选择的时间  1  昨天  2 前七天  3 前三十天
     * @return
     */
    @ResponseBody
    @RequestMapping("productTasteListJson")
    public   Map<String , Object> produtTasteListJson(HttpServletRequest request ,String timeRange ,  Integer quickTime){

        Map<String , Object> map = new HashMap<String, Object>();
        Integer shopId = getShopId(request);
        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }
        if(StringUtil.isBlank(timeRange) && quickTime == null){
            quickTime = 1;
        }

        List<PmProductTaste> tasteList = pmProductTasteService.getListByTimeRange(quickTime, startTime, endTime,0,shopId);


        Map<String , Object> moneyProportionMap = new HashMap<String, Object>(3);
        Map<String , Object> salesProportionMap = new HashMap<String, Object>(3);
        //斩料占比的map
        Map<String , Object> weightMoneyProportionMap = new HashMap<String, Object>(3);
        Map<String , Object> weightSalesProportionMap = new HashMap<String, Object>(3);
        moneyProportionMap.put("store","0");    //门店订单占比
        moneyProportionMap.put("self","0");     //自提订单占比
        moneyProportionMap.put("online","0");   //外卖订单占比

        salesProportionMap.put("store","0");    //门店订单占比
        salesProportionMap.put("self","0");     //自提订单占比
        salesProportionMap.put("online","0");   //外卖订单占比

        weightMoneyProportionMap.put("store","0");    //门店订单占比
        weightMoneyProportionMap.put("self","0");     //自提订单占比
        weightMoneyProportionMap.put("online","0");   //外卖订单占比

        weightSalesProportionMap.put("store","0");    //门店订单占比
        weightSalesProportionMap.put("self","0");     //自提订单占比
        weightSalesProportionMap.put("online","0");   //外卖订单占比

        if(CollectionUtils.isNotEmpty(tasteList)){
            Double storeMoneyCount = 0.0;
            Double selfMoneyCount = 0.0;
            Double onlineMoneyCount = 0.0;

            Integer storeSalesCount = 0;
            Integer selfSalesCount = 0;
            Integer onlineSalesCount = 0;

            Double weightStoreMoneyCount = 0.0;
            Double weightSelfMoneyCount = 0.0;
            Double weightOnlineMoneyCount = 0.0;

            Integer weightStoreSalesCount = 0;
            Integer weightSelfSalesCount = 0;
            Integer weightOnlineSalesCount = 0;

            //统计门店
            for(PmProductTaste taste : tasteList){
                storeMoneyCount = add(storeMoneyCount,taste.getStoreMoney());
                selfMoneyCount = add(selfMoneyCount,taste.getSelfMoney());
                onlineMoneyCount = add(onlineMoneyCount,taste.getOnlineMoney());

                storeSalesCount = storeSalesCount+taste.getStoreSales();
                selfSalesCount = selfSalesCount+taste.getSelfSales();
                onlineSalesCount = onlineSalesCount+taste.getOnlineSales();

                weightStoreMoneyCount = add(weightStoreMoneyCount,taste.getWeightStoreMoney());
                weightSelfMoneyCount = add(weightSelfMoneyCount,taste.getWeightSelfMoney());
                weightOnlineMoneyCount = add(weightOnlineMoneyCount,taste.getWeightOnlineMoney());

                weightStoreSalesCount = weightStoreSalesCount+taste.getWeightStoreSales();
                weightSelfSalesCount = weightSelfSalesCount+taste.getWeightSelfSales();
                weightOnlineSalesCount = weightOnlineSalesCount+taste.getWeightOnlineSales();

                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                taste.setTotalTimeStr(format.format(taste.getTotalTime()));

            }

            double moneyCount = storeMoneyCount+selfMoneyCount+onlineMoneyCount;
            double salesCount = storeSalesCount+selfSalesCount+onlineSalesCount;

            double weightMoneyCount = weightStoreMoneyCount+weightSelfMoneyCount+weightOnlineMoneyCount;
            double weightSalesCount = weightStoreSalesCount+weightSelfSalesCount+weightOnlineSalesCount;

            //计算各类订单的应付金额和销售量的占比
            if(moneyCount != 0){
                moneyProportionMap.put("store",new Formatter().format("%.2f", divide(storeMoneyCount,moneyCount)*100).toString());
                moneyProportionMap.put("self",new Formatter().format("%.2f", divide(selfMoneyCount,moneyCount)*100).toString());
                moneyProportionMap.put("online",new Formatter().format("%.2f", divide(onlineMoneyCount,moneyCount)*100).toString());
            }

            if(salesCount != 0){
                salesProportionMap.put("store",new Formatter().format("%.2f", divide((double)storeSalesCount,(double)salesCount)*100).toString());
                salesProportionMap.put("self",new Formatter().format("%.2f", divide((double)selfSalesCount,(double)salesCount)*100).toString());
                salesProportionMap.put("online",new Formatter().format("%.2f", divide((double)onlineSalesCount,(double)salesCount)*100).toString());
            }

            //计算斩料各类订单的应付金额和销售量的占比
            if(moneyCount != 0){
                weightMoneyProportionMap.put("store",new Formatter().format("%.2f", divide(weightStoreMoneyCount,weightMoneyCount)*100).toString());
                weightMoneyProportionMap.put("self",new Formatter().format("%.2f", divide(weightSelfMoneyCount,weightMoneyCount)*100).toString());
                weightMoneyProportionMap.put("online",new Formatter().format("%.2f", divide(weightOnlineMoneyCount,weightMoneyCount)*100).toString());
            }

            if(salesCount != 0){
                weightSalesProportionMap.put("store",new Formatter().format("%.2f", divide((double)weightStoreSalesCount,(double)weightSalesCount)*100).toString());
                weightSalesProportionMap.put("self",new Formatter().format("%.2f", divide((double)weightSelfSalesCount,(double)weightSalesCount)*100).toString());
                weightSalesProportionMap.put("online",new Formatter().format("%.2f", divide((double)weightOnlineSalesCount,(double)weightSalesCount)*100).toString());
            }
        }


        map.put("code",CollectionUtils.isNotEmpty(tasteList) ? "01":"02");
        map.put("msg",CollectionUtils.isNotEmpty(tasteList) ? "查询成功":"暂无数据");
        map.put("quickTime",quickTime);
        map.put("startTime",startTime);
        map.put("endTime",endTime);
        map.put("moneyProportion",moneyProportionMap);
        map.put("salesProportion",salesProportionMap);
        map.put("weightMoneyProportion",weightMoneyProportionMap);
        map.put("weightSalesProportion",weightSalesProportionMap);
        map.put("data",tasteList);

        return map;
    }


    /**
     * 获得当前商家的id
     * @param request
     * @return
     */
    public Integer getShopId(HttpServletRequest request){
        EbUser ebUser = (EbUser)request.getSession().getAttribute("shopuser");
        if(ebUser == null || ebUser.getShopId() == null){
            return null;
        }

        PmShopInfo pmShopInfo = pmShopInfoService.getById(ebUser.getShopId());
        if(pmShopInfo == null){
            return null;
        }
        return pmShopInfo.getId();
    }


    /**
     * 俩个double相加
     * @param v1
     * @param v2
     * @return
     */
    public double add(Double v1 , Double v2){
        v1 = v1 == null ? 0:v1;
        v2 = v2 == null ? 0:v2;
        BigDecimal b1 = new BigDecimal(v1.toString());
        BigDecimal b2 = new BigDecimal(v2.toString());
        return b1.add(b2).doubleValue();
    }


    /**
     * 俩个double相减 v1-v2
     * @param v1
     * @param v2
     * @return
     */
    public double subtracting(Double v1 , Double v2){
        v1 = v1 == null ? 0:v1;
        v2 = v2 == null ? 0:v2;
        BigDecimal b1 = new BigDecimal(v1.toString());
        BigDecimal b2 = new BigDecimal(v2.toString());
        return b1.subtract(b2).doubleValue();
    }

    /**
     * 相除 v1/v2
     * @param v1
     * @param v2
     * @return
     */
    public double divide(Double v1 , Double v2){
        if(v1 == null || v2 == null || v1 == 0 || v2 ==0){
            return 0;
        }
        BigDecimal b1 = new BigDecimal(v1.toString());
        BigDecimal b2 = new BigDecimal(v2.toString());
        return b1.divide(b2,7, RoundingMode.HALF_DOWN ).doubleValue();
    }

    /**
     * 获得增长率
     * @param growthType  增长率类型  1 环比增长  2 同比增长
     * @param indicators
     * @return
     */
    public Double getGrowthRate(Integer growthType , PmBusinessIndicators indicators){
        String lastTime = null;
        //获得昨天的日期
        Calendar cal  =  Calendar.getInstance();
        cal.setTime(indicators.getTotalTime());
        SimpleDateFormat format = null;

        if(indicators.getType() == 1){  //日报

            format = new SimpleDateFormat("yyyy-MM-dd");
            if(growthType == 1){    //环比增长
                cal.add(Calendar.DATE,-1);
            }else{  //同比增长
                cal.add(Calendar.YEAR,-1);
            }
            lastTime = format.format(cal.getTime());

        }else{  //月报
            format = new SimpleDateFormat("yyyy-MM");
            if(growthType == 1){    //环比增长
                cal.add(Calendar.MONTH,-1);
            }else{  //同比增长
                cal.add(Calendar.YEAR,-1);
            }
            lastTime = format.format(cal.getTime());
        }

        PmBusinessIndicators lashIndicators = pmBusinessIndicatorsService.getBySpecificTime(lastTime, indicators);

        if(lashIndicators == null || lashIndicators.getRealAmount()==0){
            return 0.0;
        }

        return divide(subtracting(indicators.getRealAmount() , lashIndicators.getRealAmount()) , lashIndicators.getRealAmount()) * 100;
    }



    /**
     * 手动给page
     * @param todayDateList 今天的数据
     * @param oldPage   原来统计好的数据
     * @param oldPage   需要放入数据的新newPage
     * @param <T>
     * @return
     */
    public <T>Page<T> getPage(List<T> todayDateList,Page<T> oldPage , Page<T> newPage){
        List<T> list = null;
        if(oldPage == null || CollectionUtils.isEmpty(oldPage.getList())){
            list = new ArrayList();
        }else{
            list = oldPage.getList();
        }

        //把当前的数据直接放入总的列表中
        if(CollectionUtils.isNotEmpty(todayDateList)){
            list.addAll(0,todayDateList);
        }

        List<T> resultList = new ArrayList<T>();

        //循环取出当前页的数据
        for(int i = 0 ; i < newPage.getMaxResults();i++){
            if(newPage.getFirstResult() + i >=list.size()){
                continue;
            }

            resultList.add(list.get(newPage.getFirstResult()+i));
        }

        newPage.setList(resultList);
        newPage.setCount(list.size());
        return newPage;
    }


}
