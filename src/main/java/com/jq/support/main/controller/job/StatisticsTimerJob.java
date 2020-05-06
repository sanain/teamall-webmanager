package com.jq.support.main.controller.job;

import com.alipay.api.domain.ShopInfo;
import com.jq.support.dao.merchandise.shop.PmShopPayTotalDao;
import com.jq.support.model.merchandise.utilentity.StandardDetail;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.shop.*;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.order.EbOrderitemService;
import com.jq.support.service.merchandise.product.EbProductChargingService;
import com.jq.support.service.merchandise.shop.*;
import com.jq.support.service.pay.ecopay.mobilepay.StringUtils;
import com.jq.support.service.utils.DoubleUtil;
import com.jq.support.service.utils.StringUtil;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CachePut;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 *报表定时任务
 *
 */
@Controller
public class StatisticsTimerJob {
    @Autowired
    private PmBusinessStatisticsService pmBusinessStatisticsService;
    @Autowired
    private EbOrderService ebOrderService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
    private PmBusinessDailyService pmBusinessDailyService;
    @Autowired
    private PmBusinessDailyItemService pmBusinessDailyItemService;
    @Autowired
    private PmBusinessDailyRankingService pmBusinessDailyRankingService;
    @Autowired
    private  PmBusinessDailyItemPayService pmBusinessDailyItemPayService;
    @Autowired
    private PmProductTasteRankingService pmProductTasteRankingService;
    @Autowired
    private EbOrderitemService ebOrderitemService;
    @Autowired
    private EbProductChargingService ebProductChargingService;
    @Autowired
    private PmProductTasteService pmProductTasteService;
    @Autowired
    private PmBusinessIndicatorsService pmBusinessIndicatorsService;
    @Autowired
    private PmShopUserService pmShopUserService;
    @Autowired
    private PmShopPayTotalService pmShopPayTotalService;

    /**
     * 统计每日营业汇总(所有门店)
     */
    public void oneDayStatistics(){

        PmBusinessStatistics statistics = new PmBusinessStatistics();

        //查询门店订单  ,  0 应付  1实付  2 订单总数
        List storeOrderList = ebOrderService.totalStoreOrder(1,null,1 ,null);

        Object[] arr1 = (Object[]) storeOrderList.get(0);
        statistics.setStorePayableAmount((Double) (arr1[0] == null ? 0D : arr1[0]));
        statistics.setStoreRealAmount((Double) (arr1[1] == null ? 0D : arr1[1]));
        statistics.setStoreOrderTotal(Integer.parseInt(arr1[2] == null ? "0" : arr1[2].toString()));

        //查询自提订单  ,  0 应付  1实付  2 订单总数
        List selfOrderList = ebOrderService.totalSelfOrder(1,null,1 ,null);

        Object[] arr2 = (Object[]) selfOrderList.get(0);
        statistics.setSelfPayableAmount((Double) (arr2[0] == null ? 0D : arr2[0]));
        statistics.setSelfRealAmount((Double)(arr2[1] == null ? 0D : arr2[1]));
        statistics.setSelfOrderTotal(Integer.parseInt(arr2[2] == null ? "0" : arr2[2].toString()));

        //查询外卖订单  ,  0 应付  1实付  2 订单总数
        List onlineOrderList = ebOrderService.totalOnlineOrder(1,null,1 ,null);

        Object[] arr3 = (Object[]) onlineOrderList.get(0);
        statistics.setOnlinePayableAmount((Double) (arr3[0] == null ? 0D : arr3[0]));
        statistics.setOnlineRealAmount((Double) (arr3[1] == null ? 0D : arr3[1]));
        statistics.setOnlineOrderTotal(Integer.parseInt(arr3[2] == null ? "0" : arr3[2].toString()));

        //查询会员充值金额
        List memberTopupList = ebOrderService.totalMemberTopup(1,null,1 ,null);
        Object o =  memberTopupList.get(0);
        statistics.setMemberTopup((Double)(o == null ? 0D : o));

        //统计总单数，总应付，总实付
        Integer orderTotal = statistics.getSelfOrderTotal()+statistics.getStoreOrderTotal()+
                statistics.getOnlineOrderTotal();
        Double realTotal = statistics.getOnlineRealAmount()+ statistics.getSelfRealAmount()+
                statistics.getStoreRealAmount();
        Double payableTotal = statistics.getOnlinePayableAmount()+ statistics.getSelfPayableAmount()+
                statistics.getStorePayableAmount();

        statistics.setAllOrderTotal(orderTotal);
        statistics.setAllRealAmount(realTotal);
        statistics.setAllPayableAmount(payableTotal);
        //获得昨天的日期
        Calendar cal  =  Calendar.getInstance();
        cal.add(Calendar.DATE,   -1);
        statistics.setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
        statistics.setCreateTime(new Date());
        statistics.setType(1);
        statistics.setIsAll(1);

        pmBusinessStatisticsService.insert(statistics);

        System.out.println("/////////////////////////////////////////////////////");
    }


    /**
     * 统计每月营业汇总（所有门店）
     */
    @Transactional(readOnly = false)
    public void oneMonthStatistics(){

        PmBusinessStatistics statistics = new PmBusinessStatistics();

        //查询门店订单  ,  0 应付  1实付  2 订单总数
        List storeOrderList = ebOrderService.totalStoreOrder(2,null,1 ,null);

        Object[] arr1 = (Object[]) storeOrderList.get(0);
        statistics.setStorePayableAmount((Double) (arr1[0] == null ? 0D : arr1[0]));
        statistics.setStoreRealAmount((Double) (arr1[1] == null ? 0D : arr1[1]));
        statistics.setStoreOrderTotal(Integer.parseInt(arr1[2] == null ? "0" : arr1[2].toString()));


        //查询自提订单  ,  0 应付  1实付  2 订单总数
        List selfOrderList = ebOrderService.totalSelfOrder(2,null,1 ,null);

        Object[] arr2 = (Object[]) selfOrderList.get(0);
        statistics.setSelfPayableAmount((Double) (arr2[0] == null ? 0D : arr2[0]));
        statistics.setSelfRealAmount((Double)(arr2[1] == null ? 0D : arr2[1]));
        statistics.setSelfOrderTotal(Integer.parseInt(arr2[2] == null ? "0" : arr2[2].toString()));


        //查询外卖订单  ,  0 应付  1实付  2 订单总数
        List onlineOrderList = ebOrderService.totalOnlineOrder(2,null,1 ,null);

        Object[] arr3 = (Object[]) onlineOrderList.get(0);
        statistics.setOnlinePayableAmount((Double) (arr3[0] == null ? 0D : arr3[0]));
        statistics.setOnlineRealAmount((Double) (arr3[1] == null ? 0D : arr3[1]));
        statistics.setOnlineOrderTotal(Integer.parseInt(arr3[2] == null ? "0" : arr3[2].toString()));


        //查询会员充值金额
        List memberTopupList = ebOrderService.totalMemberTopup(2,null,1 ,null);

        Object o =  memberTopupList.get(0);
        statistics.setMemberTopup((Double)(o == null ? 0D : o));

        //统计总单数，总应付，总实付
        Integer orderTotal = statistics.getSelfOrderTotal()+statistics.getStoreOrderTotal()+
                statistics.getOnlineOrderTotal();
        Double realTotal = statistics.getOnlineRealAmount()+ statistics.getSelfRealAmount()+
                statistics.getStoreRealAmount();
        Double payableTotal = statistics.getOnlinePayableAmount()+ statistics.getSelfPayableAmount()+
                statistics.getStorePayableAmount();


        statistics.setAllOrderTotal(orderTotal);
        statistics.setAllRealAmount(realTotal);
        statistics.setAllPayableAmount(payableTotal);
        statistics.setCreateTime(new Date());

        //获得昨天的日期
        Calendar cal  =  Calendar.getInstance();
        cal.add(Calendar.DATE,   -1);
        statistics.setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
        statistics.setType(2);
        statistics.setIsAll(1);

        pmBusinessStatisticsService.insert(statistics);

        System.out.println("/////////////////////////////////////////////////////");
    }


    /**
     * 统计每日营业汇总(以门店为单位)
     */
    public void oneDayStatisticsByShop(){

        List<PmShopInfo> allShop = pmShopInfoService.getAllShop();
        if(allShop == null || allShop.size() == 0){
            return;
        }

        for(PmShopInfo pmShopInfo : allShop){
            if(pmShopInfo == null){
                continue;
            }

            PmBusinessStatistics statistics = new PmBusinessStatistics();

            //查询门店订单  ,  0 应付  1实付  2 订单总数
            List storeOrderList = ebOrderService.totalStoreOrder(1,null,0 ,pmShopInfo.getId()+"");

            Object[] arr1 = (Object[]) storeOrderList.get(0);
            statistics.setStorePayableAmount((Double) (arr1[0] == null ? 0.0 : arr1[0]));
            statistics.setStoreRealAmount((Double) (arr1[1] == null ? 0.0 : arr1[1]));
            statistics.setStoreOrderTotal(Integer.parseInt(arr1[2] == null ? "0" : arr1[2].toString()));

            //查询自提订单  ,  0 应付  1实付  2 订单总数
            List selfOrderList = ebOrderService.totalSelfOrder(1,null,0 ,pmShopInfo.getId()+"");

            Object[] arr2 = (Object[]) selfOrderList.get(0);
            statistics.setSelfPayableAmount((Double) (arr2[0] == null ? 0.0 : arr2[0]));
            statistics.setSelfRealAmount((Double)(arr2[1] == null ? 0.0 : arr2[1]));
            statistics.setSelfOrderTotal(Integer.parseInt(arr2[2] == null ? "0" : arr2[2].toString()));

            //查询外卖订单  ,  0 应付  1实付  2 订单总数
            List onlineOrderList = ebOrderService.totalOnlineOrder(1,null,0 ,pmShopInfo.getId()+"");

            Object[] arr3 = (Object[]) onlineOrderList.get(0);
            statistics.setOnlinePayableAmount((Double) (arr3[0] == null ? 0.0 : arr3[0]));
            statistics.setOnlineRealAmount((Double) (arr3[1] == null ? 0.0 : arr3[1]));
            statistics.setOnlineOrderTotal(Integer.parseInt(arr3[2] == null ? "0" : arr3[2].toString()));

            //查询会员充值金额
            List memberTopupList = ebOrderService.totalMemberTopup(1,null,0 ,pmShopInfo.getId()+"");
            Object o =  memberTopupList.get(0);
            statistics.setMemberTopup((Double)(o == null ? 0.0 : o));

            //统计总单数，总应付，总实付
            Integer orderTotal = statistics.getSelfOrderTotal()+statistics.getStoreOrderTotal()+
                    statistics.getOnlineOrderTotal();
            Double realTotal = statistics.getOnlineRealAmount()+ statistics.getSelfRealAmount()+
                    statistics.getStoreRealAmount();
            Double payableTotal = statistics.getOnlinePayableAmount()+ statistics.getSelfPayableAmount()+
                    statistics.getStorePayableAmount();

            statistics.setAllOrderTotal(orderTotal);
            statistics.setAllRealAmount(realTotal);
            statistics.setAllPayableAmount(payableTotal);
            //获得昨天的日期
            Calendar cal  =  Calendar.getInstance();
            cal.add(Calendar.DATE,   -1);
            statistics.setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
            statistics.setCreateTime(new Date());
            statistics.setType(1);
            statistics.setIsAll(0);
            statistics.setShopId(pmShopInfo.getId());
            statistics.setShopName(pmShopInfo.getShopName());

            pmBusinessStatisticsService.insert(statistics);
        }
        System.out.println("/////////////////////////////////////////////////////");
    }


    /**
     * 统计每月营业汇总（以门店为单位）
     */
    @Transactional(readOnly = false)
    public void oneMonthStatisticsByShop(){
        List<PmShopInfo> allShop = pmShopInfoService.getAllShop();
        if(allShop == null || allShop.size() == 0){
            return;
        }
        for(PmShopInfo pmShopInfo : allShop) {
            if (pmShopInfo == null) {
                continue;
            }
            PmBusinessStatistics statistics = new PmBusinessStatistics();

            //查询门店订单  ,  0 应付  1实付  2 订单总数
            List storeOrderList = ebOrderService.totalStoreOrder(2, null,0, pmShopInfo.getId()+"");

            Object[] arr1 = (Object[]) storeOrderList.get(0);
            statistics.setStorePayableAmount((Double) (arr1[0] == null ? 0D : arr1[0]));
            statistics.setStoreRealAmount((Double) (arr1[1] == null ? 0D : arr1[1]));
            statistics.setStoreOrderTotal(Integer.parseInt(arr1[2] == null ? "0" : arr1[2].toString()));


            //查询自提订单  ,  0 应付  1实付  2 订单总数
            List selfOrderList = ebOrderService.totalSelfOrder(2, null,0, pmShopInfo.getId()+"");

            Object[] arr2 = (Object[]) selfOrderList.get(0);
            statistics.setSelfPayableAmount((Double) (arr2[0] == null ? 0D : arr2[0]));
            statistics.setSelfRealAmount((Double) (arr2[1] == null ? 0D : arr2[1]));
            statistics.setSelfOrderTotal(Integer.parseInt(arr2[2] == null ? "0" : arr2[2].toString()));


            //查询外卖订单  ,  0 应付  1实付  2 订单总数
            List onlineOrderList = ebOrderService.totalOnlineOrder(2, null,0, pmShopInfo.getId()+"");

            Object[] arr3 = (Object[]) onlineOrderList.get(0);
            statistics.setOnlinePayableAmount((Double) (arr3[0] == null ? 0D : arr3[0]));
            statistics.setOnlineRealAmount((Double) (arr3[1] == null ? 0D : arr3[1]));
            statistics.setOnlineOrderTotal(Integer.parseInt(arr3[2] == null ? "0" : arr3[2].toString()));


            //查询会员充值金额
            List memberTopupList = ebOrderService.totalMemberTopup(2, null,1, pmShopInfo.getId()+"");

            Object o = memberTopupList.get(0);
            statistics.setMemberTopup((Double) (o == null ? 0D : o));

            //统计总单数，总应付，总实付
            Integer orderTotal = statistics.getSelfOrderTotal() + statistics.getStoreOrderTotal() +
                    statistics.getOnlineOrderTotal();
            Double realTotal = statistics.getOnlineRealAmount() + statistics.getSelfRealAmount() +
                    statistics.getStoreRealAmount();
            Double payableTotal = statistics.getOnlinePayableAmount() + statistics.getSelfPayableAmount() +
                    statistics.getStorePayableAmount();


            statistics.setAllOrderTotal(orderTotal);
            statistics.setAllRealAmount(realTotal);
            statistics.setAllPayableAmount(payableTotal);
            statistics.setCreateTime(new Date());

            //获得昨天的日期
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DATE, -1);
            statistics.setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
            statistics.setType(2);
            statistics.setIsAll(0);
            statistics.setShopId(pmShopInfo.getId());
            statistics.setShopName(pmShopInfo.getShopName());

            pmBusinessStatisticsService.insert(statistics);
        }

        System.out.println("/////////////////////////////////////////////////////");
    }


    /**
     * 统计营业日报(所有门店)
     */
    public void totalBusinessDailyByAll(){
        totalBusinessDaily(1,null,null,1);
    }


    /**
     * 统计营业日报（以门店为单位）
     */
    public void totalBusinessDailyByShop(){
        List<PmShopInfo> allShop = pmShopInfoService.getAllShop();

        if(CollectionUtils.isNotEmpty(allShop)){
            for(PmShopInfo pmShopInfo : allShop){
                totalBusinessDaily(0,pmShopInfo.getId(),pmShopInfo.getShopName(),1);
            }
        }

    }


    /**
     * 统计营业日报
     * @param isAll     是否是汇总
     * @param shopId    门店id
     * @param shopName  门店名称
     * @param dataDiff  当前日期和统计日期相差的天数
     */
    public void totalBusinessDaily( Integer isAll , Integer shopId ,String shopName ,  Integer dataDiff){

        PmBusinessDaily pmBusinessDaily = new PmBusinessDaily();
        String shopIdStr = shopId == null ? null : String.valueOf(shopId);

        //统计营业日报明细
        PmBusinessDailyItem item1 = ebOrderService.totalBusinessDailyItem(1,isAll,shopIdStr,dataDiff);
        PmBusinessDailyItem item2 = ebOrderService.totalBusinessDailyItem(2,isAll,shopIdStr,dataDiff);
        PmBusinessDailyItem item3 = ebOrderService.totalBusinessDailyItem(3,isAll,shopIdStr,dataDiff);

        pmBusinessDaily.setCertificateAmount(item1.getCertificateAmount()+item2.getCertificateAmount()
                +item3.getCertificateAmount());
        pmBusinessDaily.setOrderAmount(item1.getOrderAmount()+item2.getOrderAmount()+
                item3.getOrderAmount());
        pmBusinessDaily.setPayableAmount(item1.getPayableAmount()+item2.getPayableAmount()+
                item3.getPayableAmount());
        pmBusinessDaily.setRealAmount(item1.getRealAmount()+item2.getRealAmount()+
                item3.getRealAmount());

        //获得昨天的日期
        Calendar cal  =  Calendar.getInstance();
        cal.add(Calendar.DATE,   -1);
        pmBusinessDaily.setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
        pmBusinessDaily.setCreateTime(new Date());
        pmBusinessDaily.setIsAll(isAll);
        pmBusinessDaily.setShopId(shopId);
        pmBusinessDaily.setShopName(shopName);
//            pmBusinessDaily.setMeasuringType(measuringType);
        //插入主表
        pmBusinessDailyService.inser(pmBusinessDaily);

        item1.setBusinessDailyId(pmBusinessDaily.getId());
        item2.setBusinessDailyId(pmBusinessDaily.getId());
        item3.setBusinessDailyId(pmBusinessDaily.getId());

        //插入来源表
        pmBusinessDailyItemService.inser(item1);
        pmBusinessDailyItemService.inser(item2);
        pmBusinessDailyItemService.inser(item3);

        List<PmBusinessDailyItemPay> payList1 = ebOrderService.totalBusinessDailyItemPay(1, item1.getId(),isAll,shopIdStr,dataDiff);
        List<PmBusinessDailyItemPay> payList2 = ebOrderService.totalBusinessDailyItemPay(2, item2.getId(),isAll,shopIdStr,dataDiff);
        List<PmBusinessDailyItemPay> payList3 = ebOrderService.totalBusinessDailyItemPay(3, item3.getId(),isAll,shopIdStr,dataDiff);

        //插入来源的实收构成
        pmBusinessDailyItemPayService.batchInser(payList1);
        pmBusinessDailyItemPayService.batchInser(payList2);
        pmBusinessDailyItemPayService.batchInser(payList3);


        List<PmBusinessDailyRanking> rankList1 = ebOrderService.totalDailyRanking(1,item1.getId(),isAll,shopIdStr,dataDiff,1);
        List<PmBusinessDailyRanking> rankList2 = ebOrderService.totalDailyRanking(2,item2.getId(),isAll,shopIdStr,dataDiff,1);
        List<PmBusinessDailyRanking> rankList3 = ebOrderService.totalDailyRanking(3,item3.getId(),isAll,shopIdStr,dataDiff,1);

        //重量的排行
        List<PmBusinessDailyRanking> weightRankList1 = ebOrderService.totalDailyRanking(1,item1.getId(),isAll,shopIdStr,dataDiff,2);
        List<PmBusinessDailyRanking> weightRankList2 = ebOrderService.totalDailyRanking(2,item2.getId(),isAll,shopIdStr,dataDiff,2);
        List<PmBusinessDailyRanking> weightRankList3 = ebOrderService.totalDailyRanking(3,item3.getId(),isAll,shopIdStr,dataDiff,2);

        //批量插入排行表记录
        pmBusinessDailyRankingService.batchInser(rankList1);
        pmBusinessDailyRankingService.batchInser(rankList2);
        pmBusinessDailyRankingService.batchInser(rankList3);
        pmBusinessDailyRankingService.batchInser(weightRankList1);
        pmBusinessDailyRankingService.batchInser(weightRankList2);
        pmBusinessDailyRankingService.batchInser(weightRankList3);

        System.out.println("////////////////////////营业日报//////////////////////////");
    }


    /**
     * 统计菜单营业分析(汇总)
     */
    public void totalProductTasteByAll(){
        PmProductTaste pmProductTaste = totalProductTaste(1, null, null, 1);

        //单规格排行
        totalProductRanking(pmProductTaste.getId(),1,null,null,1,1);
        //多规格排行
        totalProductRanking(pmProductTaste.getId(),1,null, null,2,1);
        //斩料排行
        totalProductRanking(pmProductTaste.getId(),1,null,null,3,1);
    }


    /**
     * 统计菜单营业分析(以门店为单位)
     */
    public void totalProductTasteByShop(){
        List<PmShopInfo> allShop = pmShopInfoService.getAllShop();

        if(CollectionUtils.isNotEmpty(allShop)){
            for(PmShopInfo pmShopInfo : allShop){
                PmProductTaste pmProductTaste = totalProductTaste(0, pmShopInfo.getId(), pmShopInfo.getShopName(), 1);

                //单规格排行
                totalProductRanking(pmProductTaste.getId(),0, pmShopInfo.getId(),pmShopInfo.getShopName(),1,1);
                //多规格排行
                totalProductRanking(pmProductTaste.getId(),0, pmShopInfo.getId(), pmShopInfo.getShopName(),2,1);
                //斩料排行
                totalProductRanking(pmProductTaste.getId(),0, pmShopInfo.getId(),pmShopInfo.getShopName(),3,1);
            }
        }

    }

    /**
     * 统计菜品营业分析
     */
    public PmProductTaste totalProductTaste(Integer isAll , Integer shopId ,String shopName, Integer dateDiff){

        List list1 = ebOrderService.totalProductTaste(1,isAll,shopId,dateDiff,1);
        List list2 = ebOrderService.totalProductTaste(2,isAll,shopId,dateDiff,1);
        List list3 = ebOrderService.totalProductTaste(3,isAll,shopId,dateDiff,1);
        List weightList1 = ebOrderService.totalProductTaste(1,isAll,shopId,dateDiff,2);
        List weightList2 = ebOrderService.totalProductTaste(2,isAll,shopId,dateDiff,2);
        List weightList3 = ebOrderService.totalProductTaste(3,isAll,shopId,dateDiff,2);

        String shopIdStr = shopId==null ? null : String.valueOf(shopId);
        //初始化一个PmProductTaste对象
        PmProductTaste pmProductTaste = pmProductTasteService.initPmProductTaste(shopIdStr,shopName,isAll);

        //门店普通商品订单
        if(CollectionUtils.isNotEmpty(list1) && list1.get(0) != null){
            Object[] resultArr = (Object[]) list1.get(0);
            pmProductTaste.setStoreMoney((Double)(resultArr[0] == null ? 0D : resultArr[0]));
            pmProductTaste.setStoreSales(Integer.parseInt(resultArr[1]==null ? "0" : resultArr[1].toString()));
        }
        //门店斩料订单
        if(CollectionUtils.isNotEmpty(weightList1) && weightList1.get(0) != null){
            Object[] resultArr = (Object[]) weightList1.get(0);
            pmProductTaste.setWeightStoreMoney((Double)(resultArr[0] == null ? 0D : resultArr[0]));
            pmProductTaste.setWeightStoreSales(Integer.parseInt(resultArr[1]==null ? "0" : resultArr[1].toString()));
        }

        //自提普通商品订单
        if(CollectionUtils.isNotEmpty(list2) && list2.get(0) != null){
            Object[] resultArr = (Object[]) list2.get(0);
            pmProductTaste.setSelfMoney((Double)(resultArr[0] == null ? 0D : resultArr[0]));
            pmProductTaste.setSelfSales(Integer.parseInt(resultArr[1]==null ? "0" : resultArr[1].toString()));
        }

        //自提斩料订单
        if(CollectionUtils.isNotEmpty(weightList2) && weightList2.get(0) != null){
            Object[] resultArr = (Object[]) weightList2.get(0);
            pmProductTaste.setWeightSelfMoney((Double)(resultArr[0] == null ? 0D : resultArr[0]));
            pmProductTaste.setWeightSelfSales(Integer.parseInt(resultArr[1]==null ? "0" : resultArr[1].toString()));
        }

        //外卖普通商品订单
        if(CollectionUtils.isNotEmpty(list3) && list3.get(0) != null){
            Object[] resultArr = (Object[]) list3.get(0);
            pmProductTaste.setOnlineMoney((Double)(resultArr[0] == null ? 0D : resultArr[0]));
            pmProductTaste.setOnlineSales(Integer.parseInt(resultArr[1]==null ? "0" : resultArr[1].toString()));
        }
        //外卖普通商品订单
        if(CollectionUtils.isNotEmpty(weightList3)  && weightList3.get(0) != null){
            Object[] resultArr = (Object[]) weightList3.get(0);
            pmProductTaste.setWeightOnlineMoney((Double)(resultArr[0] == null ? 0D : resultArr[0]));
            pmProductTaste.setWeightOnlineSales(Integer.parseInt(resultArr[1]==null ? "0" : resultArr[1].toString()));
        }

        double moneyCount = pmProductTaste.getOnlineMoney()+ pmProductTaste.getSelfMoney()+pmProductTaste.getStoreMoney();
        int salesCount = pmProductTaste.getOnlineSales()+ pmProductTaste.getSelfSales()+pmProductTaste.getStoreSales();
        double weightMoneyCount = pmProductTaste.getWeightOnlineMoney()+ pmProductTaste.getWeightSelfMoney()+pmProductTaste.getWeightStoreMoney();
        int weightSalesCount = pmProductTaste.getWeightOnlineSales()+ pmProductTaste.getWeightSelfSales()+pmProductTaste.getWeightStoreSales();

        pmProductTaste.setMoneyCount(moneyCount);
        pmProductTaste.setSalesCount(salesCount);

        pmProductTaste.setWeightMoneyCount(weightMoneyCount);
        pmProductTaste.setWeightSalesCount(weightSalesCount);
        pmProductTaste.setStoreMoneyProportion(pmProductTaste.getStoreMoney() == 0 ? 0.0 : pmProductTaste.getStoreMoney()/moneyCount);

        pmProductTaste.setSelfMoneyProportion(pmProductTaste.getSelfMoney() == 0 ? 0.0 : pmProductTaste.getSelfMoney()/moneyCount);
        pmProductTaste.setOnlineMoneyProportion(pmProductTaste.getOnlineMoney() == 0 ? 0.0 : pmProductTaste.getOnlineMoney()/moneyCount);
        pmProductTaste.setStoreSalesProportion(pmProductTaste.getStoreSales() == 0 ? 0.0 : (double)pmProductTaste.getStoreSales()/(double)salesCount);
        pmProductTaste.setSelfSalesProportion(pmProductTaste.getSelfSales() == 0 ? 0.0 : (double)pmProductTaste.getSelfSales()/(double)salesCount);
        pmProductTaste.setOnlineSalesProportion(pmProductTaste.getOnlineSales() == 0 ? 0.0 : (double)pmProductTaste.getOnlineSales()/(double)salesCount);

        pmProductTaste.setWeightStoreMoneyProportion(pmProductTaste.getWeightStoreMoney() == 0 ? 0.0 : pmProductTaste.getWeightStoreMoney()/weightMoneyCount);
        pmProductTaste.setWeightSelfMoneyProportion(pmProductTaste.getWeightSelfMoney() == 0 ? 0.0 : pmProductTaste.getWeightSelfMoney()/weightMoneyCount);
        pmProductTaste.setWeightOnlineMoneyProportion(pmProductTaste.getWeightOnlineMoney() == 0 ? 0.0 : pmProductTaste.getWeightOnlineMoney()/weightMoneyCount);
        pmProductTaste.setWeightStoreSalesProportion(pmProductTaste.getWeightStoreSales() == 0 ? 0.0 : (double)pmProductTaste.getWeightStoreSales()/(double)weightSalesCount);
        pmProductTaste.setWeightSelfSalesProportion(pmProductTaste.getWeightSelfSales() == 0 ? 0.0 : (double)pmProductTaste.getWeightSelfSales()/(double)weightSalesCount);
        pmProductTaste.setWeightOnlineSalesProportion(pmProductTaste.getWeightOnlineSales() == 0 ? 0.0 : (double)pmProductTaste.getWeightOnlineSales()/(double)weightSalesCount);

        pmProductTaste.setIsAll(isAll);
        Calendar cal  =  Calendar.getInstance();
        cal.add(Calendar.DATE,   -1);
        pmProductTaste.setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
        pmProductTaste.setCreateTime(new Date());
        pmProductTaste.setShopName(shopName);
        pmProductTaste.setShopId(shopId);

        pmProductTasteService.insert(pmProductTaste);

        System.out.println("//////////////菜品分析总表////////////////////");

        return pmProductTaste;
    }


    /**
     * 商品口味排行表
     * @param productTasteId 商品口味排行表
     * @param isAll 是否是所有门店的汇总
     * @param shopId    门店id
     * @param shopName 门店名称
     * @param type 排行类型  1 以商品为单位  2以规格为单位  3斩料
     *
     */
    public void totalProductRanking(Integer productTasteId , Integer isAll , Integer shopId , String shopName,Integer type,Integer dateDiff){

        //统计不包括加料的门店订单  ,  0 应付 1 销售量 2商品id 3商品名字 4规格名称
        List storeOrderList = pmProductTasteRankingService.totalProductRanking(1,isAll,shopId,dateDiff,type);
        //统计不包括加料的自提订单  ,  0 应付 1 销售量 2商品id 3商品名字 4规格名称
        List selfOrderList = pmProductTasteRankingService.totalProductRanking(2,isAll,shopId,dateDiff,type);
        //统计不包括加料的外卖订单  ,  0 应付 1 销售量 2商品id 3商品名字 4规格名称
        List onlineOrderList = pmProductTasteRankingService.totalProductRanking(3,isAll,shopId,dateDiff,type);
        //把这三个集合中的商品id作为key放入map中
        Map<String , PmProductTasteRanking> map = getAllElement(storeOrderList,selfOrderList,onlineOrderList,type);

        //处理门店订单
        for(int i = 0 ; i < storeOrderList.size() ; i++){
            Object[] arr1 = (Object[]) storeOrderList.get(i);
            //只有type=2（包含加料）key中才包含规格
            if(type != 2){
                arr1[4] = "";
            }
            String standardName = arr1[4] == null ? "" : arr1[4].toString();
            PmProductTasteRanking ranking = map.get(arr1[2].toString()+standardName);

            ranking.setStoreRealAmount((Double) (arr1[0] == null ? 0D : arr1[0]));
            ranking.setStoreSales(Integer.parseInt(arr1[1] == null ? "0" : arr1[1].toString()));
            if(type != 2) {
                ranking.setProductAnalyze(arr1[3].toString());
            }else{
                String productAnalyze = arr1[3].toString();
                if(StringUtil.isNotBlank(standardName)){
                    productAnalyze+="[ "+standardName+" ]";
                }
                ranking.setProductAnalyze(productAnalyze);
            }
        }

        //处理自提订单
        for(int i = 0 ; i < selfOrderList.size() ; i++){
            Object[] arr2 = (Object[]) selfOrderList.get(i);
            //只有type=2（包含加料）key中才包含加料
            if(type != 2){
                arr2[4] = null;
            }

            String standardName = arr2[4] == null ? "" : arr2[4].toString();
            PmProductTasteRanking ranking = map.get(arr2[2].toString()+standardName);

            ranking.setSelfRealAmount((Double) (arr2[0] == null ? 0D : arr2[0]));
            ranking.setSelfSales(Integer.parseInt(arr2[1] == null ? "0" : arr2[1].toString()));
            if(type != 2) {
                ranking.setProductAnalyze(arr2[3].toString());
            }else{
                ranking.setProductAnalyze(arr2[3].toString()+"[ "+standardName+" ]");
            }
        }

        //处理外卖订单
        for(int i = 0 ; i < onlineOrderList.size() ; i++){
            Object[] arr3 = (Object[]) onlineOrderList.get(i);
            //只有type=2（包含加料）key中才包含加料
            if(type != 2){
                arr3[4] = null;
            }

            String standardName = arr3[4] == null ? "" : arr3[4].toString();
            PmProductTasteRanking ranking = map.get(arr3[2].toString()+standardName);

            ranking.setOnlineRealAmount((Double) (arr3[0] == null ? 0D : arr3[0]));
            ranking.setOnlineSales(Integer.parseInt(arr3[1] == null ? "0" : arr3[1].toString()));
            if(type != 2) {
                ranking.setProductAnalyze(arr3[3].toString());
            }else{
                ranking.setProductAnalyze(arr3[3].toString()+"[ "+standardName+" ]");
            }

        }

        Collection<PmProductTasteRanking> values = map.values();
        List<PmProductTasteRanking> list = new ArrayList(values);

        if(CollectionUtils.isEmpty(list)){
            return ;
        }

        for(PmProductTasteRanking ranking : list){
            double realAmountCount = ranking.getOnlineRealAmount()+ranking.getSelfRealAmount()+ranking.getStoreRealAmount();
            int salesCount = ranking.getOnlineSales()+ranking.getSelfSales()+ranking.getStoreSales();

            ranking.setSales(salesCount);
            ranking.setRealAmount(realAmountCount);
            ranking.setCreateTime(new Date());
            ranking.setType(type);
            ranking.setProductTasteId(productTasteId);
            //获得昨天的日期
            Calendar cal  =  Calendar.getInstance();
            cal.add(Calendar.DATE,   -1);
            ranking.setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
            ranking.setIsAll(isAll);
            ranking.setShopId(shopId);
            ranking.setShopName(shopName);
        }

        pmProductTasteRankingService.batchInsert(list);

        System.out.println("////////////////排行type="+type+"//////////////////");
    }


    /**
     * 把这三个集合中的商品id作为key放入map中
     * @param list1
     * @param list2
     * @param list3
     * @param type 1 单规格  2多规格  3斩料
     * @return
     */
    public Map<String,PmProductTasteRanking> getAllElement(List list1, List list2,List list3,Integer type){
        Map<String,PmProductTasteRanking> map = new HashMap<String, PmProductTasteRanking>();
        List allList = new ArrayList();
        allList.addAll(list1);
        allList.addAll(list2);
        allList.addAll(list3);

        if(CollectionUtils.isNotEmpty(allList)){
            for(Object o : allList){
                if(o == null){
                    continue;
                }

                PmProductTasteRanking ranking = new PmProductTasteRanking();
                ranking.setOnlineRealAmount(0D);
                ranking.setOnlineSales(0);
                ranking.setStoreSales(0);
                ranking.setStoreRealAmount(0D);
                ranking.setSelfRealAmount(0D);
                ranking.setSelfSales(0);

                Object[] arr = (Object[])o;
                if(type == 2){
                    String standardName = arr[4] == null ? "" : arr[4].toString();
                    map.put(arr[2].toString()+standardName,ranking);
                }else{
                    map.put(arr[2].toString(),ranking);
                }

            }
        }

        return map;
    }


    /**
     * 统计每日营业指标(所有门店)
     */
    @Transactional(readOnly = false)
    public void oneDayIndicator(){

        PmBusinessIndicators allIndicators = new PmBusinessIndicators();
        //0 总订单 1 门店订单  2  自提订单  3外卖订单
        PmBusinessIndicators[] indicatorsArr = {new PmBusinessIndicators(),new PmBusinessIndicators(),new PmBusinessIndicators(),new PmBusinessIndicators()};

        //循环查询门店订单 自提订单  外卖订单
        for(int i = 1 ; i <= 3 ; i++){
            List storeOrderList = ebOrderService.totalStoreIndicator(1 , i , 1 , null,null,"4");
            List storeRefundOrderList = ebOrderService.totalStoreIndicator(1 , i , 1 , null,null,"6");
            Object[] arr1 = (Object[]) storeOrderList.get(0);
            Object[] refundArr1 = (Object[]) storeRefundOrderList.get(0);

            double payable= (Double)(arr1[0] == null ? 0D : arr1[0]); //应收款
            double refundPayable= (Double)(refundArr1[0] == null ? 0D : refundArr1[0]);

            int count=Integer.parseInt(arr1[1] == null ? "0" : arr1[1].toString()); //订单数
            int refundCount=Integer.parseInt(refundArr1[1] == null ? "0" : refundArr1[1].toString());

            double certificate= (Double)(arr1[3] == null ? 0D : arr1[3]);//优惠金额
            double refundCertificate= (Double)(refundArr1[3] == null ? 0D : refundArr1[3]);

            double realAmount=(Double) (arr1[2] == null ? 0D : arr1[2]);//实收金额
            double refundAmount=(Double) (refundArr1[2] == null ? 0D : refundArr1[2]);//退款金额
            //手续费
            Double poundage=arr1[1] == null ? 0.0 : Double.parseDouble(arr1[4].toString())/100;
            double amt= realAmount-poundage;//优惠金额

            indicatorsArr[i].setRealAmount(realAmount);
            indicatorsArr[i].setOrderCount(refundCount+count);
            indicatorsArr[i].setPayableAmount(payable+refundPayable);
            indicatorsArr[i].setCertificateAmount(certificate+refundCertificate);
            indicatorsArr[i].setAmtAmount(amt);
            indicatorsArr[i].setPoundage(poundage);
            indicatorsArr[i].setRefundAmount(refundAmount);

            Integer employeesCount = pmShopUserService.getCount();
            indicatorsArr[i].setEmployees(employeesCount);
            indicatorsArr[i].setAveraging(indicatorsArr[i].getRealAmount() == 0 ? 0 : indicatorsArr[i].getRealAmount() / indicatorsArr[i].getOrderCount());

            //获得昨天的日期
            Calendar cal  =  Calendar.getInstance();
            cal.add(Calendar.DATE,   -1);
            indicatorsArr[i].setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
            indicatorsArr[i].setCreateTime(new Date());
            indicatorsArr[i].setType(1);
            indicatorsArr[i].setOrderType(i);
            indicatorsArr[i].setIsAll(1);
        }

        //统计总的订单数据
        Integer allOrderCount = 0;
        Double allRealAmount = 0.0;
        for(int i = 1 ; i <= 3 ; i++) {
            allRealAmount+=indicatorsArr[i].getRealAmount();
            allOrderCount+=indicatorsArr[i].getOrderCount();
        }

        indicatorsArr[0].setRealAmount(allRealAmount);
        indicatorsArr[0].setOrderCount(allOrderCount);

        Integer employeesCount = pmShopUserService.getCount();
        indicatorsArr[0].setEmployees(employeesCount);
        indicatorsArr[0].setAveraging(indicatorsArr[0].getRealAmount() == 0 ? 0 : indicatorsArr[0].getRealAmount() / indicatorsArr[0].getOrderCount());

        //获得昨天的日期
        Calendar cal  =  Calendar.getInstance();
        cal.add(Calendar.DATE,   -1);
        indicatorsArr[0].setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
        indicatorsArr[0].setCreateTime(new Date());
        indicatorsArr[0].setType(1);
        indicatorsArr[0].setOrderType(0);
        indicatorsArr[0].setIsAll(1);

        pmBusinessIndicatorsService.batchInsert(Arrays.asList(indicatorsArr));

        System.out.println("//////////////////////////////////////////");
    }


    /**
     * 统计每月营业指标（所有门店）
     */
    @Transactional(readOnly = false)
    public void oneMonthIndicator(){

        PmBusinessIndicators allIndicators = new PmBusinessIndicators();
        //0 总订单 1 门店订单  2  自提订单  3外卖订单
        PmBusinessIndicators[] indicatorsArr = {new PmBusinessIndicators(),new PmBusinessIndicators(),new PmBusinessIndicators(),new PmBusinessIndicators()};


        //循环查询门店订单 自提订单  外卖订单
        for(int i = 1 ; i <= 3 ; i++){
            List storeOrderList = ebOrderService.totalStoreIndicator(2 , i , 1 , null,null,"4");
            List storeRefundOrderList = ebOrderService.totalStoreIndicator(2 , i , 1 , null,null,"6");
            Object[] arr1 = (Object[]) storeOrderList.get(0);
            Object[] refundArr1 = (Object[]) storeRefundOrderList.get(0);

            double payable= (Double)(arr1[0] == null ? 0D : arr1[0]); //应收款
            double refundPayable= (Double)(refundArr1[0] == null ? 0D : refundArr1[0]);

            int count=Integer.parseInt(arr1[1] == null ? "0" : arr1[1].toString()); //订单数
            int refundCount=Integer.parseInt(refundArr1[1] == null ? "0" : refundArr1[1].toString());

            double certificate= (Double)(arr1[3] == null ? 0D : arr1[3]);//优惠金额
            double refundCertificate= (Double)(refundArr1[3] == null ? 0D : refundArr1[3]);

            double realAmount=(Double) (arr1[2] == null ? 0D : arr1[2]);//实收金额
            double refundAmount=(Double) (refundArr1[2] == null ? 0D : refundArr1[2]);//退款金额
            //手续费
            Double poundage=arr1[1] == null ? 0.0 : Double.parseDouble(arr1[4].toString())/100;
            double amt= realAmount-poundage;//优惠金额

            indicatorsArr[i].setRealAmount(realAmount);
            indicatorsArr[i].setOrderCount(refundCount+count);
            indicatorsArr[i].setPayableAmount(payable+refundPayable);
            indicatorsArr[i].setCertificateAmount(certificate+refundCertificate);
            indicatorsArr[i].setAmtAmount(amt);
            indicatorsArr[i].setPoundage(poundage);
            indicatorsArr[i].setRefundAmount(refundAmount);



            Integer employeesCount = pmShopUserService.getCount();
            indicatorsArr[i].setEmployees(employeesCount);
            indicatorsArr[i].setAveraging(indicatorsArr[i].getRealAmount() == 0 ? 0 : indicatorsArr[i].getRealAmount() / indicatorsArr[i].getOrderCount());

            //获得昨天的日期
            Calendar cal  =  Calendar.getInstance();
            cal.add(Calendar.DATE,   -1);
            indicatorsArr[i].setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
            indicatorsArr[i].setCreateTime(new Date());
            indicatorsArr[i].setType(2);
            indicatorsArr[i].setOrderType(i);
            indicatorsArr[i].setIsAll(1);
        }

        //统计总订单数据
        Integer allOrderCount = 0;
        Double allRealAmount = 0.0;
        for(int i = 1 ; i <= 3 ; i++) {
            allRealAmount+=indicatorsArr[i].getRealAmount();
            allOrderCount+=indicatorsArr[i].getOrderCount();
        }

        indicatorsArr[0].setRealAmount(allRealAmount);
        indicatorsArr[0].setOrderCount(allOrderCount);

        Integer employeesCount = pmShopUserService.getCount();
        indicatorsArr[0].setEmployees(employeesCount);
        indicatorsArr[0].setAveraging(indicatorsArr[0].getRealAmount() == 0 ? 0 : indicatorsArr[0].getRealAmount() / indicatorsArr[0].getOrderCount());

        //获得昨天的日期
        Calendar cal  =  Calendar.getInstance();
        cal.add(Calendar.DATE,   -1);
        indicatorsArr[0].setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
        indicatorsArr[0].setCreateTime(new Date());
        indicatorsArr[0].setType(2);
        indicatorsArr[0].setOrderType(0);
        indicatorsArr[0].setIsAll(1);

        pmBusinessIndicatorsService.batchInsert(Arrays.asList(indicatorsArr));

        System.out.println("//////////////////////////////////////////");
    }


    /**
     * 统计每日营业指标（以门店为单位）
     */
    @Transactional(readOnly = false)
    public void oneDayIndicatorByShop(){
        List<PmShopInfo> allShop = pmShopInfoService.getAllShop();
        for(PmShopInfo pmShopInfo : allShop) {
            if (pmShopInfo == null) {
                continue;
            }

            //0 总订单 1 门店订单  2  自提订单  3外卖订单
            PmBusinessIndicators[] indicatorsArr = {new PmBusinessIndicators(), new PmBusinessIndicators(), new PmBusinessIndicators(), new PmBusinessIndicators()};

            //循环查询门店订单 自提订单  外卖订单
            for (int i = 1; i <= 3; i++) {
                List storeOrderList = ebOrderService.totalStoreIndicator(1 , i , 0 , null,null,"4");
                List storeRefundOrderList = ebOrderService.totalStoreIndicator(1 , i , 0 , null,null,"6");
                Object[] arr1 = (Object[]) storeOrderList.get(0);
                Object[] refundArr1 = (Object[]) storeRefundOrderList.get(0);

                double payable= (Double)(arr1[0] == null ? 0D : arr1[0]); //应收款
                double refundPayable= (Double)(refundArr1[0] == null ? 0D : refundArr1[0]);

                int count=Integer.parseInt(arr1[1] == null ? "0" : arr1[1].toString()); //订单数
                int refundCount=Integer.parseInt(refundArr1[1] == null ? "0" : refundArr1[1].toString());

                double certificate= (Double)(arr1[3] == null ? 0D : arr1[3]);//优惠金额
                double refundCertificate= (Double)(refundArr1[3] == null ? 0D : refundArr1[3]);

                double realAmount=(Double) (arr1[2] == null ? 0D : arr1[2]);//实收金额
                double refundAmount=(Double) (refundArr1[2] == null ? 0D : refundArr1[2]);//退款金额
                //手续费
                Double poundage=arr1[1] == null ? 0.0 : Double.parseDouble(arr1[4].toString())/100;
                double amt= realAmount-poundage;//优惠金额

                indicatorsArr[i].setRealAmount(realAmount);
                indicatorsArr[i].setOrderCount(refundCount+count);
                indicatorsArr[i].setPayableAmount(payable+refundPayable);
                indicatorsArr[i].setCertificateAmount(certificate+refundCertificate);
                indicatorsArr[i].setAmtAmount(amt);
                indicatorsArr[i].setPoundage(poundage);
                indicatorsArr[i].setRefundAmount(refundAmount);

                Integer employeesCount = pmShopUserService.getUserCountByShopId(pmShopInfo.getId());
                indicatorsArr[i].setEmployees(employeesCount);
                indicatorsArr[i].setAveraging(indicatorsArr[i].getRealAmount() == 0 ? 0 : indicatorsArr[i].getRealAmount() / indicatorsArr[i].getOrderCount());

                //获得昨天的日期
                Calendar cal = Calendar.getInstance();
                cal.add(Calendar.DATE, -1);
                indicatorsArr[i].setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
                indicatorsArr[i].setCreateTime(new Date());
                indicatorsArr[i].setType(1);
                indicatorsArr[i].setOrderType(i);
                indicatorsArr[i].setIsAll(0);
                indicatorsArr[i].setShopId(pmShopInfo.getId());
                indicatorsArr[i].setShopName(pmShopInfo.getShopName());
            }


            //统计总的订单数据
            Integer allOrderCount = 0;
            Double allRealAmount = 0.0;
            for(int i = 1 ; i <= 3 ; i++) {
                allRealAmount+=indicatorsArr[i].getRealAmount();
                allOrderCount+=indicatorsArr[i].getOrderCount();
            }

            indicatorsArr[0].setRealAmount(allRealAmount);
            indicatorsArr[0].setOrderCount(allOrderCount);

            Integer employeesCount = pmShopUserService.getCountByShop(pmShopInfo.getId());
            indicatorsArr[0].setEmployees(employeesCount);
            indicatorsArr[0].setAveraging(indicatorsArr[0].getRealAmount() == 0 ? 0 : indicatorsArr[0].getRealAmount() / indicatorsArr[0].getOrderCount());

            //获得昨天的日期
            Calendar cal  =  Calendar.getInstance();
            cal.add(Calendar.DATE,   -1);
            indicatorsArr[0].setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
            indicatorsArr[0].setCreateTime(new Date());
            indicatorsArr[0].setType(1);
            indicatorsArr[0].setOrderType(0);
            indicatorsArr[0].setIsAll(0);
            indicatorsArr[0].setShopId(pmShopInfo.getId());
            indicatorsArr[0].setShopName(pmShopInfo.getShopName());

            pmBusinessIndicatorsService.batchInsert(Arrays.asList(indicatorsArr));
        }
        System.out.println("//////////////////////////////////////////");

    }


    /**
     * 统计每月营业指标（以门店为单位）
     */
    @Transactional(readOnly = false)
    public void oneMonthIndicatorByShop(){
        List<PmShopInfo> allShop = pmShopInfoService.getAllShop();

        for(PmShopInfo pmShopInfo : allShop) {
            if (pmShopInfo == null) {
                continue;
            }
            //0 总订单 1 门店订单  2  自提订单  3外卖订单
            PmBusinessIndicators[] indicatorsArr = {new PmBusinessIndicators(), new PmBusinessIndicators(), new PmBusinessIndicators(), new PmBusinessIndicators()};


            //循环查询门店订单 自提订单  外卖订单
            for (int i = 1; i <= 3; i++) {
                List storeOrderList = ebOrderService.totalStoreIndicator(2 , i , 0 , null,null,"4");
                List storeRefundOrderList = ebOrderService.totalStoreIndicator(2 , i , 0 , null,null,"6");
                Object[] arr1 = (Object[]) storeOrderList.get(0);
                Object[] refundArr1 = (Object[]) storeRefundOrderList.get(0);

                double payable= (Double)(arr1[0] == null ? 0D : arr1[0]); //应收款
                double refundPayable= (Double)(refundArr1[0] == null ? 0D : refundArr1[0]);

                int count=Integer.parseInt(arr1[1] == null ? "0" : arr1[1].toString()); //订单数
                int refundCount=Integer.parseInt(refundArr1[1] == null ? "0" : refundArr1[1].toString());

                double certificate= (Double)(arr1[3] == null ? 0D : arr1[3]);//优惠金额
                double refundCertificate= (Double)(refundArr1[3] == null ? 0D : refundArr1[3]);

                double realAmount=(Double) (arr1[2] == null ? 0D : arr1[2]);//实收金额
                double refundAmount=(Double) (refundArr1[2] == null ? 0D : refundArr1[2]);//退款金额
                //手续费
                Double poundage=arr1[1] == null ? 0.0 : Double.parseDouble(arr1[4].toString())/100;
                double amt= realAmount-poundage;//优惠金额

                indicatorsArr[i].setRealAmount(realAmount);
                indicatorsArr[i].setOrderCount(refundCount+count);
                indicatorsArr[i].setPayableAmount(payable+refundPayable);
                indicatorsArr[i].setCertificateAmount(certificate+refundCertificate);
                indicatorsArr[i].setAmtAmount(amt);
                indicatorsArr[i].setPoundage(poundage);
                indicatorsArr[i].setRefundAmount(refundAmount);


                Integer employeesCount = pmShopUserService.getUserCountByShopId(pmShopInfo.getId());
                indicatorsArr[i].setEmployees(employeesCount);
                indicatorsArr[i].setAveraging(indicatorsArr[i].getRealAmount() == 0 ? 0 : indicatorsArr[i].getRealAmount() / indicatorsArr[i].getOrderCount());

                //获得昨天的日期
                Calendar cal = Calendar.getInstance();
                cal.add(Calendar.DATE, -1);
                indicatorsArr[i].setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
                indicatorsArr[i].setCreateTime(new Date());
                indicatorsArr[i].setType(2);
                indicatorsArr[i].setOrderType(i);
                indicatorsArr[i].setIsAll(0);
                indicatorsArr[i].setShopId(pmShopInfo.getId());
                indicatorsArr[i].setShopName(pmShopInfo.getShopName());
            }

            //统计总订单数据
            Integer allOrderCount = 0;
            Double allRealAmount = 0.0;
            for (int i = 1; i <= 3; i++) {
                allRealAmount += indicatorsArr[i].getRealAmount();
                allOrderCount += indicatorsArr[i].getOrderCount();
            }

            indicatorsArr[0].setRealAmount(allRealAmount);
            indicatorsArr[0].setOrderCount(allOrderCount);

            Integer employeesCount = pmShopUserService.getCount();
            indicatorsArr[0].setEmployees(employeesCount);
            indicatorsArr[0].setAveraging(indicatorsArr[0].getRealAmount() == 0 ? 0 : indicatorsArr[0].getRealAmount() / indicatorsArr[0].getOrderCount());

            //获得昨天的日期
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DATE, -1);
            indicatorsArr[0].setTotalTime(cal.getTime()); //统计时间设置成昨天，因为是昨天的订单
            indicatorsArr[0].setCreateTime(new Date());
            indicatorsArr[0].setType(2);
            indicatorsArr[0].setOrderType(0);
            indicatorsArr[0].setIsAll(0);
            indicatorsArr[0].setShopId(pmShopInfo.getId());
            indicatorsArr[0].setShopName(pmShopInfo.getShopName());

            pmBusinessIndicatorsService.batchInsert(Arrays.asList(indicatorsArr));
        }

        System.out.println("//////////////////////////////////////////");
    }

    /**
     * 统计门店支付
     */
    @Transactional(readOnly = false)
    public void payTotal(){
        Integer step = -1;
        List<PmShopInfo> allShop = pmShopInfoService.getAllShop();

        for(PmShopInfo pmShopInfo : allShop) {
            if (pmShopInfo == null) {
                continue;
            }
            PmShopPayTotal payTotal = pmShopPayTotalService.init(pmShopInfo, step);
            pmShopPayTotalService.totalByDay(payTotal, step,1);//营业总额
            pmShopPayTotalService.totalByDay(payTotal, step,2);//退款金额
            //营业净额
            payTotal.setAllRealAmount(DoubleUtil.subtracting(payTotal.getAllAmount(),payTotal.getAllRefundAmount()));
//            if(pmShopInfo.getId()==22){
//                System.out.println("ooooo");
//            }

            //可提现金额
            Object[] arr1 = pmShopPayTotalService.totalExtractAmount(1, step, payTotal, 1);
            if(arr1 != null){
                //支付金额
                payTotal.setPayAmount(arr1[0] == null ? 0.0 : Double.parseDouble(arr1[0].toString()));
                //手续费
                Double poundage=arr1[1] == null ? 0.0 : Double.parseDouble(arr1[1].toString())/100;
                if(pmShopInfo.getId() == 95){
                    System.out.println("---");
                }
                //                poundage = DoubleUtil.getPoundage(payTotal.getPayAmount(),poundage);
                payTotal.setPoundage(poundage);
            }

            Object[] arr2 = pmShopPayTotalService.totalExtractAmount(1, step, payTotal, 2);
            if(arr2 != null){
                //可提现金额退款金额
                payTotal.setExtractRefundAmount(arr2[0] == null ? 0.0 : Double.parseDouble(arr2[0].toString()));
                //可提现金额的净额
                payTotal.setRealAmount(payTotal.getPayAmount()-payTotal.getExtractRefundAmount());

                //可提现金额
                payTotal.setExtractAmout(DoubleUtil.subtracting(payTotal.getRealAmount(),payTotal.getPoundage()));
            }

            //不可提现金额
            Object[] arr3 =pmShopPayTotalService.totalExtractAmount(2, step, payTotal,1);
            if(arr3 != null){
                //非结算金额
                payTotal.setNoExtractAmout(arr3[0] == null ? 0.0 : Double.parseDouble(arr3[0].toString()));
            }
            Object[] arr4 = pmShopPayTotalService.totalExtractAmount(2, step, payTotal, 2);
            if(arr4 != null){
                //非结算金额的退款金额
                payTotal.setNoExtractRefundAmount(arr4[0] == null ? 0.0 : Double.parseDouble(arr4[0].toString()));

                //非结算金额的净额
                payTotal.setNoExtractRealAmount(DoubleUtil.subtracting(payTotal.getNoExtractAmout(),payTotal.getNoExtractRefundAmount()));
            }


            pmShopPayTotalService.save(payTotal);
        }
    }
}
