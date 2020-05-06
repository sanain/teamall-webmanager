package com.jq.support.main.controller.merchandise.statement;

import com.alipay.api.domain.ShopInfo;
import com.drew.metadata.exif.DataFormat;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.order.EbOrderSaleSource;
import com.jq.support.model.order.OrderExcel;
import com.jq.support.model.pay.PmOpenPayWay;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.shop.*;
import com.jq.support.model.statement.PmShopUserSourceStatistics;
import com.jq.support.model.statement.PmShopUserStatistics;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.order.EbOrderSaleSourceService;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.shop.*;
import com.jq.support.service.pay.PmOpenPayWayService;
import com.jq.support.service.statement.PmShopUserSourceStatisticsService;
import com.jq.support.service.statement.PmShopUserStatisticsService;
import com.jq.support.service.statement.TodayStamentService;
import com.jq.support.service.utils.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.formula.functions.T;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.solr.common.util.Hash;
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
import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 统计报表的controller
 */
@Controller
@RequestMapping(value = "${adminPath}/statement")
public class StatementController {
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
    private TodayStamentService todayStamentService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private PmShopPayTotalService pmShopPayTotalService;
    @Autowired
    private PmOpenPayWayService pmOpenPayWayService;
    @Autowired
    private EbOrderSaleSourceService ebOrderSaleSourceService;
    @Autowired
    private PmShopPayTotaViewlService pmShopPayTotaViewlService;

    /**
     * 查询交班统计
     * @param request
     * @param response
     * @param model
     * @param pmShopUser
     * @return
     */
    @RequiresPermissions("merchandise:statement:view")
    @RequestMapping(value = "handoverList")
    public String handoverList(HttpServletRequest request , HttpServletResponse response
            , Model model , PmShopUser pmShopUser){

        //查询交班的主表
        Page<PmShopUserStatistics> page = pmShopUserStatisticsService.getListByPmShopUser(pmShopUser, new Page<PmShopUserStatistics>(request, response));
        //查询来源表
        List<List<PmShopUserSourceStatistics>> sourceList = pmShopUserSourceStatisticsService.getByPmShopUserStatistics(page.getList(),null);

        List<Integer> ids = new ArrayList<Integer>();
        for(PmShopUserStatistics pus: page.getList()){
            ids.add(pus.getShopUserId());
        }
        //查询交班人员列表
        List<PmShopUser> shopUsersList = pmShopUserService.getShopUsersByIds(ids);

        model.addAttribute("allPay",getAllPay(sourceList)); //获得交班记录中的所有支付方式
        model.addAttribute("page" , page);
        model.addAttribute("pmShopUser" , pmShopUser);
        model.addAttribute("sourceList" , sourceList);
        model.addAttribute("shopUsersList" , shopUsersList);

        return "modules/shopping/statement/handoverList";
    }

    /**
     * 分页条件查询营业汇总列表
     * @param request
     * @param response
     * @param model
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @param type  查询汇总的分类 1 日 2 月
     * @return
     */
    @RequiresPermissions("merchandise:statement:view")
    @RequestMapping(value = "statisticsList")
    public String statisticsList(HttpServletRequest request , HttpServletResponse response , Model model ,
                                       String timeRange , Integer quickTime,
                                 Integer type,@RequestParam(defaultValue = "1") Integer isAll){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }
        if(StringUtil.isBlank(timeRange) && quickTime == null){
            quickTime = 1;
        }

        Page<PmBusinessStatistics> page = null;
        List<PmBusinessStatistics> todayDateList = new ArrayList<PmBusinessStatistics>();
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&& DateUtil2.isInDate(timeRange," - "))) {
            if(isAll == 0) {    //不是汇总查询所有门店
                List<PmShopInfo> allShop = pmShopInfoService.getAllShop();
                if (CollectionUtils.isNotEmpty(allShop)) {
                    // 循环统计今天的数据
                    for (PmShopInfo pmShopInfo : allShop) {
                        List<PmBusinessStatistics> list = todayStamentService.oneDayStatistics(pmShopInfo.getId(), type);
                        todayDateList.addAll(list);
                    }
                }
            }else{  //汇总
                // 统计今天所有门店数据之和
                todayDateList = todayStamentService.oneDayStatistics(null, type);
            }
        }
        // 从数据库中查询出来定时器统计的数据
        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessStatisticsService.getRangeListByDay(new Page<PmBusinessStatistics>(1, Integer.MAX_VALUE),  quickTime, startTime, endTime , isAll , null);
            }

        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessStatisticsService.getRangeListByMonth(new Page<PmBusinessStatistics>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, isAll, null);
            }
        }
        // 把今天实时统计出来的数据和数据库中的数据进行整合
        page = getPage(todayDateList, page, new Page<PmBusinessStatistics>(request,response));
        model.addAttribute("page",page);
        model.addAttribute("type",type);
        model.addAttribute("timeRange",timeRange);
        model.addAttribute("quickTime",quickTime);
        model.addAttribute("isAll",isAll);
        model.addAttribute("pmBusinessStatistics",new PmBusinessStatistics());

        return "modules/shopping/statement/statisticsList";
    }


    /**
     * 查看营业日报
     * @param specificTime
     * @param response
     * @param request
     * @param model
     * @param isAll 是否为所有门店的汇总  0 不是 1是
     * @param shopId    门店id
     * @return
     */
    @RequiresPermissions("merchandise:statement:view")
    @RequestMapping(value = "businessDaily")
    public String getBusinessDaily(String specificTime ,HttpServletResponse response,
                                   HttpServletRequest request , Model model ,
                                   @RequestParam(defaultValue="1") Integer isAll , Integer shopId){



        if(StringUtil.isBlank(specificTime)){
            specificTime =  FormatUtil.getTodayStr();
        }

        PmBusinessDaily pmBusinessDaily = null;
        //来源表
        List<PmBusinessDailyItem> itemList = null;

        List<List<PmBusinessDailyItemPay>> payList = null;
        List<List<PmBusinessDailyRanking>> rankingList = null;
        List<List<PmBusinessDailyRanking>> weightRankingList = null;

        if(!FormatUtil.getTodayStr().equals(specificTime)) {
            //日报总表
            pmBusinessDaily = pmBusinessDailyService.getListBySpecificTime(specificTime, isAll, shopId);

            if (pmBusinessDaily != null) {

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
                        List<PmBusinessDailyRanking> rankings1 = pmBusinessDailyRankingService.getListByDailItemId(item.getId(),1);
                        List<PmBusinessDailyRanking> rankings2 = pmBusinessDailyRankingService.getListByDailItemId(item.getId(),2);
                        rankingList.add(rankings1);
                        weightRankingList.add(rankings2);
                    }
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
        model.addAttribute("itemList",itemList);
        model.addAttribute("payList",payList);
        model.addAttribute("rankingList",rankingList);
        model.addAttribute("weightRankingList",weightRankingList);
        model.addAttribute("isAll",isAll);
        model.addAttribute("shopId",shopId);
        model.addAttribute("specificTime",specificTime);

        return "modules/shopping/statement/businessDaily";
    }

    /**
     * 菜品营业分析
     * @param request
     * @param response
     * @param model
     * @param timeRange      时间范围
     * @param quickTime      快速选择的时间  1  昨天  2 前七天  3 前三十天
     * @param isAll      是否是所有门店的汇总 0 不是 1是
     * @param shopId      门店id
     * @return
     */
    @RequiresPermissions("merchandise:statement:view")
    @RequestMapping("produtTasteList")
    public  String produtTasteList(HttpServletRequest request , HttpServletResponse response , Model model ,
                                    String timeRange , Integer quickTime,
                            @RequestParam(defaultValue = "1") Integer isAll , Integer shopId){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }else if(quickTime == null){
            quickTime=1;
        }

        List<PmProductTaste> tasteList = pmProductTasteService.getListByTimeRange(quickTime, startTime, endTime , isAll , shopId);

        //以商品为单位排行
        Page<PmProductTasteRanking> rankingPage1 = pmProductTasteRankingService.getListTimeRange(new Page<PmProductTasteRanking>(request, response), 0,
                0, 1, quickTime, startTime, endTime, isAll , shopId);

        //以规格为单位排行
        Page<PmProductTasteRanking> rankingPage2 = pmProductTasteRankingService.getListTimeRange(new Page<PmProductTasteRanking>(request, response), 0,
                0, 2, quickTime, startTime, endTime, isAll , shopId);

        //斩料排行
        Page<PmProductTasteRanking> rankingPage3 = pmProductTasteRankingService.getListTimeRange(new Page<PmProductTasteRanking>(request, response), 0,
                0, 3, quickTime, startTime, endTime, isAll , shopId);


        model.addAttribute("tasteList",tasteList);
        model.addAttribute("rankingPage1",rankingPage1);
        model.addAttribute("rankingPage2",rankingPage2);
        model.addAttribute("rankingPage3",rankingPage3);
        model.addAttribute("timeRange",timeRange);
        model.addAttribute("quickTime",quickTime);
        model.addAttribute("isAll",isAll);
        model.addAttribute("shopId",shopId);

        return "modules/shopping/statement/productTastList";
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
     * @param isAll        是否是所有门店的汇总 0 不是 1是
     * @param shopId       门店id
     * @return
     */
    @ResponseBody
    @RequestMapping("productTasteCharging")
    public Map productTasteCharging(HttpServletRequest request , HttpServletResponse response,
                                    String timeRange , Integer quickTime,@RequestParam(defaultValue = "1") Integer type
                                ,@RequestParam(defaultValue = "0")Integer sortType ,@RequestParam(defaultValue = "0")Integer sortBy
                                ,@RequestParam(defaultValue = "1") Integer isAll , Integer shopId){

        Map<String , Page<PmProductTasteRanking>> map = new HashMap<String, Page<PmProductTasteRanking>>();

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }

        Page<PmProductTasteRanking> rangkingPage = pmProductTasteRankingService.getListTimeRange(new Page<PmProductTasteRanking>(request, response), sortType,
                sortBy, type, quickTime, startTime, endTime, isAll , shopId);

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
    @RequiresPermissions("merchandise:statement:view")
    @RequestMapping(value = "indicatorList")
    public String indicatorList(HttpServletRequest request , HttpServletResponse response , Model model ,
                                 String timeRange , @RequestParam(defaultValue = "1") Integer quickTime,
                                @RequestParam(defaultValue = "1") Integer type , @RequestParam(defaultValue = "0")Integer orderType,
                                @RequestParam(defaultValue = "1") Integer isAll){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }


        Page<PmBusinessIndicators> page = null;
        List<PmBusinessIndicators> todayDateList=new ArrayList<PmBusinessIndicators>();
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&& DateUtil2.isInDate(timeRange," - "))) {
            if(isAll == 0) {    //不是汇总查询所有门店
                List<PmShopInfo> allShop = pmShopInfoService.getAllShop();
                if (CollectionUtils.isNotEmpty(allShop)) {
                    for (PmShopInfo pmShopInfo : allShop) {
                        List<PmBusinessIndicators> list = todayStamentService.oneDayIndicator(orderType,pmShopInfo.getId(), type);
                        todayDateList.addAll(list);
                    }
                }
            }else{  //汇总
                todayDateList = todayStamentService.oneDayIndicator(orderType,null, type);
            }
        }

        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)) {
                page = pmBusinessIndicatorsService.getRangeListByDay(new Page<PmBusinessIndicators>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, orderType, isAll, null);
            }
        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)) {
                page = pmBusinessIndicatorsService.getRangeListByMonth(new Page<PmBusinessIndicators>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, orderType, isAll, null);
            }
        }

        page = getPage(todayDateList,page,new Page<PmBusinessIndicators>(request,response));

        model.addAttribute("page",page);
        model.addAttribute("type",type);
        model.addAttribute("orderType",orderType);
        model.addAttribute("timeRange",timeRange);
        model.addAttribute("quickTime",quickTime);
        model.addAttribute("isAll",isAll);
        model.addAttribute("pmBusinessStatistics",new PmBusinessStatistics());

        return "modules/shopping/statement/indicatorList";
    }

    /**
     * 分页条件查询门店支付统计
     * @param request
     * @param response
     * @param model
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @return
     */
    @RequiresPermissions("merchandise:financial:view")
    @RequestMapping(value = "payTotalList")
    public String payTotalList(HttpServletRequest request , HttpServletResponse response , Model model ,
                                String timeRange , Integer quickTime,
                               String shopIds,Integer type,String shopNames){

        if(StringUtils.isBlank(timeRange)){
            quickTime=-1;
        }
        String[] strArr = getStartAndEndTime(quickTime, timeRange);
        timeRange = strArr[0];
        String startTime = strArr[1];
        String endTime = strArr[2];

        Page<PmShopPayTotal> page = pmShopPayTotalService.getPage(new FinancePageUtil<PmShopPayTotal>(1,Integer.MAX_VALUE),startTime,endTime,shopIds);

        FinancePageUtil<PmShopPayTotal> pageUtil = (FinancePageUtil<PmShopPayTotal>)page;

        pageUtil.copyList();
        List<PmShopPayTotal> todayList = new ArrayList<PmShopPayTotal>();

        //包含今天，就查询今天的数据
        if(DateUtil2.isInDate(timeRange," - ")){
            todayList = pmShopPayTotalService.totalToday(shopIds);
        }

        pageUtil = getShopPayPage(todayList, pageUtil, new FinancePageUtil<PmShopPayTotal>(request, response), type);

        if(StringUtils.isBlank(shopNames)){
            shopNames = pmShopInfoService.getNamesByIds(shopIds);
        }

        model.addAttribute("page",pageUtil);
        model.addAttribute("timeRange",timeRange);
        model.addAttribute("quickTime",quickTime);
        model.addAttribute("shopIds",shopIds);
        model.addAttribute("shopNames",shopNames);


        if(type == 1) {
            return "modules/shopping/statement/payTotalList";
        }else{
            return "modules/shopping/statement/payTotalItemList";
        }
    }


    /**
     * 分页条件查询门店支付统计视图
     * @param request
     * @param response
     * @param model
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @return
     */
    @RequiresPermissions("merchandise:financial:view")
    @RequestMapping(value = "payTotalViewList")
    public String payTotalViewList(HttpServletRequest request , HttpServletResponse response , Model model ,
                               String timeRange , Integer quickTime){

        if(StringUtils.isBlank(timeRange)){
            quickTime=-30;
        }
        String[] strArr = getStartAndEndTime(quickTime, timeRange);
        timeRange = strArr[0];
        String startTime = strArr[1];
        String endTime = strArr[2];

        Page<PmShopPayTotal> page = pmShopPayTotaViewlService.getPage(new FinancePageUtil<PmShopPayTotal>(request,response),startTime,endTime);

        FinancePageUtil<PmShopPayTotal> pageUtil = (FinancePageUtil<PmShopPayTotal>)page;
        pageUtil.copyList();

        model.addAttribute("page",pageUtil);
        model.addAttribute("timeRange",timeRange);
        model.addAttribute("quickTime",quickTime);

        return "modules/shopping/statement/payTotalViewList";

    }


    /**
     * 分页查询订单
     * @param request
     * @param response
     * @param model
     * @param timeRange
     * @param quickTime
     * @param shopIds
     * @param shopNames
     * @return
     */
    @RequiresPermissions("merchandise:financial:view")
    @RequestMapping(value = "getOrderPage")
    public String getOrderPage(HttpServletRequest request , HttpServletResponse response , Model model ,
                               String timeRange , Integer quickTime,Integer orderStatus,
                               String shopIds,String shopNames,String payCodes,String payRemarks){

        if(StringUtils.isBlank(timeRange)){
            quickTime=-1;
        }
        String[] strArr = getStartAndEndTime(quickTime, timeRange);
        timeRange = strArr[0];
        String startTime = strArr[1];
        String endTime = strArr[2];

        Page<EbOrder> page = ebOrderService.getPayOrderPage(new FinancePageUtil<EbOrder>(request,response),startTime,endTime,shopIds,payCodes,orderStatus);

        FinancePageUtil<EbOrder> pageUtil = (FinancePageUtil)page;
        pageUtil.copyList();
         if(CollectionUtils.isNotEmpty(pageUtil.getList())){
            for(EbOrder ebOrder : pageUtil.getList()){
                PmShopInfo pmShopInfo = pmShopInfoService.getById(ebOrder.getShopId());
                ebOrder.setPmShopInfo(pmShopInfo);

                PmOpenPayWay openPayWay = pmOpenPayWayService.getOpenPayWayByCode(ebOrder.getPayType());
                ebOrder.setPmOpenPayWay(openPayWay);

                Double platformRatio = ebOrder.getPlatformRatio() == null ? 0: ebOrder.getPlatformRatio();

//                String format = String.format("%.2f", ebOrder.getOrderRealAmount() * platformRatio / 100);
                //手续费
                ebOrder.setPoundage(DoubleUtil.getPoundage(ebOrder.getOrderRealAmount(),ebOrder.getPlatformRatio()));
                //可提现金额
                ebOrder.setExtractAmount(ebOrder.getOrderRealAmount()-ebOrder.getPoundage());
            }
        }

        if(StringUtils.isBlank(shopNames)){
            shopNames = pmShopInfoService.getNamesByIds(shopIds);
        }
        if(StringUtils.isBlank(payRemarks)){
            payRemarks = pmOpenPayWayService.getPayRemarkByCodes(payCodes);
        }

        model.addAttribute("orderStatus",orderStatus);
        model.addAttribute("page",pageUtil);
        model.addAttribute("timeRange",timeRange);
        model.addAttribute("quickTime",quickTime);
        model.addAttribute("shopIds",shopIds);
        model.addAttribute("payCodes",payCodes);
        model.addAttribute("shopNames",shopNames);
        model.addAttribute("payRemarks",payRemarks);
        return "modules/shopping/statement/orderList";

    }

    /**
     * 获取开始时间和结束时间
     * @param quickTime
     * @param timeRange
     * @return
     */
    public String[] getStartAndEndTime(Integer quickTime , String timeRange){
        String startTime = null;
        String endTime = null;
        if(quickTime == null){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }else{  //把快速时间（今天、昨天）改成范围时间
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cal  =  Calendar.getInstance();
            cal.add(Calendar.DATE,quickTime);
            Date time = cal.getTime();
            startTime = format.format(time)+" 00:00:00";

            if(quickTime==-1){
                endTime = format.format(time)+" 23:59:59";
            }else{
                endTime = format.format(new Date())+" 23:59:59";
            }
            timeRange=startTime+" - "+endTime;
        }

        return new String[]{timeRange,startTime,endTime};
    }
    /**
     * 导出交班记录
     * @param syllable
     * @param request
     * @param response
     * @param pmShopUser
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "handoverExsel")
    public String exsel(String[] syllable,HttpServletRequest request, HttpServletResponse response , PmShopUser pmShopUser) {
        String url = "";
        if (syllable != null && syllable.length > 0) {
            int t = 1;
            int pageNo = 1;
            int rowNum = 1;
            int rowNums = 100;
            HSSFWorkbook wb = new HSSFWorkbook();
            HSSFSheet sheet = wb.createSheet("交班统计");
            HSSFRow row = sheet.createRow((int) 0);
            HSSFCellStyle style = wb.createCellStyle();
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
            HSSFCell cell = row.createCell((short) 0);
            cell.setCellValue("序号");
            cell.setCellStyle(style);

            for (int i = 0; i < syllable.length; i++) {
                cell = row.createCell((short) i);
                if (syllable[i].equals("1")) {
                    cell.setCellValue("开始时间");
                }
                if (syllable[i].equals("2")) {
                    cell.setCellValue("结束时间");
                }
                if (syllable[i].equals("3")) {
                    cell.setCellValue("收银员姓名");
                }
                if (syllable[i].equals("4")) {
                    cell.setCellValue("收银员编号");
                }
                if (syllable[i].equals("5")) {
                    cell.setCellValue("销售总额");
                }
                if (syllable[i].equals("6")) {
                    cell.setCellValue("现金支付");
                }
                if (syllable[i].equals("7")) {
                    cell.setCellValue("微信支付");
                }
                if (syllable[i].equals("8")) {
                    cell.setCellValue("支付宝");
                }
                if (syllable[i].equals("9")) {
                    cell.setCellValue("余额");
                }
                if (syllable[i].equals("10")) {
                    cell.setCellValue("实收金额");
                }

                cell.setCellStyle(style);
            }


            while (t == 1) {
                Page<PmShopUserStatistics> page = pmShopUserStatisticsService.getListByPmShopUser(pmShopUser, new Page<PmShopUserStatistics>(pageNo, rowNums));
//                Page<EbUser> page = ebUserService.getPageList(new Page<EbUser>(
//                        pageNo, rowNums), ebUser, user);
                List<PmShopUserStatistics> pmShopUserStatisticsList = new ArrayList();
                pmShopUserStatisticsList = page.getList();
                if ((page.getCount() == rowNums && pageNo > 1) || (page.getCount() / rowNums) < 1 && pageNo > 1) {
                    pmShopUserStatisticsList = null;
                }
                if (pmShopUserStatisticsList != null && pmShopUserStatisticsList.size() > 0) {
                    for (PmShopUserStatistics psus : pmShopUserStatisticsList) {
                        //查询门店员工信息
                        Integer shopUserId = psus.getShopUserId();
                        PmShopUser user = pmShopUserService.getUser(shopUserId);

                        //查询来源表
                        List<PmShopUserSourceStatistics> sourceList = pmShopUserSourceStatisticsService.getOneByPmShopUserStatistics(psus);
                        try {
                            row = sheet.createRow((int) rowNum);
                            row.createCell((short) 0).setCellValue(rowNum);
                            for (int i = 0; i < syllable.length; i++) {
                                if (syllable[i].equals("1")) {
                                    row.createCell((short) i).setCellValue(psus.getLoginTime());
                                }
                                if (syllable[i].equals("2")) {
                                    row.createCell((short) i).setCellValue(psus.getLoginOutTime());
                                }
                                if (syllable[i].equals("3")) {
                                    String username=(user != null || user.getUsername() != null ?  user.getUsername() : "");
                                    row.createCell((short) i).setCellValue(username);
                                }
                                if (syllable[i].equals("4")) {
                                    String jobNumber=(user != null || user.getJobNumber() != null ?  user.getJobNumber() : "");
                                    row.createCell((short) i).setCellValue(jobNumber);
                                }
                                if (syllable[i].equals("5")) {
                                    row.createCell((short) i).setCellValue(psus.getTotalAmt());
                                }

                                if (syllable[i].equals("6")) {
                                    Double realAmout = 0D;
                                    for(PmShopUserSourceStatistics source : sourceList){
                                        if(source.getPayType() == 6){
                                            realAmout = source.getRealAmount();
                                            break;
                                        }
                                    }
                                    row.createCell((short) i).setCellValue(realAmout);
                                }
                                if (syllable[i].equals("7")) {
                                    Double realAmout = 0D;
                                    for(PmShopUserSourceStatistics source : sourceList){
                                        if(source.getPayType() == 5){
                                            realAmout = source.getRealAmount();
                                            break;
                                        }
                                    }
                                    row.createCell((short) i).setCellValue(realAmout);
                                }
                                if (syllable[i].equals("8")) {
                                    Double realAmout = 0D;
                                    for(PmShopUserSourceStatistics source : sourceList){
                                        if(source.getPayType() == 2){
                                            realAmout = source.getRealAmount();
                                            break;
                                        }
                                    }
                                    row.createCell((short) i).setCellValue(realAmout);
                                }
                                if (syllable[i].equals("9")) {
                                    Double realAmout = 0D;
                                    for(PmShopUserSourceStatistics source : sourceList){
                                        if(source.getPayType() == 7){
                                            realAmout = source.getRealAmount();
                                            break;
                                        }
                                    }
                                    row.createCell((short) i).setCellValue(realAmout);
                                }
                                if (syllable[i].equals("10")) {
                                    row.createCell((short) i).setCellValue(psus.getNetReceiptsAmt());
                                }
                            }
                        } catch (Exception e) {
                        }
                        rowNum++;
                    }
                    pageNo++;
                } else {
                    t = 2;
                }
            }
            String RootPath = request.getSession().getServletContext()
                    .getRealPath("/").replace("\\", "/");
            String path = "uploads/xlsfile/tempfile";
            Random r = new Random();
            String strfileName = DateUtil.getDateFormat(new Date(),
                    "yyyyMMddHHmmss") + r.nextInt();
            File f = new File(RootPath + path);
            // 不存在则创建它
            if (!f.exists())
                f.mkdirs();
            String tempPath = RootPath + path + "/" + strfileName + ".xls";
            try {
                FileOutputStream fout = new FileOutputStream(tempPath);
                wb.write(fout);
                fout.close();
                String domainurl = Global.getConfig("domainurl");
                url = domainurl + "/" + path + "/" + strfileName + ".xls";
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {

        }
        return url;
    }


    /**
     * 从交班来源中获得所有的支付方式
     * @param all
     * @return
     */
    public Collection<Object[]> getAllPay(List<List<PmShopUserSourceStatistics>> all){
        if(all == null){
            new ArrayList<Object[]>();
        }
        HashMap<Integer, Object[]> map = new HashMap<Integer, Object[]>();

        for(List<PmShopUserSourceStatistics> statisticsList : all){
            if(statisticsList == null){
                continue;
            }
            for(PmShopUserSourceStatistics statistics : statisticsList){
                if(statistics == null){
                    continue;
                }
                if(map.get(statistics.getPayType()) == null){   //当map中还没这种支付方式时，加入map
                    map.put(statistics.getPayType(),new Object[]{statistics.getPayType(), statistics.getPayName()});
                }
            }
        }

        return map.values();
    }


    /**
     * 导出营业汇总excel
     * @param request
     * @param response
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @param type  查询汇总的分类 1 日 2 月
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "statisticsExcel")
    public String statisticsExcel(HttpServletRequest request , HttpServletResponse response ,
                                 String timeRange , Integer quickTime,
                                 Integer type,Integer isAll,String[] syllable){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }

        Page<PmBusinessStatistics> page = null;
        List<PmBusinessStatistics> todayDateList = new ArrayList<PmBusinessStatistics>();
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&& DateUtil2.isInDate(timeRange," - "))) {
            if(isAll == 0) {    //不是汇总查询所有门店
                List<PmShopInfo> allShop = pmShopInfoService.getAllShop();
                if (CollectionUtils.isNotEmpty(allShop)) {
                    for (PmShopInfo pmShopInfo : allShop) {
                        List<PmBusinessStatistics> list = todayStamentService.oneDayStatistics(pmShopInfo.getId(), type);
                        todayDateList.addAll(list);
                    }
                }
            }else{  //汇总
                todayDateList = todayStamentService.oneDayStatistics(null, type);
            }
        }

        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessStatisticsService.getRangeListByDay(new Page<PmBusinessStatistics>(1, Integer.MAX_VALUE),  quickTime, startTime, endTime , isAll , null);
            }

        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)){
                page = pmBusinessStatisticsService.getRangeListByMonth(new Page<PmBusinessStatistics>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, isAll, null);
            }
        }

        page = getPage(todayDateList, page, new Page<PmBusinessStatistics>(1,Integer.MAX_VALUE));

        String title = type ==1 ? "营业日报":"营业月报";
        String url = new ExcelUtil().export(syllable, page.getList(), title, request);

        return url;
    }


    /**
     * 导入营业指标excel
     * @param request
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @param type  查询汇总的分类 1 日 2 月
     * @param isAll  是否为所有门店的汇总 0 不是  1是
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "indicatorExcel")
    public String indicatorExcel(HttpServletRequest request ,String[] syllable,String timeRange ,
                                 Integer quickTime,@RequestParam(defaultValue = "1") Integer type ,
                                 Integer orderType,Integer isAll){

        String startTime = "";
        String endTime = "";
        if(StringUtil.isNotBlank(timeRange)){
            startTime = timeRange.split(" - ")[0];
            endTime = timeRange.split(" - ")[1];
        }

        Page<PmBusinessIndicators> page = null;
        List<PmBusinessIndicators> todayDateList=new ArrayList<PmBusinessIndicators>();
        //不按照时间段查询，或者今天在时间范围内，才会去查询今天的数据
        if(StringUtils.isBlank(timeRange) || (StringUtils.isNotBlank(timeRange)&& DateUtil2.isInDate(timeRange," - "))) {
            if(isAll == 0) {    //不是汇总查询所有门店
                List<PmShopInfo> allShop = pmShopInfoService.getAllShop();
                if (CollectionUtils.isNotEmpty(allShop)) {
                    for (PmShopInfo pmShopInfo : allShop) {
                        List<PmBusinessIndicators> list = todayStamentService.oneDayIndicator(orderType,pmShopInfo.getId(), type);
                        todayDateList.addAll(list);
                    }
                }
            }else{  //汇总
                todayDateList = todayStamentService.oneDayIndicator(orderType,null, type);
            }
        }

        if(type == 1){
            if(!(quickTime!=null && quickTime == 1 && type==1)) {
                page = pmBusinessIndicatorsService.getRangeListByDay(new Page<PmBusinessIndicators>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, orderType, isAll, null);
            }
        }else{
            if(!(quickTime!=null && quickTime == 1 && type==1)) {
                page = pmBusinessIndicatorsService.getRangeListByMonth(new Page<PmBusinessIndicators>(1, Integer.MAX_VALUE), quickTime, startTime, endTime, orderType, isAll, null);
            }
        }

        page = getPage(todayDateList,page,new Page<PmBusinessIndicators>(1,Integer.MAX_VALUE));


        String title= type==1 ? "营业指标日报":"营业指标月报";
        String url = new ExcelUtil().export(syllable, page.getList(), title, request);

        return url;
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


    /**
     * 手动给page
     * @param todayDateList 今天的数据
     * @param oldPage   原来统计好的数据
     * @param oldPage   需要放入数据的新newPage
     * @param isAll 1 门店支付结算统计  2 支付结算统计（按天显示）
     * @return
     */
    public FinancePageUtil<PmShopPayTotal> getShopPayPage(List<PmShopPayTotal> todayDateList,FinancePageUtil<PmShopPayTotal> oldPage , FinancePageUtil<PmShopPayTotal> newPage,Integer isAll){
        List<PmShopPayTotal> list =  oldPage.getList();
        if(oldPage == null || CollectionUtils.isEmpty(oldPage.getList())){
            list = new ArrayList();
        }

        //门店支付结算统计
        if(isAll == 1){
            Map<Integer,PmShopPayTotal> map = new TreeMap<Integer, PmShopPayTotal>();

            //把当天的记录放入map
            if(CollectionUtils.isNotEmpty(todayDateList)){
                for(PmShopPayTotal total : todayDateList){
                    map.put(total.getShopId(),total);
                }
            }

            //把同一个门店的记录相加
            if(CollectionUtils.isNotEmpty(oldPage.getList())){
                for(PmShopPayTotal total : oldPage.getList()){
                    PmShopPayTotal result = map.get(total.getShopId());
                    if(result != null){
                        result.setAllAmount(DoubleUtil.add(result.getAllAmount(),total.getAllAmount()));
                        result.setRealAmount(DoubleUtil.add(result.getRealAmount(),total.getRealAmount()));
                        result.setPayAmount(DoubleUtil.add(result.getPayAmount(),total.getPayAmount()));
                        result.setPoundage(DoubleUtil.add(result.getPoundage(),total.getPoundage()));
                        result.setExtractAmout(DoubleUtil.add(result.getExtractAmout(),total.getExtractAmout()));
                        result.setNoExtractAmout(DoubleUtil.add(result.getNoExtractAmout(),total.getNoExtractAmout()));

                        Double realAmount1= result.getAllRealAmount()== null ? 0.0 : result.getAllRealAmount();
                        Double realAmount2= total.getAllRealAmount()== null ? 0.0 : total.getAllRealAmount();
                        result.setRealAmount(DoubleUtil.add(realAmount1,realAmount2));

                        Double refundAmount1= result.getAllRefundAmount()== null ? 0.0 : result.getAllRefundAmount();
                        Double refundAmount2= total.getAllRefundAmount()== null ? 0.0 : total.getAllRefundAmount();
                        result.setAllRefundAmount(DoubleUtil.add(refundAmount1,refundAmount2));

                        Double extractRefundAmount1= result.getExtractRefundAmount()== null ? 0.0 : result.getExtractRefundAmount();
                        Double extractRefundAmount2= total.getExtractRefundAmount()== null ? 0.0 : total.getExtractRefundAmount();
                        result.setExtractRefundAmount(DoubleUtil.add(extractRefundAmount1,extractRefundAmount2));

                        Double noExtractRealAmount1= result.getNoExtractRealAmount()== null ? 0.0 : result.getNoExtractRealAmount();
                        Double noExtractRealAmount2= total.getNoExtractRealAmount()== null ? 0.0 : total.getNoExtractRealAmount();
                        result.setNoExtractRealAmount(DoubleUtil.add(noExtractRealAmount1,noExtractRealAmount2));

                        Double noExtractRefundAmount1= result.getNoExtractRefundAmount()== null ? 0.0 : result.getNoExtractRefundAmount();
                        Double noExtractRefundAmount2= total.getNoExtractRefundAmount()== null ? 0.0 : total.getNoExtractRefundAmount();
                        result.setNoExtractRefundAmount(DoubleUtil.add(noExtractRefundAmount1,noExtractRefundAmount2));
                    }else{
                        map.put(total.getShopId(),total);
                    }
                }
            }
            list = new ArrayList<PmShopPayTotal>(map.values());
        }else{ //支付结算统计（按天显示）
            //把今天的数据直接放入总的列表中
            if(CollectionUtils.isNotEmpty(todayDateList)){
                list.addAll(0,todayDateList);
            }

        }


        Collection<PmShopPayTotal> resultList = new ArrayList<PmShopPayTotal>();

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


    /**
     * 导出收入
     * @param request
     * @param response
     * @param model
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "payTotalExcel")
    public String payTotalExcel(HttpServletRequest request , HttpServletResponse response , Model model ,
                               String timeRange , Integer quickTime,String[] syllable
                               ,String shopIds,Integer type,String shopNames){

        if(StringUtils.isBlank(timeRange)){
            quickTime=0;
        }
        String[] strArr = getStartAndEndTime(quickTime, timeRange);
        timeRange = strArr[0];
        String startTime = strArr[1];
        String endTime = strArr[2];

        Page<PmShopPayTotal> page = pmShopPayTotalService.getPage(new FinancePageUtil<PmShopPayTotal>(1,Integer.MAX_VALUE),startTime,endTime,shopIds);

        FinancePageUtil<PmShopPayTotal> pageUtil = (FinancePageUtil<PmShopPayTotal>)page;
        pageUtil.copyList();
        List<PmShopPayTotal> todayList = new ArrayList<PmShopPayTotal>();

        //包含今天，就查询今天的数据
        if(DateUtil2.isInDate(timeRange," - ")){
            todayList = pmShopPayTotalService.totalToday(shopIds);
        }

        pageUtil = getShopPayPage(todayList, pageUtil, new FinancePageUtil<PmShopPayTotal>(1, Integer.MAX_VALUE), type);
        String title = type==1?"门店支付统计":"支付结算统计";
        String url = new ExcelUtil().export(syllable, pageUtil.getList(), title, request);

        return url;
    }



    /**
     * 导出订单
     * @param request
     * @param response
     * @param model
     * @param timeRange
     * @param quickTime
     * @param shopIds
     * @param shopNames
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "orderExcel")
    public String orderExcel(HttpServletRequest request , HttpServletResponse response , Model model ,
                               String timeRange , Integer quickTime,Integer orderStatus,String[] syllable,
                               String shopIds,String shopNames,String payCodes,String payRemarks){

        if(StringUtils.isBlank(timeRange)){
            quickTime=0;
        }
        String[] strArr = getStartAndEndTime(quickTime, timeRange);
        timeRange = strArr[0];
        String startTime = strArr[1];
        String endTime = strArr[2];

        Page<EbOrder> page = ebOrderService.getPayOrderPage(new FinancePageUtil<EbOrder>(1,Integer.MAX_VALUE),startTime,endTime,shopIds,payCodes,orderStatus);
        FinancePageUtil<EbOrder> pageUtil = (FinancePageUtil<EbOrder>)page;
        pageUtil.copyList();
        List<OrderExcel> list = new ArrayList<OrderExcel>();

        String[] statusName = {"","等待买家付款","等待发货","已发货,待收货","已完成","已关闭","退款","确认执行中","订单异常"};
        if(CollectionUtils.isNotEmpty(pageUtil.getList())){
            for(EbOrder ebOrder : pageUtil.getList()){
                OrderExcel excel = new OrderExcel();
                excel.setPayTime(ebOrder.getPayTime());
                excel.setOrderNo(ebOrder.getOrderNo());
                excel.setShopName(ebOrder.getShopName());
                if(ebOrder.getStatus() != null && ebOrder.getStatus()<=8){
                    excel.setStatusName(statusName[ebOrder.getStatus()]);
                }else{
                    excel.setStatusName("");
                }

                excel.setPayAmount(ebOrder.getOrderRealAmount().toString());
                excel.setRealAmount(ebOrder.getOrderRealAmount().toString());
                Double platformRatio = ebOrder.getPlatformRatio() == null ? 0: ebOrder.getPlatformRatio();

//                String format = String.format("%.2f",ebOrder.getOrderRealAmount()*platformRatio/100);
                //手续费
                Double poundage = DoubleUtil.getPoundage(ebOrder.getOrderRealAmount(),ebOrder.getPlatformRatio());
                //手续费
                excel.setPoundage(poundage+"");
                //可提现金额
                excel.setNoExtractAmout(ebOrder.getOrderRealAmount().toString());
                excel.setExtractAmout((ebOrder.getOrderRealAmount()-poundage)+"");

                PmShopInfo pmShopInfo = pmShopInfoService.getById(ebOrder.getShopId());
                if(pmShopInfo != null){
                    excel.setShopCode(pmShopInfo.getShopCode());
                }
                PmOpenPayWay openPayWay = pmOpenPayWayService.getOpenPayWayByCode(ebOrder.getPayType());
                if(openPayWay != null){
                    excel.setPayChannel(openPayWay.getPayWayName());
                    String s = "";
                    if(openPayWay.getPayWayCode()==56){
                        if("ALIPAY".equals(ebOrder.getIsvScanType())){
                            s="（支付宝）";
                        }else if("WXPAY".equals(ebOrder.getIsvScanType())){
                            s="（微信）";
                        }else if("UNIONPAY".equals(ebOrder.getIsvScanType())){
                            s="（银联）";
                        }else if("JDPAY".equals(ebOrder.getIsvScanType())){
                            s="（京东钱包）";
                        }else if("QQPAY".equals(ebOrder.getIsvScanType())){
                            s="（QQ钱包）";
                        }
                    }
                    excel.setPayTypeName(openPayWay.getPayRemark()+s);
                }
                EbOrderSaleSource byCode = ebOrderSaleSourceService.getByCode(Integer.valueOf(ebOrder.getSaleSource()));
                if(byCode != null){
                    excel.setSourceName(byCode.getName());
                }


                if(ebOrder.getPayType() == 6 || (ebOrder.getPayType()>=60 && ebOrder.getPayType()<=70)){
                    excel.setPayAmount("--");
                    excel.setRealAmount("--");
                    excel.setPoundage("--");
                    excel.setExtractAmout("--");
                }else{
                    excel.setNoExtractAmout("--");
                }

                list.add(excel);
            }
        }

        String url = new ExcelUtil().export(syllable, list, "订单支付明细", request);

        return url;
    }


    /**
     * 导出
     * @param request
     * @param response
     * @param model
     * @param timeRange 时间范围
     * @param quickTime 快捷时间，如昨天为1
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "excelPayTotalView")
    public String excelPayTotalView(HttpServletRequest request , HttpServletResponse response , Model model ,
                                   String timeRange , Integer quickTime,String[] syllable){

        if(StringUtils.isBlank(timeRange)){
            quickTime=-1;
        }
        String[] strArr = getStartAndEndTime(quickTime, timeRange);
        timeRange = strArr[0];
        String startTime = strArr[1];
        String endTime = strArr[2];

        Page<PmShopPayTotal> page = pmShopPayTotaViewlService.getPage(new FinancePageUtil<PmShopPayTotal>(request,response),startTime,endTime);

        FinancePageUtil<PmShopPayTotal> pageUtil = (FinancePageUtil<PmShopPayTotal>)page;
        pageUtil.copyList();

        String url = new ExcelUtil().export(syllable, pageUtil.getList(), "平台支付统计", request);

        return url;

    }
}
